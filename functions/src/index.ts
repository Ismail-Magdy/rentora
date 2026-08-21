import { setGlobalOptions } from "firebase-functions";
import * as admin from "firebase-admin";
import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";
import * as logger from "firebase-functions/logger";

admin.initializeApp();
const db = admin.firestore();

setGlobalOptions({ maxInstances: 10 });

// Helper to send FCM and save notification
async function notifyUser(
  receiverId: string,
  title: string,
  body: string,
  type: string,
  relatedId: string
) {
  try {
    // 1. Save notification to Firestore
    const notificationRef = db.collection(`users/${receiverId}/notifications`).doc();
    await notificationRef.set({
      id: notificationRef.id,
      title,
      body,
      type,
      relatedId,
      isRead: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // 2. Fetch user's FCM token
    const userDoc = await db.collection("users").doc(receiverId).get();
    if (userDoc.exists) {
      const fcmToken = userDoc.data()?.fcmToken;
      if (fcmToken) {
        // 3. Send FCM
        await admin.messaging().send({
          token: fcmToken,
          notification: {
            title,
            body,
          },
          data: {
            type,
            relatedId,
          },
        });
        logger.info(`FCM sent to user ${receiverId}`);
      } else {
        logger.info(`User ${receiverId} has no fcmToken`);
      }
    }
  } catch (error) {
    logger.error("Error in notifyUser:", error);
  }
}

// 1. onNewMessage
export const onNewMessage = onDocumentCreated("chats/{chatId}/messages/{messageId}", async (event) => {
  const snapshot = event.data;
  if (!snapshot) return;

  const message = snapshot.data();
  const senderId = message.senderId;
  const chatId = event.params.chatId;

  try {
    const chatDoc = await db.collection("chats").doc(chatId).get();
    if (!chatDoc.exists) return;

    const chatData = chatDoc.data();
    const participants: string[] = chatData?.participants || [];
    const receiverId = participants.find((id) => id !== senderId);

    if (receiverId) {
      await notifyUser(
        receiverId,
        "New Message",
        message.text || "You received a new photo.",
        "chat",
        chatId
      );
    }
  } catch (error) {
    logger.error("Error processing onNewMessage:", error);
  }
});

// 2. onBookingRequested
export const onBookingRequested = onDocumentCreated("bookings/{bookingId}", async (event) => {
  const snapshot = event.data;
  if (!snapshot) return;

  const booking = snapshot.data();
  const ownerId = booking.ownerId;
  const bookingId = event.params.bookingId;

  if (ownerId) {
    await notifyUser(
      ownerId,
      "New Booking Request",
      "You have a new request for your listing.",
      "booking",
      bookingId
    );
  }
});

// 3. onBookingStatusChanged
export const onBookingStatusChanged = onDocumentUpdated("bookings/{bookingId}", async (event) => {
  const before = event.data?.before.data();
  const after = event.data?.after.data();
  if (!before || !after) return;

  const bookingId = event.params.bookingId;
  const renterId = after.renterId;

  if (before.status !== after.status && renterId) {
    await notifyUser(
      renterId,
      "Booking Status Updated",
      `Your booking status is now: ${after.status}`,
      "booking",
      bookingId
    );
  }
});
