// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get themeLabel => 'المظهر';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get accountSection => 'الحساب';

  @override
  String get preferencesSection => 'التفضيلات';

  @override
  String get supportSection => 'الدعم';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get viewProfile => 'عرض الملف الشخصي';

  @override
  String get accountVerification => 'التحقق من الحساب';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get aboutRentora => 'عن Rentora';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmation => 'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get availability => 'التوافر';

  @override
  String get keyFeatures => 'المميزات الأساسية';

  @override
  String get description => 'الوصف';

  @override
  String get location => 'الموقع';

  @override
  String get unknownOwner => 'مالك غير معروف';

  @override
  String get loginRequired => 'تسجيل الدخول مطلوب';

  @override
  String get unavailable => 'غير متاح';

  @override
  String get notice => 'تنبيه';

  @override
  String get error => 'خطأ';

  @override
  String get conversationFailed => 'تعذر بدء المحادثة. حاول مرة أخرى.';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get firstItemPrompt => 'كن أول من يضيف عنصرًا هنا';

  @override
  String get or => 'أو';

  @override
  String get add => 'إضافة';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get addMainPhoto => 'إضافة الصورة الرئيسية';

  @override
  String get chooseClearPhoto => 'اختر صورة واضحة للعنصر';

  @override
  String get mainPhoto => 'الصورة الرئيسية';

  @override
  String get noRentalHistory => 'لا يوجد سجل إيجارات';

  @override
  String get noRentalsYet => 'لم تقم باستئجار أي عناصر بعد.';

  @override
  String orderCode(Object code) {
    return 'رمز الطلب: $code';
  }

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get checkConnection => 'يرجى التحقق من الاتصال والمحاولة مرة أخرى';

  @override
  String get exitApp => 'الخروج من التطبيق';

  @override
  String get exitConfirmation => 'هل أنت متأكد من رغبتك في الخروج من Rentora؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get exit => 'خروج';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get tryAgainLater => 'يرجى المحاولة مرة أخرى لاحقًا';

  @override
  String get looksOffMap => 'يبدو أنك خارج الخريطة';

  @override
  String get pageNotFound => 'الصفحة التي تبحث عنها غير موجودة أو تم نقلها';

  @override
  String get rentora => 'Rentora';

  @override
  String get day => 'يوم';

  @override
  String get noListingRentals => 'لا توجد إيجارات للقوائم بعد';

  @override
  String get verificationUnderReview => 'قيد المراجعة';

  @override
  String get invalidChat => 'محادثة غير صالحة';

  @override
  String get conversationNotLoaded => 'تعذر تحميل المحادثة المطلوبة.';

  @override
  String get noMessagesYet => 'لا توجد رسائل بعد';

  @override
  String get sayHello => 'ابدأ المحادثة بإلقاء التحية!';

  @override
  String get loginToViewChats => 'سجل الدخول لعرض المحادثات';

  @override
  String get noChatsYet => 'لا توجد محادثات بعد';

  @override
  String get imageSent => 'تم إرسال الصورة بنجاح';

  @override
  String get selectDatesFirst => 'يرجى اختيار التواريخ أولًا';

  @override
  String get success => 'تم بنجاح';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get registrationFailed => 'فشل التسجيل';

  @override
  String get verifyYourEmail => 'تحقق من بريدك الإلكتروني';

  @override
  String get actionRequired => 'إجراء مطلوب';

  @override
  String get enterFullName => 'أدخل اسمك بالكامل';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get resetFailed => 'فشل إعادة التعيين';

  @override
  String get emailSent => 'تم إرسال البريد الإلكتروني';

  @override
  String get resetLinkSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني';

  @override
  String get requestDeclined => 'تم رفض الطلب';

  @override
  String get requestAccepted => 'تم قبول الطلب';

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get bio => 'نبذة شخصية';

  @override
  String get noBio => 'لم تتم إضافة نبذة بعد.';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get yourName => 'اسمك';

  @override
  String get writeBio => 'اكتب شيئًا عن نفسك...';

  @override
  String get oops => 'عذرًا!';

  @override
  String get addListing => 'إضافة إعلان';

  @override
  String get addListingOpening => 'سيتم فتح ميزة إضافة الإعلان...';

  @override
  String get noListings => 'لا توجد إعلانات متاحة';

  @override
  String get noItemsForRent => 'لم تضف أي عناصر للإيجار بعد.';

  @override
  String get somethingWentWrongTitle => 'حدث خطأ ما';

  @override
  String get anErrorOccurred => 'حدث خطأ.';

  @override
  String get reviewPublish => 'المراجعة والنشر';

  @override
  String stepOf(Object current, Object total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get photos => 'الصور';

  @override
  String get itemDetails => 'تفاصيل العنصر';

  @override
  String get rentalDetails => 'تفاصيل الإيجار';

  @override
  String get locationNotFound => 'لم يتم العثور على الموقع';

  @override
  String get locationRequired => 'الموقع مطلوب';

  @override
  String get addPhotoStep => 'إضافة صورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get useCamera => 'استخدام الكاميرا';

  @override
  String get chooseGallery => 'اختيار من المعرض';

  @override
  String get uploadPhoto => 'رفع صورة موجودة';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get loginContinue => 'سجل الدخول للمتابعة';

  @override
  String get forgetPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get continueGoogle => 'المتابعة باستخدام Google';

  @override
  String get registration => 'التسجيل';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get alreadyAccount => 'لديك حساب بالفعل؟';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get passwordReset => 'إعادة تعيين كلمة المرور';

  @override
  String get close => 'إغلاق';

  @override
  String get searchItems => 'ابحث عن عناصر';

  @override
  String get filters => 'الفلاتر';

  @override
  String get searchHelp => 'ابحث في مركز المساعدة...';

  @override
  String get enterLocation => 'أدخل الموقع';

  @override
  String get category => 'الفئة';

  @override
  String get priceRange => 'نطاق السعر';

  @override
  String get condition => 'الحالة';

  @override
  String get supportChatSoon => 'محادثة الدعم ستكون متاحة قريبًا!';

  @override
  String get welcome => 'مرحبًا';

  @override
  String get loginRequiredMessage => 'يرجى تسجيل الدخول أولًا';

  @override
  String get actionFailed => 'فشل الإجراء';

  @override
  String get acceptRequest => 'قبول الطلب';

  @override
  String get rejectRequest => 'رفض الطلب';

  @override
  String get bookingFailed => 'فشل الحجز';

  @override
  String get selectDates => 'اختيار التواريخ';

  @override
  String get availabilityRangeRequired => 'يرجى اختيار نطاق التوافر.';

  @override
  String get maximumPhotosReached => 'تم الوصول إلى الحد الأقصى للصور.';

  @override
  String get maximumPhotosMessage => 'تم الوصول إلى الحد الأقصى لعدد الصور.';

  @override
  String get incompleteInformation => 'معلومات غير مكتملة';

  @override
  String get itemDetailsLabel => 'تفاصيل العنصر';

  @override
  String get itemName => 'اسم العنصر';

  @override
  String get dailyPrice => 'السعر اليومي';

  @override
  String get securityDeposit => 'التأمين';

  @override
  String get itemConditionRating => 'حالة العنصر والتقييم';

  @override
  String get ratingRange => 'التقييم (0-5)';

  @override
  String get keyFeaturesSelect => 'المميزات الأساسية (اختر 3 على الأقل)';

  @override
  String get categoryRequired => 'الفئة مطلوبة';

  @override
  String get selectCategoryFirst => 'يرجى اختيار الفئة أولًا';

  @override
  String get detailsMethod => 'طريقة إدخال التفاصيل';

  @override
  String get fillManually => 'ملء يدويًا';

  @override
  String get enterDetails => 'أدخل جميع التفاصيل بنفسك';

  @override
  String get autoFillAi => 'الملء التلقائي بالذكاء الاصطناعي';

  @override
  String get suggestDetails => 'دع الذكاء الاصطناعي يقترح التفاصيل من الصورة';

  @override
  String get existingPhotos => 'الصور الحالية';

  @override
  String get additionalPhotos => 'صور إضافية';

  @override
  String get verificationRequired => 'التحقق مطلوب';

  @override
  String get verificationPendingMessage => 'عملية التحقق قيد المراجعة حاليًا.';

  @override
  String get loginRequiredTitle => 'تسجيل الدخول مطلوب';

  @override
  String get loginToContinue => 'يرجى تسجيل الدخول للمتابعة.';

  @override
  String get unavailableMessage => 'هذه المعلومات غير متاحة حاليًا.';

  @override
  String get cannotChatSelf => 'لا يمكنك بدء محادثة مع نفسك.';

  @override
  String get chatError => 'تعذر بدء المحادثة. حاول مرة أخرى.';

  @override
  String get invalidChatMessage => 'تعذر تحميل المحادثة المطلوبة.';

  @override
  String get noMessages => 'لا توجد رسائل بعد';

  @override
  String get startConversation => 'ابدأ المحادثة بإلقاء التحية!';

  @override
  String get noChats => 'لا توجد محادثات بعد';

  @override
  String get loginChatsMessage => 'يرجى تسجيل الدخول لعرض محادثاتك.';

  @override
  String get requestActionFailed => 'فشل الإجراء';

  @override
  String get accept => 'قبول الطلب';

  @override
  String get reject => 'رفض الطلب';

  @override
  String get profileSuccess => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get profileError => 'تعذر تحميل الملف الشخصي';

  @override
  String get personalInfo => 'المعلومات الشخصية';

  @override
  String get noListingsAvailable => 'لا توجد إعلانات متاحة';

  @override
  String get verificationIntro => 'التحقق';

  @override
  String get faceScan => 'فحص الوجه';

  @override
  String get uploadIdFront => 'رفع الوجه الأمامي للهوية';

  @override
  String get uploadIdBack => 'رفع الوجه الخلفي للهوية';

  @override
  String get fasterApprovals => 'موافقات أسرع';

  @override
  String get higherRentalLimit => 'حد إيجار أعلى';

  @override
  String get validId => 'هوية وطنية أو إقامة سارية';

  @override
  String get clearBothSides => 'صورة واضحة للوجهين';

  @override
  String get quickFaceScan => 'فحص سريع للوجه (سيلفي)';

  @override
  String get matchesId => 'للتأكد من مطابقته لهويتك';

  @override
  String get fillDetails => 'أدخل تفاصيل العنصر';

  @override
  String get imageSentSuccessfully => 'تم إرسال الصورة بنجاح';

  @override
  String get removedFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get addedFavorites => 'تمت الإضافة إلى المفضلة';

  @override
  String get rentalCost => 'تكلفة الإيجار';

  @override
  String get serviceFee => 'رسوم الخدمة';

  @override
  String get securityDepositLabel => 'مبلغ التأمين';

  @override
  String get sar => 'ريال';

  @override
  String get days => 'أيام';

  @override
  String get selectLocation => 'اختيار الموقع';

  @override
  String get supportChatComing => 'محادثة الدعم ستكون متاحة قريبًا!';

  @override
  String get searchHelpCenter => 'ابحث في مركز المساعدة...';

  @override
  String get searchItemsLabel => 'ابحث عن عناصر';

  @override
  String get enterLocationLabel => 'أدخل الموقع';

  @override
  String get createAccountTitle => 'إنشاء حساب';

  @override
  String get joinCommunity => 'انضم إلى مجتمعنا اليوم';

  @override
  String get agreeTo => 'أوافق على';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get and => 'و';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get agreeTermsFirst => 'يرجى الموافقة على الشروط والأحكام أولًا';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get accountCreatedVerify =>
      'تم إنشاء الحساب بنجاح. أرسلنا رابط التحقق إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد لتسجيل الدخول.';

  @override
  String get verifyEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get loginRequiredChat => 'يرجى تسجيل الدخول أولًا للدردشة.';

  @override
  String get renterUnavailable => 'معلومات المستأجر غير متاحة حاليًا.';

  @override
  String get chatWithSelf => 'لا يمكنك بدء محادثة مع نفسك.';

  @override
  String get actionFailedTitle => 'فشل الإجراء';

  @override
  String get requestDeclinedMessage => 'تم رفض الطلب.';

  @override
  String get requestAcceptedMessage => 'تم قبول الطلب.';

  @override
  String get selectAvailability => 'اختر نطاق التوافر.';

  @override
  String get locationNotFoundMessage => 'تعذر العثور على الموقع المحدد.';

  @override
  String get locationRequiredMessage => 'يرجى اختيار موقع.';

  @override
  String get supportChatSoonMessage => 'محادثة الدعم ستكون متاحة قريبًا!';

  @override
  String get chats => 'المحادثات';

  @override
  String get user => 'مستخدم';

  @override
  String get chat => 'محادثة';

  @override
  String get loginConversations => 'يرجى تسجيل الدخول لعرض محادثاتك ورسائلك.';

  @override
  String get emptyChats =>
      'عند التواصل مع مالك أو استلام استفسار، ستظهر محادثاتك هنا.';

  @override
  String get addNewListing => 'إضافة إعلان جديد';

  @override
  String get startWithPhoto => 'لنبدأ بصورة';

  @override
  String get photoInstruction =>
      'التقط صورة واضحة للعنصر الذي تريد تأجيره. ستكون هذه الصورة الرئيسية لإعلانك.';

  @override
  String get whenAvailable => 'متى يكون العنصر متاحًا؟';

  @override
  String get availabilityInstruction =>
      'اختر التواريخ التي يمكن للمستأجرين حجز العنصر فيها.';

  @override
  String get continueButton => 'متابعة';

  @override
  String get daysCapitalized => 'أيام';

  @override
  String get tellAboutItem => 'أخبرنا عن عنصرك';

  @override
  String get itemDetailsInstruction =>
      'أضف بعض التفاصيل لمساعدة المستأجرين على فهم ما تقدمه.';

  @override
  String get itemNameExample => 'مثال: كاميرا Canon EOS R50';

  @override
  String get descriptionHint => 'صف العنصر ومميزاته وحالته...';

  @override
  String get completeRequiredFields =>
      'يرجى إكمال جميع الحقول المطلوبة. يجب أن يكون التقييم بين 0.0 و5.0، واختيار 3 مميزات على الأقل.';

  @override
  String get securityDepositInfo =>
      'يُحتفظ بمبلغ التأمين للحماية من التلف أو الفقدان، وقد يُعاد بعد انتهاء الإيجار.';

  @override
  String get next => 'التالي';

  @override
  String get priceDetails => 'تفاصيل السعر';

  @override
  String get total => 'الإجمالي';

  @override
  String get home => 'الرئيسية';

  @override
  String get chatTab => 'المحادثة';

  @override
  String get archive => 'الأرشيف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get viewMap => 'عرض الخريطة';

  @override
  String get searchAnything => 'ابحث عن أي شيء';

  @override
  String get noProductsAvailable => 'لا توجد منتجات متاحة حاليًا';

  @override
  String get addedToFavorites => 'تمت الإضافة إلى المفضلة';

  @override
  String get distanceUnknown => 'المسافة غير معروفة';

  @override
  String get perDay => 'ريال/يوم';

  @override
  String get sendImage => 'إرسال صورة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get addCaption => 'أضف تعليقًا...';

  @override
  String get typeMessage => 'اكتب رسالتك...';

  @override
  String get removedFromFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get archiveTitle => 'الأرشيف والإيجارات';

  @override
  String get myRentals => 'إيجاراتي';

  @override
  String get myListings => 'إعلاناتي';

  @override
  String get pastHistoryLoginMessage =>
      'يرجى تسجيل الدخول لعرض سجل إيجاراتك وإعلاناتك السابقة.';

  @override
  String get goBack => 'الرجوع';

  @override
  String get verificationUnderReviewMessage =>
      'التحقق من حسابك قيد المراجعة حاليًا. يستغرق هذا عادة أقل من 24 ساعة.';

  @override
  String get enterFirstName => 'يرجى إدخال اسمك الأول';

  @override
  String get enterLastName => 'يرجى إدخال اسم العائلة';

  @override
  String get enterValidPhone => 'يرجى إدخال رقم هاتف صالح';

  @override
  String get enterUsername => 'يرجى إدخال اسم المستخدم';

  @override
  String get enterValidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get enterPasswordValidation => 'يرجى إدخال كلمة المرور';

  @override
  String get passwordRequirements =>
      'يجب أن تحتوي على 8 أحرف على الأقل ورمز وأرقام';

  @override
  String get enterValue => 'يرجى إدخال قيمة';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get onboardingTitle1 => 'محتاج حاجة؟\nأجرها';

  @override
  String get onboardingDesc1 =>
      'احصل على منتجات عالية الجودة للمدة التي تحتاجها دون الشراء';

  @override
  String get onboardingTitle2 => 'عندك حاجة؟\nشاركها';

  @override
  String get onboardingDesc2 => 'اعرض منتجاتك، حدد سعرك واكسب عند تأجيرها';

  @override
  String get onboardingTitle3 => 'اعثر عليها\nبالقرب منك';

  @override
  String get onboardingDesc3 => 'اكتشف المنتجات من حولك ومن أشخاص تثق بهم';

  @override
  String get onboardingTitle4 => 'فقط أخبرنا\nبما تحتاجه';

  @override
  String get onboardingDesc4 =>
      'مساعد الذكاء الاصطناعي يجد لك الخيار المناسب في ثوانٍ';

  @override
  String get skip => 'تخطي';

  @override
  String get interestsQuestion => 'ما هي اهتماماتك؟';

  @override
  String get interestsDescription =>
      'اختر الفئات التي تهتم بها لنخصص تجربتك ونعرض لك المنتجات الأكثر ملاءمة.';

  @override
  String get interestsSaved => 'تم حفظ اهتماماتك بنجاح';

  @override
  String get chooseLocationTitle => 'اختر موقعك';

  @override
  String get chooseLocationSubtitle =>
      'يساعدنا هذا في العثور على المنتجات القريبة منك';

  @override
  String get searchLocationHint => 'ابحث عن موقع';

  @override
  String get useCurrentLocation => 'استخدام الموقع الحالي';

  @override
  String get allowAccessOnce => 'السماح بالوصول مرة واحدة';

  @override
  String get confirmLocation => 'تأكيد الموقع';

  @override
  String get locationSaved => 'تم حفظ الموقع بنجاح';

  @override
  String get chooseDeliveryPoint => 'اختر نقطة الاستلام';

  @override
  String get moveMapSelectLocation => 'حرك الخريطة لتحديد الموقع';

  @override
  String get categoryGaming => 'ألعاب';

  @override
  String get categoryCameras => 'كاميرات';

  @override
  String get categorySports => 'رياضة';

  @override
  String get categoryElectronics => 'إلكترونيات';

  @override
  String get categoryTools => 'أدوات';

  @override
  String get categoryCamping => 'تخييم';

  @override
  String get categoryEquipment => 'معدات';

  @override
  String get categoryBooks => 'كتب';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get categoryLaptops => 'حواسيب محمولة';

  @override
  String get categoryTravel => 'سفر';

  @override
  String get buildTrust => 'ابنِ الثقة في المجتمع';

  @override
  String get verificationDescription =>
      'التحقق من حسابك بخطوات بسيطة يمنحك شارة التوثيق، ويسرع قبول الطلبات، ويتيح لك حد تأجير أعلى';

  @override
  String get fasterApprovalsDesc => 'يفضل المالكون التعامل مع الحسابات الموثقة';

  @override
  String get higherRentalLimitDesc => 'استأجر معدات ذات قيمة أعلى دون قيود';

  @override
  String get verificationRequirements => 'متطلبات التحقق:';

  @override
  String get startVerificationNow => 'ابدأ التحقق الآن';

  @override
  String get dataEncryptedProtected => 'بياناتك مشفرة ومحمية بأمان.';

  @override
  String get underReview => 'قيد المراجعة';

  @override
  String get documentsReceived => 'تم استلام المستندات';

  @override
  String get documentsReviewingMessage =>
      'نقوم بمراجعة معلوماتك. يستغرق هذا عادة أقل من 24 ساعة. سنخبرك بمجرد التحقق من هويتك';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get placeFaceCircle =>
      'يرجى وضع وجهك داخل الدائرة للتحقق من هويتك بأمان';

  @override
  String get verifyByRentora => 'توثيق بواسطة Rentora';

  @override
  String get verifying => 'جارٍ التحقق...';

  @override
  String get verified => 'تم التوثيق';

  @override
  String get tapToScan => 'اضغط للمسح';

  @override
  String get placeFrontIdHere => 'ضع الوجه الأمامي للهوية هنا';

  @override
  String get placeBackIdHere => 'ضع الوجه الخلفي للهوية هنا';

  @override
  String get uploadIdFrontSubtitle =>
      'يرجى التقاط صورة واضحة ومقروءة للوجه الأمامي لبطاقة الهوية. تأكد من عدم وجود انعكاسات ورؤية جميع الزوايا داخل الإطار.';

  @override
  String get uploadIdBackSubtitle =>
      'يرجى التقاط صورة واضحة ومقروءة للوجه الخلفي لبطاقة الهوية. تأكد من عدم وجود انعكاسات ورؤية جميع الزوايا داخل الإطار.';

  @override
  String get openingCamera => 'فتح الكاميرا';

  @override
  String get submitDocuments => 'إرسال المستندات';

  @override
  String get retakeFromGallery => 'إعادة الاختيار من المعرض';

  @override
  String get needHelp => 'تحتاج مساعدة؟ ';

  @override
  String get contactSupport => 'تواصل مع الدعم';

  @override
  String get rentoraSupport => 'دعم Rentora';

  @override
  String get rentoraSupportMessage =>
      'فريق الدعم لدينا متاح 24/7 لمساعدتك في التحقق من حسابك.';

  @override
  String get categories => 'الفئات';

  @override
  String get contact => 'تواصل';

  @override
  String get loginRequiredContact =>
      'يرجى تسجيل الدخول أولاً للتواصل مع المالك وبدء المحادثة.';

  @override
  String get ownerUnavailable => 'معلومات المالك غير متاحة حاليًا لهذا العنصر.';

  @override
  String get cannotChatSelfListing =>
      'لا يمكنك بدء محادثة مع نفسك لإعلانك الخاص.';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get confirmDates => 'تأكيد التواريخ';

  @override
  String get bookingSummary => 'ملخص الحجز';

  @override
  String get sendRentalRequest => 'إرسال طلب التأجير';

  @override
  String get pickupMethod => 'طريقة الاستلام';

  @override
  String get personalPickup => 'استلام شخصي';

  @override
  String get homeDelivery => 'توصيل للمنزل';

  @override
  String get meetOwnerLocation => 'مقابلة المالك في موقع محدد';

  @override
  String get safeDeliveryDoorstep => 'توصيل آمن إلى باب منزلك';

  @override
  String get free => 'مجاني';

  @override
  String get pickupTimeNotice =>
      'سيتم ترتيب وقت الاستلام بدقة مع المالك بعد تأكيد طلبك.';

  @override
  String get deliveryChargesNotice =>
      'قد تنطبق رسوم التوصيل وسيتم تأكيدها بعد قبول طلبك.';

  @override
  String get confirmMethod => 'تأكيد الطريقة';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get choosePaymentMethod => 'اختر طريقة الدفع';

  @override
  String get cash => 'نقدًا';

  @override
  String get payAfterConfirmed => 'ستدفع المبلغ بعد تأكيد الطلب.';

  @override
  String get confirmPayment => 'تأكيد الدفع';

  @override
  String get bookingConfirmedTitle => 'تم تأكيد الحجز!';

  @override
  String get sentBookingRequestOwner =>
      'لقد أرسلنا طلب الحجز الخاص بك إلى المالك.';

  @override
  String get stepOwnerReview =>
      'سيقوم المالك بمراجعة طلبك وتأكيده (عادة خلال ساعتين).';

  @override
  String get stepNotificationStatus =>
      'سنخطرك بالحالة عبر البريد الإلكتروني وإشعارات التطبيق.';

  @override
  String get stepConfirmPayment =>
      'سنؤكد الدفع بعد تأكيد الطلب حيث يمكنك إتمام عملية الدفع.';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get rentalRequest => 'طلب تأجير';

  @override
  String get incomingRequest => 'طلب وارد';

  @override
  String get reviewRentalRequestDesc =>
      'راجع تفاصيل طلب التأجير قبل القبول أو الرفض.';

  @override
  String get renterInformation => 'معلومات المستأجر';

  @override
  String get loginRequiredChatRenter =>
      'يرجى تسجيل الدخول أولاً للمحادثة مع المستأجر.';

  @override
  String get totalRentalEarnings => 'إجمالي أرباح التأجير';

  @override
  String get income => 'الدخل';

  @override
  String get totalBookings => 'إجمالي الحجوزات';

  @override
  String get activeRentals => 'إيجارات نشطة';

  @override
  String get noListingRentalsMessage =>
      'عندما يستأجر الأشخاص عناصرك المعروضة، سيظهر السجل والدخل هنا.';

  @override
  String get all => 'الكل';

  @override
  String get favoritesTitle => 'المفضلة';

  @override
  String get clear => 'مسح';

  @override
  String get applyFilters => 'تطبيق الفلاتر';

  @override
  String get minPrice => 'أقل سعر';

  @override
  String get maxPrice => 'أعلى سعر';

  @override
  String get recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get tryChangingSearchFilters => 'جرب تغيير البحث أو الفلاتر.';

  @override
  String get howCanWeHelp => 'كيف يمكننا مساعدتك؟';

  @override
  String get searchHelpSubtitle => 'ابحث عن المقالات والأدلة والمزيد.';

  @override
  String get frequentlyAskedQuestions => 'الأسئلة الشائعة';

  @override
  String get noFaqResults => 'لم يتم العثور على نتائج. جرب بحثًا مختلفًا.';

  @override
  String get helpRenting => 'الاستئجار';

  @override
  String get helpGettingStarted => 'البدء';

  @override
  String get helpPayments => 'المدفوعات';

  @override
  String get helpLending => 'التأجير';

  @override
  String get helpAccountManagement => 'إدارة الحساب';

  @override
  String get helpSafetyTrust => 'الأمان والثقة';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get verifiedOwner => 'مالك موثق';

  @override
  String get verificationPending => 'التحقق قيد الانتظار';

  @override
  String get verificationRejected => 'تم رفض التحقق';

  @override
  String get unverifiedOwner => 'مالك غير موثق';

  @override
  String get unread => 'غير مقروءة';

  @override
  String get read => 'مقروءة';

  @override
  String get noUnreadNotifications => 'لا توجد إشعارات غير مقروءة';

  @override
  String get noReadNotifications => 'لا توجد إشعارات مقروءة';

  @override
  String get chooseCategory => 'اختر الفئة';

  @override
  String get selectCategoryMatch => 'اختر الفئة التي\nتناسب عنصرك تمامًا';

  @override
  String get categoryHelpMatch => 'يساعدنا هذا في عرض عنصرك للأشخاص المناسبين.';

  @override
  String get onlyOneCategory => 'يمكنك اختيار فئة واحدة فقط.';

  @override
  String get howAddDetails => 'كيف ترغب في إضافة التفاصيل؟';

  @override
  String get detailsMethodDesc =>
      'يمكنك ملء التفاصيل يدويًا أو ترك الذكاء الاصطناعي يقترحها بناءً على صورتك.';

  @override
  String get addPhotosTitle => 'أضف صورًا لعنصرك';

  @override
  String get addPhotosDesc =>
      'الصور الجيدة تساعد المستأجرين على فهم عنصرك وتزيد من فرص الحجز.';

  @override
  String get addMorePhotosAngles => 'أضف المزيد من الصور من زوايا مختلفة.';

  @override
  String get photoTip =>
      'نصيحة: استخدم صورًا واضحة في إضاءة جيدة وأظهر العنصر من زوايا مختلفة.';

  @override
  String get reviewListing => 'راجع إعلانك';

  @override
  String get reviewListingDesc => 'تأكد من أن كل شيء يبدو رائعًا قبل النشر.';

  @override
  String get publishListing => 'نشر الإعلان';

  @override
  String get saving => 'جارٍ الحفظ...';

  @override
  String get updating => 'جارٍ التحديث...';

  @override
  String get listingPublishedSuccess => 'تم نشر الإعلان!';

  @override
  String get listingPublishedMessage => 'عنصرك الآن متاح للإيجار على التطبيق.';

  @override
  String get conditionNew => 'جديد';

  @override
  String get conditionLikeNew => 'كالجديد';

  @override
  String get conditionExcellent => 'ممتاز';

  @override
  String get conditionGood => 'جيد';

  @override
  String get conditionFair => 'مقبول';

  @override
  String get featureWireless => 'لاسلكي';

  @override
  String get featurePortable => 'محمول';

  @override
  String get featureHD4K => 'دقة عالية 4K';

  @override
  String get featureBluetooth => 'بلوتوث';

  @override
  String get featureWaterproof => 'مقاوم للماء';

  @override
  String get featureRechargeable => 'قابل لإعادة الشحن';

  @override
  String get featureLightweight => 'خفيف الوزن';

  @override
  String get featureHeavyDuty => 'استخدام شاق';

  @override
  String get enterEmailResetDescription =>
      'أدخل عنوان البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get verificationAppBarTitle => 'التحقق من الحساب';

  @override
  String get verificationBuildTrust => 'ابنِ الثقة في المجتمع';

  @override
  String get verificationSubtitle =>
      'التحقق من حسابك بخطوات بسيطة يمنحك شارة التوثيق، ويسرع قبول الطلبات، ويتيح لك حد تأجير أعلى';

  @override
  String get verificationFasterApprovals => 'موافقات أسرع';

  @override
  String get verificationFasterApprovalsDesc =>
      'يفضل المالكون التعامل مع الحسابات الموثقة';

  @override
  String get verificationHigherRentalLimit => 'حد إيجار أعلى';

  @override
  String get verificationHigherRentalLimitDesc =>
      'استأجر معدات ذات قيمة أعلى دون قيود';

  @override
  String get verificationValidId => 'هوية وطنية أو إقامة سارية';

  @override
  String get verificationClearBothSides => 'صورة واضحة للوجهين';

  @override
  String get verificationQuickFaceScan => 'فحص سريع للوجه (سيلفي)';

  @override
  String get verificationMatchesId => 'للتأكد من مطابقته لهويتك';

  @override
  String get verificationDocumentsReceived => 'تم استلام المستندات';

  @override
  String get verificationPendingSubtitle =>
      'نقوم بمراجعة معلوماتك. يستغرق هذا عادة أقل من 24 ساعة. سنخبرك بمجرد التحقق من هويتك';

  @override
  String get verificationNeedHelp => 'تحتاج مساعدة؟';

  @override
  String get verificationContactSupport => 'تواصل مع الدعم';

  @override
  String get verificationDataSecurity => 'بياناتك مشفرة ومحمية بأمان.';

  @override
  String get verificationRequirementsLabel => 'متطلبات التحقق:';

  @override
  String get changeProfilePicture => 'تغيير صورة الملف الشخصي';

  @override
  String get imageFormatLimit => 'JPG, PNG, GIF. الحد الأقصى 5 ميجابايت.';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get emailCannotBeChanged => 'لا يمكن تغيير البريد الإلكتروني';

  @override
  String get accountType => 'نوع الحساب';

  @override
  String get interests => 'الاهتمامات';

  @override
  String get noInterestsSelected => 'لم يتم اختيار اهتمامات بعد.';

  @override
  String get characters => 'حروف';

  @override
  String get unverified => 'غير موثق';
}
