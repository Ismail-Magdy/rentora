# Rentora : AI Powered P2P Rental Marketplace

Rentora is a smart Peer-to-Peer (P2P) rental platform designed to promote the sharing economy. It allows users to securely rent out items they rarely use and helps others find affordable short term rentals. Powered by AI, Rentora offers a seamless, secure, and intuitive user experience.

---

## Development Roadmap

To ensure a streamlined development process and deliver a robust product, development is divided into two main phases, prioritizing Core/MVP functionality first.

---

### Phase 1: Core App & MVP (Building the Foundation)

**Goal:** Establish the essential rental cycle. Focus on user onboarding, security through verification, and the basic listing/booking flow.

1. **Core App + Splash:** Initial project setup, theming, and dependency injection layer.
2. **Onboarding:** Initial user introduction screens.
3. **Auth:** Sign up, Login, Forgot Password (Common, standard flow).
4. **Profile Setup:** Mandatory location setting and interest (category) selection.
5. **Verification System (Manual Flow):** **(Blocker Feature)** Implement the flow for uploading Selfie and ID (Front/Back) for admin review. Essential for security rules.
6. **Home:** Displaying products based on categories.
7. **Item Details:** Detailed view of listed items and images.
8. **Add Item (Manual Flow):** Camera/Gallery integration, manual data entry for listing details, date selection via calendar, and publishing.
9. **Rental Details:** Date selection, booking summary, and handover details.
10. **Payment:** Standardizing the 'Cash on Delivery' selection flow.
11. **Rental Request:** Flow for sending requests, owner acceptance, and rejection screens.

### Phase 2: Advanced Features, AI Integration & Engagement

**Goal:** Enhance user experience, introduce AI capabilities for automation, and build engagement tools.

1.  **Smart Search + AI:** Implementing NLP-based search to find items based on natural language queries.
2.  **Add Item (AI Auto-fill):** Integrating AI to automatically populate listing details (title, description, price) from the main image.
3.  **Verification (AI Integration):** Adding Face Matching or ID OCR capabilities to automate the verification process.
4.  **Show Map:** Interactive map view using GeoQueries to find nearby items.
5.  **Real-Time Chat:** Implementing direct messaging between parties after a booking is accepted.
6.  **Notifications:** Integrating Firebase Cloud Messaging (FCM) for real-time alerts (booking requests, chat messages).
7.  **Favorite:** Ability to save items for later.
8.  **Settings:** Detailed profile editing, Help center, and 'About Us' section.

---

## Software Architecture

Rentora follows a **Lite Clean Architecture** approach, specifically modified for feature-based development (Feature-First). This provides a balance between structure and development speed, reducing boilerplate for standard features while maintaining maintainability.

The layer structure within each feature is as follows:

```text
feature_name/
├── data/
│   ├── models/ # Data transfer objects (JSON serialization/deserialization)
│   └── repos/  # Implementation of repositories handling data logic (interacting withFirebase Services)
├── manager/
│   └── cubit/ # BLoC (Cubit) implementation for state management, linking UI and Data logic
└── presentation/
    ├── screens/ # Main screen widgets
    └── widgets/ # Component-level widgets specific to the feature
```

---

## 🛠️ Core App Architecture (Cross-Feature)

Outside of specific features, the core directory houses shared services and logic. Notably, the Network layer contains the generic services that features interact with through their Repositories.

Generic Network Services (Wrappers)
These services are registered as Lazy Singletons via GetIt (Dependency Injection) and accept Firebase instances via constructor injection for testability.

FirebaseAuthService: Handles signup, login, password resets, and sign-out.

UsersFirestoreService: Manages CRUD operations for user profiles and user subcollections.

VerificationsFirestoreService: Handles sensitive ID upload data links and status checks.

ListingsFirestoreService: Manages item creation, fetching for Home grids, and category filtering.

BookingsFirestoreService: Manages the rental lifecycle (request creation, owner approval, status updates).

ChatsFirestoreService: Handles real-time chat room creation and message streams.

## CloudinaryService: Responsible for uploading raw image files to Cloudinary and returning secure URLs (using Dio).

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
