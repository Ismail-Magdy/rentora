# Rentora : AI Powered P2P Rental Marketplace

Rentora is a smart Peer-to-Peer (P2P) rental platform designed to promote the sharing economy. It allows users to securely rent out items they rarely use and helps others find affordable short term rentals. Powered by AI, Rentora offers a seamless, secure, and intuitive user experience.

---

## Business Flow & Core Features

### 1. Authentication & Onboarding

- **Sign Up / Login:** Users can register using Email, Password, Name, and Phone Number, along with a mandatory "Terms & Conditions" agreement check. Google Sign-In and Forgot Password functionalities are also supported.
- **Profile Setup:** Users set their default location and select their interests (categories). The interests step can be skipped (stored as `null`/empty).

### 2. Home & Discovery

- **Home Screen:** Displays the user's current location at the top, followed by a horizontal list of Categories.
- **Items Grid:** Under the categories, a 2-column grid displays available items. Each item card shows the main image, title, rating, and the distance between the owner and the user.
- **Map View:** A floating "Show Map" button opens an interactive map displaying nearby available items for rent based on the user's location.
- **Smart Search:** An AI-powered search bar allowing users to search using natural language (e.g., "I need a camera for tomorrow"). It starts with an empty state and populates with AI-filtered results.

### 3. Item Details & Booking

- **Item Details Screen:** Features an image slider (1 main image + up to 4 additional images). Displays title, location, daily price, rating, description, and key features.
- **Owner Card:** Displays the owner's name and default avatar (updatable in settings), along with a contact option.
- **Availability Calendar:** A calendar showing the exact dates the item is available for rent.
- **Action Buttons:** "Rent Now" and a "Favorite" heart icon.
- **Booking Summary:** If the user proceeds, they review the selected dates, daily price, security deposit, and total amount.
- **Checkout:** The handover method is strictly "Meetup", and the payment method is currently "Cash Only".
- **Order Confirmation:** Generates a unique Order Code (e.g., RNTR-1045) and displays a success screen.

### 4. Verification System (Trust & Safety)

- **Strict Policy:** Users can browse the app, but **cannot rent or list items** without a verified account.
- **Verification Process:** Requires uploading a Selfie and an ID card (Front & Back). The status is reviewed and monitored by the admin dashboard.

### 5. Adding a Listing (For Owners)

- **Pre-requisite:** The owner must be fully verified.
- **AI Auto-Fill vs. Manual:** The owner uploads the main image. They can choose to fill details manually or let the AI automatically extract and suggest the Title, Description, Daily Price, Category, and Security Deposit.
- **Additional Images:** Upload up to 4 extra images.
- **Review & Availability:** Review the details, agree to terms, select available dates from a calendar, and publish.

### 6. Notifications & Chat

- **Booking Requests:** The owner receives a notification containing booking details. They can Accept or Reject.
- **Status Updates:** The renter receives a notification regarding the owner's decision.
- **Real-Time Chat:** If accepted, a chat session opens between the two parties to arrange the meetup and handover details.

### 7. Settings & Profile

- **Profile Editing:** Users can update their avatar, phone number, and bio (Email is unchangeable).
- **Verification Status:** A dedicated tab showing the user's current verification status and prompting them to verify if they haven't yet.

---

## Database Architecture (Firebase Firestore - NoSQL)

The following schema is designed to support Clean Architecture, ensure high performance, and handle relational data efficiently in a NoSQL environment.

### 1. `users` Collection

Stores standard user profile data.

- `userId`: (String) Firebase Auth UID.
- `name`: (String) Full name.
- `email`: (String) Unchangeable email address.
- `phoneNumber`: (String) Contact number.
- `avatarUrl`: (String) Cloudinary image URL (Nullable).
- `bio`: (String) User biography.
- `location`: (GeoPoint + String) Coordinates and area name.
- `geohash`: (String) Required for Firebase distance-based geo-queries.
- `interests`: (List of Strings) Selected categories (empty list if skipped).
- `verificationStatus`: (String) 'unverified', 'pending', 'verified', 'rejected'.
- `agreedToTerms`: (Boolean) True if accepted during signup.
- `fcmToken`: (String) Firebase Cloud Messaging token for targeting notifications.
- `createdAt`: (Timestamp) Account creation date.

