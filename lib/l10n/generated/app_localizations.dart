import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @preferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesSection;

  /// No description provided for @supportSection.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportSection;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @accountVerification.
  ///
  /// In en, this message translates to:
  /// **'Account Verification'**
  String get accountVerification;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @aboutRentora.
  ///
  /// In en, this message translates to:
  /// **'About Rentora'**
  String get aboutRentora;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @keyFeatures.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get keyFeatures;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @unknownOwner.
  ///
  /// In en, this message translates to:
  /// **'Unknown Owner'**
  String get unknownOwner;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @notice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get notice;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @conversationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to start conversation. Please try again.'**
  String get conversationFailed;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get noProductsFound;

  /// No description provided for @firstItemPrompt.
  ///
  /// In en, this message translates to:
  /// **'Be the first to add an item here'**
  String get firstItemPrompt;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get addPhoto;

  /// No description provided for @addMainPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add main photo'**
  String get addMainPhoto;

  /// No description provided for @chooseClearPhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose a clear photo of your item'**
  String get chooseClearPhoto;

  /// No description provided for @mainPhoto.
  ///
  /// In en, this message translates to:
  /// **'Main photo'**
  String get mainPhoto;

  /// No description provided for @noRentalHistory.
  ///
  /// In en, this message translates to:
  /// **'No Rental History'**
  String get noRentalHistory;

  /// No description provided for @noRentalsYet.
  ///
  /// In en, this message translates to:
  /// **'You have not rented any items yet.'**
  String get noRentalsYet;

  /// No description provided for @orderCode.
  ///
  /// In en, this message translates to:
  /// **'Order Code: {code}'**
  String orderCode(Object code);

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// No description provided for @checkConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again'**
  String get checkConnection;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @exitConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit Rentora?'**
  String get exitConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @tryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get tryAgainLater;

  /// No description provided for @looksOffMap.
  ///
  /// In en, this message translates to:
  /// **'Looks like you\'re off the map'**
  String get looksOffMap;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist or has been moved'**
  String get pageNotFound;

  /// No description provided for @rentora.
  ///
  /// In en, this message translates to:
  /// **'Rentora'**
  String get rentora;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @noListingRentals.
  ///
  /// In en, this message translates to:
  /// **'No Listing Rentals Yet'**
  String get noListingRentals;

  /// No description provided for @verificationUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get verificationUnderReview;

  /// No description provided for @invalidChat.
  ///
  /// In en, this message translates to:
  /// **'Invalid Chat'**
  String get invalidChat;

  /// No description provided for @conversationNotLoaded.
  ///
  /// In en, this message translates to:
  /// **' requested conversation could not be loaded.'**
  String get conversationNotLoaded;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @sayHello.
  ///
  /// In en, this message translates to:
  /// **'Say hello to start the conversation!'**
  String get sayHello;

  /// No description provided for @loginToViewChats.
  ///
  /// In en, this message translates to:
  /// **'Login to View Chats'**
  String get loginToViewChats;

  /// No description provided for @noChatsYet.
  ///
  /// In en, this message translates to:
  /// **'No chats yet'**
  String get noChatsYet;

  /// No description provided for @imageSent.
  ///
  /// In en, this message translates to:
  /// **'Image sent successfully'**
  String get imageSent;

  /// No description provided for @selectDatesFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select dates first'**
  String get selectDatesFirst;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully logged in'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get registrationFailed;

  /// No description provided for @verifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyYourEmail;

  /// No description provided for @actionRequired.
  ///
  /// In en, this message translates to:
  /// **'Action Required'**
  String get actionRequired;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmail;

  /// No description provided for @resetFailed.
  ///
  /// In en, this message translates to:
  /// **'Reset Failed'**
  String get resetFailed;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent'**
  String get emailSent;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email'**
  String get resetLinkSent;

  /// No description provided for @requestDeclined.
  ///
  /// In en, this message translates to:
  /// **'Request Declined'**
  String get requestDeclined;

  /// No description provided for @requestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Request Accepted'**
  String get requestAccepted;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @noBio.
  ///
  /// In en, this message translates to:
  /// **'No bio added yet.'**
  String get noBio;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @writeBio.
  ///
  /// In en, this message translates to:
  /// **'Write something about yourself...'**
  String get writeBio;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @addListing.
  ///
  /// In en, this message translates to:
  /// **'Add Listing'**
  String get addListing;

  /// No description provided for @addListingOpening.
  ///
  /// In en, this message translates to:
  /// **'Add Listing feature opening...'**
  String get addListingOpening;

  /// No description provided for @noListings.
  ///
  /// In en, this message translates to:
  /// **'No Listings Available'**
  String get noListings;

  /// No description provided for @noItemsForRent.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any items for rent yet.'**
  String get noItemsForRent;

  /// No description provided for @somethingWentWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrongTitle;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred.'**
  String get anErrorOccurred;

  /// No description provided for @reviewPublish.
  ///
  /// In en, this message translates to:
  /// **'Review & Publish'**
  String get reviewPublish;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(Object current, Object total);

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @itemDetails.
  ///
  /// In en, this message translates to:
  /// **'Item Details'**
  String get itemDetails;

  /// No description provided for @rentalDetails.
  ///
  /// In en, this message translates to:
  /// **'Rental Details'**
  String get rentalDetails;

  /// No description provided for @locationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Location Not Found'**
  String get locationNotFound;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Location Required'**
  String get locationRequired;

  /// No description provided for @addPhotoStep.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhotoStep;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @useCamera.
  ///
  /// In en, this message translates to:
  /// **'Use camera'**
  String get useCamera;

  /// No description provided for @chooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseGallery;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload existing photo'**
  String get uploadPhoto;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue'**
  String get loginContinue;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @continueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueGoogle;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyAccount;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @passwordReset.
  ///
  /// In en, this message translates to:
  /// **'Password Reset'**
  String get passwordReset;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @searchItems.
  ///
  /// In en, this message translates to:
  /// **'Search items'**
  String get searchItems;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @searchHelp.
  ///
  /// In en, this message translates to:
  /// **'Search the Help Center...'**
  String get searchHelp;

  /// No description provided for @enterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter location'**
  String get enterLocation;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @supportChatSoon.
  ///
  /// In en, this message translates to:
  /// **'Support chat is coming soon!'**
  String get supportChatSoon;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @loginRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please log in first'**
  String get loginRequiredMessage;

  /// No description provided for @actionFailed.
  ///
  /// In en, this message translates to:
  /// **'Action Failed'**
  String get actionFailed;

  /// No description provided for @acceptRequest.
  ///
  /// In en, this message translates to:
  /// **'Accept Request'**
  String get acceptRequest;

  /// No description provided for @rejectRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get rejectRequest;

  /// No description provided for @bookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Booking Failed'**
  String get bookingFailed;

  /// No description provided for @selectDates.
  ///
  /// In en, this message translates to:
  /// **'Select Dates'**
  String get selectDates;

  /// No description provided for @availabilityRangeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select an availability range.'**
  String get availabilityRangeRequired;

  /// No description provided for @maximumPhotosReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum Photos Reached.'**
  String get maximumPhotosReached;

  /// No description provided for @maximumPhotosMessage.
  ///
  /// In en, this message translates to:
  /// **'The maximum number of photos has been reached.'**
  String get maximumPhotosMessage;

  /// No description provided for @incompleteInformation.
  ///
  /// In en, this message translates to:
  /// **'Incomplete Information'**
  String get incompleteInformation;

  /// No description provided for @itemDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Item details'**
  String get itemDetailsLabel;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemName;

  /// No description provided for @dailyPrice.
  ///
  /// In en, this message translates to:
  /// **'Daily price'**
  String get dailyPrice;

  /// No description provided for @securityDeposit.
  ///
  /// In en, this message translates to:
  /// **'Security deposit'**
  String get securityDeposit;

  /// No description provided for @itemConditionRating.
  ///
  /// In en, this message translates to:
  /// **'Item condition & Rating'**
  String get itemConditionRating;

  /// No description provided for @ratingRange.
  ///
  /// In en, this message translates to:
  /// **'Rating (0-5)'**
  String get ratingRange;

  /// No description provided for @keyFeaturesSelect.
  ///
  /// In en, this message translates to:
  /// **'Key Features (Select at least 3)'**
  String get keyFeaturesSelect;

  /// No description provided for @categoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Category Required'**
  String get categoryRequired;

  /// No description provided for @selectCategoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a category first'**
  String get selectCategoryFirst;

  /// No description provided for @detailsMethod.
  ///
  /// In en, this message translates to:
  /// **'Details Method'**
  String get detailsMethod;

  /// No description provided for @fillManually.
  ///
  /// In en, this message translates to:
  /// **'Fill Manually'**
  String get fillManually;

  /// No description provided for @enterDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter all details yourself'**
  String get enterDetails;

  /// No description provided for @autoFillAi.
  ///
  /// In en, this message translates to:
  /// **'Auto fill with AI'**
  String get autoFillAi;

  /// No description provided for @suggestDetails.
  ///
  /// In en, this message translates to:
  /// **'Let AI suggest details from photo'**
  String get suggestDetails;

  /// No description provided for @existingPhotos.
  ///
  /// In en, this message translates to:
  /// **'Existing photos'**
  String get existingPhotos;

  /// No description provided for @additionalPhotos.
  ///
  /// In en, this message translates to:
  /// **'Additional photos'**
  String get additionalPhotos;

  /// No description provided for @verificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Verification Required'**
  String get verificationRequired;

  /// No description provided for @verificationPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your verification is currently under review.'**
  String get verificationPendingMessage;

  /// No description provided for @loginRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequiredTitle;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please log in to continue.'**
  String get loginToContinue;

  /// No description provided for @unavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'This information is currently unavailable.'**
  String get unavailableMessage;

  /// No description provided for @cannotChatSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot start a chat with yourself.'**
  String get cannotChatSelf;

  /// No description provided for @chatError.
  ///
  /// In en, this message translates to:
  /// **'Failed to start conversation. Please try again.'**
  String get chatError;

  /// No description provided for @invalidChatMessage.
  ///
  /// In en, this message translates to:
  /// **'The requested conversation could not be loaded.'**
  String get invalidChatMessage;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessages;

  /// No description provided for @startConversation.
  ///
  /// In en, this message translates to:
  /// **'Say hello to start the conversation!'**
  String get startConversation;

  /// No description provided for @noChats.
  ///
  /// In en, this message translates to:
  /// **'No chats yet'**
  String get noChats;

  /// No description provided for @loginChatsMessage.
  ///
  /// In en, this message translates to:
  /// **'Please log in to view your chats.'**
  String get loginChatsMessage;

  /// No description provided for @requestActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Action Failed'**
  String get requestActionFailed;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept Request'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get reject;

  /// No description provided for @profileSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileSuccess;

  /// No description provided for @profileError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load profile'**
  String get profileError;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @noListingsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Listings Available'**
  String get noListingsAvailable;

  /// No description provided for @verificationIntro.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationIntro;

  /// No description provided for @faceScan.
  ///
  /// In en, this message translates to:
  /// **'Face Scan'**
  String get faceScan;

  /// No description provided for @uploadIdFront.
  ///
  /// In en, this message translates to:
  /// **'Upload ID Front'**
  String get uploadIdFront;

  /// No description provided for @uploadIdBack.
  ///
  /// In en, this message translates to:
  /// **'Upload ID Back'**
  String get uploadIdBack;

  /// No description provided for @fasterApprovals.
  ///
  /// In en, this message translates to:
  /// **'Faster Approvals'**
  String get fasterApprovals;

  /// No description provided for @higherRentalLimit.
  ///
  /// In en, this message translates to:
  /// **'Higher Rental Limit'**
  String get higherRentalLimit;

  /// No description provided for @validId.
  ///
  /// In en, this message translates to:
  /// **'Valid National ID or Residency Permit'**
  String get validId;

  /// No description provided for @clearBothSides.
  ///
  /// In en, this message translates to:
  /// **'A clear photo of both sides'**
  String get clearBothSides;

  /// No description provided for @quickFaceScan.
  ///
  /// In en, this message translates to:
  /// **'Quick Face Scan (Selfie)'**
  String get quickFaceScan;

  /// No description provided for @matchesId.
  ///
  /// In en, this message translates to:
  /// **'To verify that it matches your ID'**
  String get matchesId;

  /// No description provided for @fillDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill in your item details'**
  String get fillDetails;

  /// No description provided for @imageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Image sent successfully'**
  String get imageSentSuccessfully;

  /// No description provided for @removedFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from Favorites'**
  String get removedFavorites;

  /// No description provided for @addedFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to Favorites'**
  String get addedFavorites;

  /// No description provided for @rentalCost.
  ///
  /// In en, this message translates to:
  /// **'Rental Cost'**
  String get rentalCost;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @securityDepositLabel.
  ///
  /// In en, this message translates to:
  /// **'Security Deposit'**
  String get securityDepositLabel;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @supportChatComing.
  ///
  /// In en, this message translates to:
  /// **'Support chat is coming soon!'**
  String get supportChatComing;

  /// No description provided for @searchHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Search the Help Center...'**
  String get searchHelpCenter;

  /// No description provided for @searchItemsLabel.
  ///
  /// In en, this message translates to:
  /// **'Search items'**
  String get searchItemsLabel;

  /// No description provided for @enterLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter location'**
  String get enterLocationLabel;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @joinCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join our community today'**
  String get joinCommunity;

  /// No description provided for @agreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get agreeTo;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @agreeTermsFirst.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions first'**
  String get agreeTermsFirst;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @accountCreatedVerify.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully. We\'ve sent a verification link to your email. Please check your inbox and verify to log in.'**
  String get accountCreatedVerify;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyEmailTitle;

  /// No description provided for @loginRequiredChat.
  ///
  /// In en, this message translates to:
  /// **'Please log in first to chat.'**
  String get loginRequiredChat;

  /// No description provided for @renterUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Renter information is currently unavailable.'**
  String get renterUnavailable;

  /// No description provided for @chatWithSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot start a chat with yourself.'**
  String get chatWithSelf;

  /// No description provided for @actionFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Action Failed'**
  String get actionFailedTitle;

  /// No description provided for @requestDeclinedMessage.
  ///
  /// In en, this message translates to:
  /// **'The request was declined.'**
  String get requestDeclinedMessage;

  /// No description provided for @requestAcceptedMessage.
  ///
  /// In en, this message translates to:
  /// **'The request was accepted.'**
  String get requestAcceptedMessage;

  /// No description provided for @selectAvailability.
  ///
  /// In en, this message translates to:
  /// **'Select an availability range.'**
  String get selectAvailability;

  /// No description provided for @locationNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to find the selected location.'**
  String get locationNotFoundMessage;

  /// No description provided for @locationRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select a location.'**
  String get locationRequiredMessage;

  /// No description provided for @supportChatSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Support chat is coming soon!'**
  String get supportChatSoonMessage;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @loginConversations.
  ///
  /// In en, this message translates to:
  /// **'Please log in to your account to view your conversations and messages.'**
  String get loginConversations;

  /// No description provided for @emptyChats.
  ///
  /// In en, this message translates to:
  /// **'When you contact an owner or receive an inquiry, your conversations will appear here.'**
  String get emptyChats;

  /// No description provided for @addNewListing.
  ///
  /// In en, this message translates to:
  /// **'Add New Listing'**
  String get addNewListing;

  /// No description provided for @startWithPhoto.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start with a photo'**
  String get startWithPhoto;

  /// No description provided for @photoInstruction.
  ///
  /// In en, this message translates to:
  /// **'Take a clear photo of the item you want to rent out. This will be the main photo for your listing.'**
  String get photoInstruction;

  /// No description provided for @whenAvailable.
  ///
  /// In en, this message translates to:
  /// **'When is your item available?'**
  String get whenAvailable;

  /// No description provided for @availabilityInstruction.
  ///
  /// In en, this message translates to:
  /// **'Select the dates when renters can book your item.'**
  String get availabilityInstruction;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @daysCapitalized.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get daysCapitalized;

  /// No description provided for @tellAboutItem.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your item'**
  String get tellAboutItem;

  /// No description provided for @itemDetailsInstruction.
  ///
  /// In en, this message translates to:
  /// **'Add some details to help renters understand what you are offering.'**
  String get itemDetailsInstruction;

  /// No description provided for @itemNameExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Canon EOS R50 Camera'**
  String get itemNameExample;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the item, its features and condition...'**
  String get descriptionHint;

  /// No description provided for @completeRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields. Rating must be between 0.0 and 5.0, and at least 3 features must be selected.'**
  String get completeRequiredFields;

  /// No description provided for @securityDepositInfo.
  ///
  /// In en, this message translates to:
  /// **'The security deposit is held as protection against damage or loss and may be returned after the rental.'**
  String get securityDepositInfo;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @priceDetails.
  ///
  /// In en, this message translates to:
  /// **'Price Details'**
  String get priceDetails;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @chatTab.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTab;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @viewMap.
  ///
  /// In en, this message translates to:
  /// **'View Map'**
  String get viewMap;

  /// No description provided for @searchAnything.
  ///
  /// In en, this message translates to:
  /// **'Search for anything'**
  String get searchAnything;

  /// No description provided for @noProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available right now'**
  String get noProductsAvailable;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to Favorites'**
  String get addedToFavorites;

  /// No description provided for @distanceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Distance unknown'**
  String get distanceUnknown;

  /// No description provided for @perDay.
  ///
  /// In en, this message translates to:
  /// **'SAR/day'**
  String get perDay;

  /// No description provided for @sendImage.
  ///
  /// In en, this message translates to:
  /// **'Send Image'**
  String get sendImage;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @addCaption.
  ///
  /// In en, this message translates to:
  /// **'Add a caption...'**
  String get addCaption;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeMessage;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from Favorites'**
  String get removedFromFavorites;

  /// No description provided for @archiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive & Rentals'**
  String get archiveTitle;

  /// No description provided for @myRentals.
  ///
  /// In en, this message translates to:
  /// **'My Rentals'**
  String get myRentals;

  /// No description provided for @myListings.
  ///
  /// In en, this message translates to:
  /// **'My Listings'**
  String get myListings;

  /// No description provided for @pastHistoryLoginMessage.
  ///
  /// In en, this message translates to:
  /// **'Please log in to view your past rentals and listing history.'**
  String get pastHistoryLoginMessage;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @verificationUnderReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account verification is currently under review. This usually takes less than 24 hours.'**
  String get verificationUnderReviewMessage;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get enterLastName;

  /// No description provided for @enterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get enterValidPhone;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get enterUsername;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get enterValidEmail;

  /// No description provided for @enterPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get enterPasswordValidation;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least 8 characters, a symbol, and numbers'**
  String get passwordRequirements;

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get enterValue;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Need it?\nRent it'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Get high quality items for the time\nyou need, without buying'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Have something?\nShare it'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'List your items, set your price and\nearn when others rent'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Find it\nnear you'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Discover items around you from\npeople you trust'**
  String get onboardingDesc3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'just tell us\nwhat you need'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDesc4.
  ///
  /// In en, this message translates to:
  /// **'Our AI assistant finds the right\nmatch for you in seconds'**
  String get onboardingDesc4;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @interestsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What are your interests?'**
  String get interestsQuestion;

  /// No description provided for @interestsDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the categories you\'re interested in so we can personalize your experience and show you the most relevant items.'**
  String get interestsDescription;

  /// No description provided for @interestsSaved.
  ///
  /// In en, this message translates to:
  /// **'Your interests have been saved'**
  String get interestsSaved;

  /// No description provided for @chooseLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Location'**
  String get chooseLocationTitle;

  /// No description provided for @chooseLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us find items near you'**
  String get chooseLocationSubtitle;

  /// No description provided for @searchLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a location'**
  String get searchLocationHint;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// No description provided for @allowAccessOnce.
  ///
  /// In en, this message translates to:
  /// **'Allow access once'**
  String get allowAccessOnce;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @locationSaved.
  ///
  /// In en, this message translates to:
  /// **'location has been saved'**
  String get locationSaved;

  /// No description provided for @chooseDeliveryPoint.
  ///
  /// In en, this message translates to:
  /// **'Choose Delivery Point'**
  String get chooseDeliveryPoint;

  /// No description provided for @moveMapSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Move map to select location'**
  String get moveMapSelectLocation;

  /// No description provided for @categoryGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get categoryGaming;

  /// No description provided for @categoryCameras.
  ///
  /// In en, this message translates to:
  /// **'Cameras'**
  String get categoryCameras;

  /// No description provided for @categorySports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get categorySports;

  /// No description provided for @categoryElectronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get categoryElectronics;

  /// No description provided for @categoryTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get categoryTools;

  /// No description provided for @categoryCamping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get categoryCamping;

  /// No description provided for @categoryEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get categoryEquipment;

  /// No description provided for @categoryBooks.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get categoryBooks;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @categoryLaptops.
  ///
  /// In en, this message translates to:
  /// **'Laptops'**
  String get categoryLaptops;

  /// No description provided for @categoryTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// No description provided for @buildTrust.
  ///
  /// In en, this message translates to:
  /// **'Build Trust in the Community'**
  String get buildTrust;

  /// No description provided for @verificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Verifying your account with a few simple steps gives you a Verified Badge, speeds up request approvals, and gives you access to a higher rental limit'**
  String get verificationDescription;

  /// No description provided for @fasterApprovalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Owners prefer dealing with verified accounts'**
  String get fasterApprovalsDesc;

  /// No description provided for @higherRentalLimitDesc.
  ///
  /// In en, this message translates to:
  /// **'Rent higher value equipment without restrictions'**
  String get higherRentalLimitDesc;

  /// No description provided for @verificationRequirements.
  ///
  /// In en, this message translates to:
  /// **'Verification Requirements:'**
  String get verificationRequirements;

  /// No description provided for @startVerificationNow.
  ///
  /// In en, this message translates to:
  /// **'Start Verification Now'**
  String get startVerificationNow;

  /// No description provided for @dataEncryptedProtected.
  ///
  /// In en, this message translates to:
  /// **'Your data is encrypted and securely protected.'**
  String get dataEncryptedProtected;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get underReview;

  /// No description provided for @documentsReceived.
  ///
  /// In en, this message translates to:
  /// **'Documents Received'**
  String get documentsReceived;

  /// No description provided for @documentsReviewingMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'re reviewing your information. This usually takes less than 24 hours. We\'ll notify you once your identity has been verified'**
  String get documentsReviewingMessage;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @placeFaceCircle.
  ///
  /// In en, this message translates to:
  /// **'Please place your face inside the circle to securely verify your identity'**
  String get placeFaceCircle;

  /// No description provided for @verifyByRentora.
  ///
  /// In en, this message translates to:
  /// **'Verify by Rentora'**
  String get verifyByRentora;

  /// No description provided for @verifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verifying;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @tapToScan.
  ///
  /// In en, this message translates to:
  /// **'Tap to Scan'**
  String get tapToScan;

  /// No description provided for @placeFrontIdHere.
  ///
  /// In en, this message translates to:
  /// **'Place front ID here'**
  String get placeFrontIdHere;

  /// No description provided for @placeBackIdHere.
  ///
  /// In en, this message translates to:
  /// **'Place back ID here'**
  String get placeBackIdHere;

  /// No description provided for @uploadIdFrontSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please take a clear and readable photo of your ID front side. Make sure there are no reflections and all corners are visible within the frame.'**
  String get uploadIdFrontSubtitle;

  /// No description provided for @uploadIdBackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please take a clear and readable photo of your ID back side. Make sure there are no reflections and all corners are visible within the frame.'**
  String get uploadIdBackSubtitle;

  /// No description provided for @openingCamera.
  ///
  /// In en, this message translates to:
  /// **'Opening Camera'**
  String get openingCamera;

  /// No description provided for @submitDocuments.
  ///
  /// In en, this message translates to:
  /// **'Submit Documents'**
  String get submitDocuments;

  /// No description provided for @retakeFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Retake from Gallery'**
  String get retakeFromGallery;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help? '**
  String get needHelp;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @rentoraSupport.
  ///
  /// In en, this message translates to:
  /// **'Rentora Support'**
  String get rentoraSupport;

  /// No description provided for @rentoraSupportMessage.
  ///
  /// In en, this message translates to:
  /// **'Our support team is available 24/7 to assist you with your account verification.'**
  String get rentoraSupportMessage;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @loginRequiredContact.
  ///
  /// In en, this message translates to:
  /// **'Please log in first to contact the owner and start chatting.'**
  String get loginRequiredContact;

  /// No description provided for @ownerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Owner information is currently unavailable for this item.'**
  String get ownerUnavailable;

  /// No description provided for @cannotChatSelfListing.
  ///
  /// In en, this message translates to:
  /// **'You cannot start a chat with yourself for your own listing.'**
  String get cannotChatSelfListing;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @confirmDates.
  ///
  /// In en, this message translates to:
  /// **'Confirm Dates'**
  String get confirmDates;

  /// No description provided for @bookingSummary.
  ///
  /// In en, this message translates to:
  /// **'Booking Summary'**
  String get bookingSummary;

  /// No description provided for @sendRentalRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Rental Request'**
  String get sendRentalRequest;

  /// No description provided for @pickupMethod.
  ///
  /// In en, this message translates to:
  /// **'Pickup Method'**
  String get pickupMethod;

  /// No description provided for @personalPickup.
  ///
  /// In en, this message translates to:
  /// **'Personal pickup'**
  String get personalPickup;

  /// No description provided for @homeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Home delivery'**
  String get homeDelivery;

  /// No description provided for @meetOwnerLocation.
  ///
  /// In en, this message translates to:
  /// **'Meet the owner at a specific location'**
  String get meetOwnerLocation;

  /// No description provided for @safeDeliveryDoorstep.
  ///
  /// In en, this message translates to:
  /// **'Safe delivery to your doorstep'**
  String get safeDeliveryDoorstep;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @pickupTimeNotice.
  ///
  /// In en, this message translates to:
  /// **'The exact pickup time will be arranged with the owner after your request is confirmed.'**
  String get pickupTimeNotice;

  /// No description provided for @deliveryChargesNotice.
  ///
  /// In en, this message translates to:
  /// **'Delivery charges may apply and will be confirmed after your request is approved.'**
  String get deliveryChargesNotice;

  /// No description provided for @confirmMethod.
  ///
  /// In en, this message translates to:
  /// **'Confirm Method'**
  String get confirmMethod;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose a payment method'**
  String get choosePaymentMethod;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @payAfterConfirmed.
  ///
  /// In en, this message translates to:
  /// **'You will pay the amount after the request is confirmed.'**
  String get payAfterConfirmed;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @bookingConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed !'**
  String get bookingConfirmedTitle;

  /// No description provided for @sentBookingRequestOwner.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent your booking request to the owner.'**
  String get sentBookingRequestOwner;

  /// No description provided for @stepOwnerReview.
  ///
  /// In en, this message translates to:
  /// **'The owner will review and confirm your request (usually within 2 hours).'**
  String get stepOwnerReview;

  /// No description provided for @stepNotificationStatus.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you on the status via email and in-app notification.'**
  String get stepNotificationStatus;

  /// No description provided for @stepConfirmPayment.
  ///
  /// In en, this message translates to:
  /// **'We\'ll confirm the payment after the request is confirmed as you can complete the payment.'**
  String get stepConfirmPayment;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @rentalRequest.
  ///
  /// In en, this message translates to:
  /// **'Rental Request'**
  String get rentalRequest;

  /// No description provided for @incomingRequest.
  ///
  /// In en, this message translates to:
  /// **'Incoming Request'**
  String get incomingRequest;

  /// No description provided for @reviewRentalRequestDesc.
  ///
  /// In en, this message translates to:
  /// **'Review the rental request details before accepting or rejecting.'**
  String get reviewRentalRequestDesc;

  /// No description provided for @renterInformation.
  ///
  /// In en, this message translates to:
  /// **'Renter Information'**
  String get renterInformation;

  /// No description provided for @loginRequiredChatRenter.
  ///
  /// In en, this message translates to:
  /// **'Please log in first to chat with the renter.'**
  String get loginRequiredChatRenter;

  /// No description provided for @totalRentalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Rental Earnings'**
  String get totalRentalEarnings;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @totalBookings.
  ///
  /// In en, this message translates to:
  /// **'Total Bookings'**
  String get totalBookings;

  /// No description provided for @activeRentals.
  ///
  /// In en, this message translates to:
  /// **'Active Rentals'**
  String get activeRentals;

  /// No description provided for @noListingRentalsMessage.
  ///
  /// In en, this message translates to:
  /// **'When people rent your listed items, history and income will appear here.'**
  String get noListingRentalsMessage;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @minPrice.
  ///
  /// In en, this message translates to:
  /// **'Min Price'**
  String get minPrice;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recentSearches;

  /// No description provided for @tryChangingSearchFilters.
  ///
  /// In en, this message translates to:
  /// **'Try changing your search or filters.'**
  String get tryChangingSearchFilters;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get howCanWeHelp;

  /// No description provided for @searchHelpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search for articles, guides, and more.'**
  String get searchHelpSubtitle;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @noFaqResults.
  ///
  /// In en, this message translates to:
  /// **'No results found. Try a different search.'**
  String get noFaqResults;

  /// No description provided for @helpRenting.
  ///
  /// In en, this message translates to:
  /// **'Renting'**
  String get helpRenting;

  /// No description provided for @helpGettingStarted.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get helpGettingStarted;

  /// No description provided for @helpPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get helpPayments;

  /// No description provided for @helpLending.
  ///
  /// In en, this message translates to:
  /// **'Lending'**
  String get helpLending;

  /// No description provided for @helpAccountManagement.
  ///
  /// In en, this message translates to:
  /// **'Account Management'**
  String get helpAccountManagement;

  /// No description provided for @helpSafetyTrust.
  ///
  /// In en, this message translates to:
  /// **'Safety & Trust'**
  String get helpSafetyTrust;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @verifiedOwner.
  ///
  /// In en, this message translates to:
  /// **'Verified Owner'**
  String get verifiedOwner;

  /// No description provided for @verificationPending.
  ///
  /// In en, this message translates to:
  /// **'Verification Pending'**
  String get verificationPending;

  /// No description provided for @verificationRejected.
  ///
  /// In en, this message translates to:
  /// **'Verification Rejected'**
  String get verificationRejected;

  /// No description provided for @unverifiedOwner.
  ///
  /// In en, this message translates to:
  /// **'Unverified Owner'**
  String get unverifiedOwner;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @noUnreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'No unread notifications'**
  String get noUnreadNotifications;

  /// No description provided for @noReadNotifications.
  ///
  /// In en, this message translates to:
  /// **'No read notifications'**
  String get noReadNotifications;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get chooseCategory;

  /// No description provided for @selectCategoryMatch.
  ///
  /// In en, this message translates to:
  /// **'Select the category that\nbest matches your item'**
  String get selectCategoryMatch;

  /// No description provided for @categoryHelpMatch.
  ///
  /// In en, this message translates to:
  /// **'This helps us show your item to the right people.'**
  String get categoryHelpMatch;

  /// No description provided for @onlyOneCategory.
  ///
  /// In en, this message translates to:
  /// **'You can only choose one category.'**
  String get onlyOneCategory;

  /// No description provided for @howAddDetails.
  ///
  /// In en, this message translates to:
  /// **'How would you like to add details?'**
  String get howAddDetails;

  /// No description provided for @detailsMethodDesc.
  ///
  /// In en, this message translates to:
  /// **'You can fill in the details manually or let our AI suggest them based on your photo.'**
  String get detailsMethodDesc;

  /// No description provided for @addPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'Add photos of your item'**
  String get addPhotosTitle;

  /// No description provided for @addPhotosDesc.
  ///
  /// In en, this message translates to:
  /// **'Good photos help renters understand your item and increase your chances of getting booked.'**
  String get addPhotosDesc;

  /// No description provided for @addMorePhotosAngles.
  ///
  /// In en, this message translates to:
  /// **'Add more photos from different angles.'**
  String get addMorePhotosAngles;

  /// No description provided for @photoTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Use clear photos in good lighting and show the item from different angles.'**
  String get photoTip;

  /// No description provided for @reviewListing.
  ///
  /// In en, this message translates to:
  /// **'Review your listing'**
  String get reviewListing;

  /// No description provided for @reviewListingDesc.
  ///
  /// In en, this message translates to:
  /// **'Make sure everything looks good before publishing.'**
  String get reviewListingDesc;

  /// No description provided for @publishListing.
  ///
  /// In en, this message translates to:
  /// **'Publish Listing'**
  String get publishListing;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @listingPublishedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Listing Published!'**
  String get listingPublishedSuccess;

  /// No description provided for @listingPublishedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your item is now live and available for rent.'**
  String get listingPublishedMessage;

  /// No description provided for @conditionNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get conditionNew;

  /// No description provided for @conditionLikeNew.
  ///
  /// In en, this message translates to:
  /// **'Like New'**
  String get conditionLikeNew;

  /// No description provided for @conditionExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get conditionExcellent;

  /// No description provided for @conditionGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get conditionGood;

  /// No description provided for @conditionFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get conditionFair;

  /// No description provided for @featureWireless.
  ///
  /// In en, this message translates to:
  /// **'Wireless'**
  String get featureWireless;

  /// No description provided for @featurePortable.
  ///
  /// In en, this message translates to:
  /// **'Portable'**
  String get featurePortable;

  /// No description provided for @featureHD4K.
  ///
  /// In en, this message translates to:
  /// **'HD 4K'**
  String get featureHD4K;

  /// No description provided for @featureBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get featureBluetooth;

  /// No description provided for @featureWaterproof.
  ///
  /// In en, this message translates to:
  /// **'Waterproof'**
  String get featureWaterproof;

  /// No description provided for @featureRechargeable.
  ///
  /// In en, this message translates to:
  /// **'Rechargeable'**
  String get featureRechargeable;

  /// No description provided for @featureLightweight.
  ///
  /// In en, this message translates to:
  /// **'Lightweight'**
  String get featureLightweight;

  /// No description provided for @featureHeavyDuty.
  ///
  /// In en, this message translates to:
  /// **'Heavy Duty'**
  String get featureHeavyDuty;

  /// No description provided for @enterEmailResetDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address associated with your account and we\'ll send you a link to reset your password.'**
  String get enterEmailResetDescription;

  /// No description provided for @verificationAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Account verification'**
  String get verificationAppBarTitle;

  /// No description provided for @verificationBuildTrust.
  ///
  /// In en, this message translates to:
  /// **'Build Trust in the Community'**
  String get verificationBuildTrust;

  /// No description provided for @verificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verifying your account with a few simple steps gives you a Verified Badge, speeds up request approvals, and gives you access to a higher rental limit'**
  String get verificationSubtitle;

  /// No description provided for @verificationFasterApprovals.
  ///
  /// In en, this message translates to:
  /// **'Faster Approvals'**
  String get verificationFasterApprovals;

  /// No description provided for @verificationFasterApprovalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Owners prefer dealing with verified accounts'**
  String get verificationFasterApprovalsDesc;

  /// No description provided for @verificationHigherRentalLimit.
  ///
  /// In en, this message translates to:
  /// **'Higher Rental Limit'**
  String get verificationHigherRentalLimit;

  /// No description provided for @verificationHigherRentalLimitDesc.
  ///
  /// In en, this message translates to:
  /// **'Rent higher value equipment without restrictions'**
  String get verificationHigherRentalLimitDesc;

  /// No description provided for @verificationValidId.
  ///
  /// In en, this message translates to:
  /// **'Valid National ID or Residency Permit'**
  String get verificationValidId;

  /// No description provided for @verificationClearBothSides.
  ///
  /// In en, this message translates to:
  /// **'A clear photo of both sides'**
  String get verificationClearBothSides;

  /// No description provided for @verificationQuickFaceScan.
  ///
  /// In en, this message translates to:
  /// **'Quick Face Scan (Selfie)'**
  String get verificationQuickFaceScan;

  /// No description provided for @verificationMatchesId.
  ///
  /// In en, this message translates to:
  /// **'To verify that it matches your ID'**
  String get verificationMatchesId;

  /// No description provided for @verificationDocumentsReceived.
  ///
  /// In en, this message translates to:
  /// **'Documents Received'**
  String get verificationDocumentsReceived;

  /// No description provided for @verificationPendingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'re reviewing your information. This usually takes less than 24 hours. We\'ll notify you once your identity has been verified'**
  String get verificationPendingSubtitle;

  /// No description provided for @verificationNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get verificationNeedHelp;

  /// No description provided for @verificationContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get verificationContactSupport;

  /// No description provided for @verificationDataSecurity.
  ///
  /// In en, this message translates to:
  /// **'Your data is encrypted and securely protected.'**
  String get verificationDataSecurity;

  /// No description provided for @verificationRequirementsLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification Requirements:'**
  String get verificationRequirementsLabel;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @imageFormatLimit.
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG, GIF. Max 5 MB.'**
  String get imageFormatLimit;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailCannotBeChanged.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be changed'**
  String get emailCannotBeChanged;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountType;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @noInterestsSelected.
  ///
  /// In en, this message translates to:
  /// **'No interests selected yet.'**
  String get noInterestsSelected;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get characters;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