### 2. `verifications` Collection

Separated from the `users` collection for high-level security of sensitive documents.

- `verificationId`: (String) Matches the `userId`.
- `selfieUrl`: (String) Selfie image URL.
- `idFrontUrl`: (String) ID Front image URL.
- `idBackUrl`: (String) ID Back image URL.
- `status`: (String) 'pending', 'verified', 'rejected'.
- `submittedAt`: (Timestamp)

### 3. `listings` Collection

Stores all items available for rent.

- `listingId`: (String) Auto-generated document ID.
- `ownerId`: (String) Refers to the item owner's `userId`.
- `categoryId`: (String) Refers to the category.
- `title`: (String) Item name.
- `description`: (String) Item description.
- `keyFeatures`: (List of Strings) Key specifications.
- `mainImage`: (String) Cloudinary URL.
- `additionalImages`: (List of Strings) Up to 4 Cloudinary URLs.
- `dailyPrice`: (Number) Cost per day.
- `securityDeposit`: (Number) Required deposit amount.
- `location`: (GeoPoint) Handover location coordinates.
- `geohash`: (String) For Map rendering and nearby queries.
- `rating`: (Number) Overall item rating (starts at 0).
- `availableDates`: (List of Strings) e.g., `['2026-08-15', '2026-08-16']`.
- `agreedToTerms`: (Boolean)
- `createdAt`: (Timestamp)

### 4. `bookings` Collection

Manages the rental lifecycle from request to completion.

- `bookingId`: (String) Auto-generated ID.
- `orderCode`: (String) User-friendly unique code (e.g., RNTR-1045).
- `listingId`: (String) Refers to the rented item.
- `renterId`: (String) The user requesting the item.
- `ownerId`: (String) The owner of the item.
- `startDate`: (String)
- `endDate`: (String)
- `totalDays`: (Number)
- `dailyPrice`: (Number) Snapshot of the price at the time of booking.
- `securityDeposit`: (Number)
- `totalAmount`: (Number)
- `paymentMethod`: (String) Currently strictly 'cash'.
- `handoverMethod`: (String) Currently strictly 'meetup'.
- `status`: (String) 'pending', 'accepted', 'rejected', 'completed'.
- `createdAt`: (Timestamp)

### 5. `chats` Collection

Real-time messaging between users post-booking approval.

- `chatId`: (String) Unique identifier.
- `bookingId`: (String) The booking context for the chat.
- `participants`: (List of Strings) Contains `renterId` and `ownerId`.
- `lastMessage`: (String) For inbox preview.
- `lastMessageTime`: (Timestamp)
- **Subcollection: `messages`**
  - `messageId`: (String)
  - `senderId`: (String)
  - `text`: (String)
  - `timestamp`: (Timestamp)

### 6. User Subcollections

Stored inside `users/{userId}/...` to optimize reads and limit data payloads.

- **`favorites` Subcollection:**
  - `listingId`: (String) Stored as Document ID.
  - `createdAt`: (Timestamp)
- **`notifications` Subcollection:**
  - `notificationId`: (String)
  - `title`: (String)
  - `body`: (String)
  - `type`: (String) 'booking', 'chat', 'verification'.
  - `isRead`: (Boolean)
  - `createdAt`: (Timestamp)

---

## Executive Summary & Key Rules

1. **Mandatory Verification:** No user can rent an item or list an item without an approved ID and Selfie verification. Unverified users have "View Only" access.
2. **Payment & Handover:** For this MVP, transactions are strictly "Cash Only" and handovers are strictly in-person "Meetups".
3. **AI Integration:** AI is a core utility used for Smart Searching (NLP) and Auto-filling listing data to reduce friction for owners.
4. **Chat Privacy:** Chat functionality is locked and only initiates after a booking request has been officially accepted by the item owner.
5. **Image Management:** All images are uploaded via Cloudinary, and only their String URLs are saved in Firestore to optimize Firebase storage costs.
