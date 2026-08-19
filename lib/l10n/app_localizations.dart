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
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @leavesRequest.
  ///
  /// In en, this message translates to:
  /// **'Leaves Request'**
  String get leavesRequest;

  /// No description provided for @complaintRequest.
  ///
  /// In en, this message translates to:
  /// **'Complaint Request'**
  String get complaintRequest;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @hotelNews.
  ///
  /// In en, this message translates to:
  /// **'Hotel News'**
  String get hotelNews;

  /// No description provided for @yourTasks.
  ///
  /// In en, this message translates to:
  /// **'Your Tasks'**
  String get yourTasks;

  /// No description provided for @goodluckwithyourtasks.
  ///
  /// In en, this message translates to:
  /// **'Good luck with your tasks'**
  String get goodluckwithyourtasks;

  /// No description provided for @rawanAidy.
  ///
  /// In en, this message translates to:
  /// **'Rawan Aidy'**
  String get rawanAidy;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @taptoviewdetails.
  ///
  /// In en, this message translates to:
  /// **'Tap to view details'**
  String get taptoviewdetails;

  /// No description provided for @organizemotivateachieve.
  ///
  /// In en, this message translates to:
  /// **'Organize.Motivate.Achieve'**
  String get organizemotivateachieve;

  /// No description provided for @luxihotel.
  ///
  /// In en, this message translates to:
  /// **'LuxeTasks'**
  String get luxihotel;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welcometo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to your hotel staff task manager!'**
  String get welcometo;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @motivation.
  ///
  /// In en, this message translates to:
  /// **'motivation'**
  String get motivation;

  /// No description provided for @workflow.
  ///
  /// In en, this message translates to:
  /// **'workflow'**
  String get workflow;

  /// No description provided for @continue1.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue1;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @sendLeaveRequest.
  ///
  /// In en, this message translates to:
  /// **'send Leave Request'**
  String get sendLeaveRequest;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'reason'**
  String get reason;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'type'**
  String get type;

  /// No description provided for @ex.
  ///
  /// In en, this message translates to:
  /// **'ex .. sick , travel'**
  String get ex;

  /// No description provided for @whyyouareneedaleave.
  ///
  /// In en, this message translates to:
  /// **'why you are need a leave'**
  String get whyyouareneedaleave;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendComplaint.
  ///
  /// In en, this message translates to:
  /// **'Send Complaint'**
  String get sendComplaint;

  /// No description provided for @complainttitle.
  ///
  /// In en, this message translates to:
  /// **'Complaint title'**
  String get complainttitle;

  /// No description provided for @complaintdescription.
  ///
  /// In en, this message translates to:
  /// **'Complaint description'**
  String get complaintdescription;

  /// No description provided for @passwordresetsuccessful.
  ///
  /// In en, this message translates to:
  /// **'Password reset successful'**
  String get passwordresetsuccessful;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @passwordStrength.
  ///
  /// In en, this message translates to:
  /// **'Password Strength'**
  String get passwordStrength;

  /// No description provided for @passwordsmatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords match'**
  String get passwordsmatch;

  /// No description provided for @passwordsdontmatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsdontmatch;

  /// No description provided for @passwordmustcontain.
  ///
  /// In en, this message translates to:
  /// **'Password must contain:'**
  String get passwordmustcontain;

  /// No description provided for @atleastoneuppercaseletter.
  ///
  /// In en, this message translates to:
  /// **'At least one uppercase letter'**
  String get atleastoneuppercaseletter;

  /// No description provided for @atleastonelowercaseletter.
  ///
  /// In en, this message translates to:
  /// **'At least one lowercase letter'**
  String get atleastonelowercaseletter;

  /// No description provided for @atleastonenumber.
  ///
  /// In en, this message translates to:
  /// **'At least one number'**
  String get atleastonenumber;

  /// No description provided for @atleastonespecialcharacter.
  ///
  /// In en, this message translates to:
  /// **'At least one special character'**
  String get atleastonespecialcharacter;

  /// No description provided for @minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get minimum;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @failedtosendOTP.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP'**
  String get failedtosendOTP;

  /// No description provided for @pleaseenteryouremail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseenteryouremail;

  /// No description provided for @tosendOTP.
  ///
  /// In en, this message translates to:
  /// **'to send OTP'**
  String get tosendOTP;

  /// No description provided for @sendOTP.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOTP;

  /// No description provided for @forgetpassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetpassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @oTPsentagain.
  ///
  /// In en, this message translates to:
  /// **'OTP sent again'**
  String get oTPsentagain;

  /// No description provided for @enterOTP.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOTP;

  /// No description provided for @wehave.
  ///
  /// In en, this message translates to:
  /// **'We have sent an OTP to your email for verification'**
  String get wehave;

  /// No description provided for @didntreceiveOTP.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive OTP?'**
  String get didntreceiveOTP;

  /// No description provided for @resendit.
  ///
  /// In en, this message translates to:
  /// **'Resend it'**
  String get resendit;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'wait'**
  String get wait;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enteremail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enteremail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your day, perfectly organized'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LuxeTasks – where hotel excellence meets effortless task management'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Manage tasks effortlessly'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Stay on top of your day with intelligent task organization and real-time updates'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Feel accomplished. Stay motivated.'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Excel together with your team. Celebrate wins and track your progress'**
  String get onboardingDesc3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Never miss an important task'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDesc4.
  ///
  /// In en, this message translates to:
  /// **'Stay in control with smart reminders and seamless workflow management'**
  String get onboardingDesc4;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get done;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get left;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @chooseYourTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Theme'**
  String get chooseYourTheme;

  /// No description provided for @selectapalettethatfitsyourmood.
  ///
  /// In en, this message translates to:
  /// **'Select a palette that fits your mood.'**
  String get selectapalettethatfitsyourmood;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @guide_page_title.
  ///
  /// In en, this message translates to:
  /// **'Hotel Department Guide'**
  String get guide_page_title;

  /// No description provided for @guide_page_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the department you want to learn about'**
  String get guide_page_subtitle;

  /// No description provided for @main_departments.
  ///
  /// In en, this message translates to:
  /// **'Main Departments'**
  String get main_departments;

  /// No description provided for @good_to_know.
  ///
  /// In en, this message translates to:
  /// **'Good to Know'**
  String get good_to_know;

  /// No description provided for @reception_title.
  ///
  /// In en, this message translates to:
  /// **'Reception'**
  String get reception_title;

  /// No description provided for @reception_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Guest reception and reservations'**
  String get reception_subtitle;

  /// No description provided for @reception_details_0.
  ///
  /// In en, this message translates to:
  /// **'Welcoming guests on arrival and handling check-in'**
  String get reception_details_0;

  /// No description provided for @reception_details_1.
  ///
  /// In en, this message translates to:
  /// **'Managing and confirming reservations'**
  String get reception_details_1;

  /// No description provided for @reception_details_2.
  ///
  /// In en, this message translates to:
  /// **'Providing tourist information and hotel services'**
  String get reception_details_2;

  /// No description provided for @reception_details_3.
  ///
  /// In en, this message translates to:
  /// **'Handling guest complaints and inquiries'**
  String get reception_details_3;

  /// No description provided for @reception_details_4.
  ///
  /// In en, this message translates to:
  /// **'Processing check-out and issuing invoices'**
  String get reception_details_4;

  /// No description provided for @reception_details_5.
  ///
  /// In en, this message translates to:
  /// **'Coordinating with housekeeping on room readiness'**
  String get reception_details_5;

  /// No description provided for @reception_details_6.
  ///
  /// In en, this message translates to:
  /// **'Managing key cards and guest safety deposits'**
  String get reception_details_6;

  /// No description provided for @housekeeping_title.
  ///
  /// In en, this message translates to:
  /// **'Housekeeping'**
  String get housekeeping_title;

  /// No description provided for @housekeeping_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Room cleanliness and public areas'**
  String get housekeeping_subtitle;

  /// No description provided for @housekeeping_details_0.
  ///
  /// In en, this message translates to:
  /// **'Daily cleaning and preparation of rooms'**
  String get housekeeping_details_0;

  /// No description provided for @housekeeping_details_1.
  ///
  /// In en, this message translates to:
  /// **'Maintaining public areas and hallways'**
  String get housekeeping_details_1;

  /// No description provided for @housekeeping_details_2.
  ///
  /// In en, this message translates to:
  /// **'Restocking in-room amenities'**
  String get housekeeping_details_2;

  /// No description provided for @housekeeping_details_3.
  ///
  /// In en, this message translates to:
  /// **'Overseeing laundry and linen services'**
  String get housekeeping_details_3;

  /// No description provided for @housekeeping_details_4.
  ///
  /// In en, this message translates to:
  /// **'Ensuring hygiene and safety standards'**
  String get housekeeping_details_4;

  /// No description provided for @housekeeping_details_5.
  ///
  /// In en, this message translates to:
  /// **'Reporting maintenance issues found in rooms'**
  String get housekeeping_details_5;

  /// No description provided for @housekeeping_details_6.
  ///
  /// In en, this message translates to:
  /// **'Managing lost and found items'**
  String get housekeeping_details_6;

  /// No description provided for @kitchen_title.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get kitchen_title;

  /// No description provided for @kitchen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Food preparation and culinary operations'**
  String get kitchen_subtitle;

  /// No description provided for @kitchen_details_0.
  ///
  /// In en, this message translates to:
  /// **'Preparing and plating meals for guests'**
  String get kitchen_details_0;

  /// No description provided for @kitchen_details_1.
  ///
  /// In en, this message translates to:
  /// **'Managing room service orders efficiently'**
  String get kitchen_details_1;

  /// No description provided for @kitchen_details_2.
  ///
  /// In en, this message translates to:
  /// **'Overseeing food quality and safety standards'**
  String get kitchen_details_2;

  /// No description provided for @kitchen_details_3.
  ///
  /// In en, this message translates to:
  /// **'Organizing buffets and special events'**
  String get kitchen_details_3;

  /// No description provided for @kitchen_details_4.
  ///
  /// In en, this message translates to:
  /// **'Handling special requests and dietary needs'**
  String get kitchen_details_4;

  /// No description provided for @kitchen_details_5.
  ///
  /// In en, this message translates to:
  /// **'Controlling inventory and ingredient sourcing'**
  String get kitchen_details_5;

  /// No description provided for @kitchen_details_6.
  ///
  /// In en, this message translates to:
  /// **'Maintaining a clean and organized kitchen'**
  String get kitchen_details_6;

  /// No description provided for @guest_services_title.
  ///
  /// In en, this message translates to:
  /// **'Guest Services'**
  String get guest_services_title;

  /// No description provided for @guest_services_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Concierge and hospitality assistance'**
  String get guest_services_subtitle;

  /// No description provided for @guest_services_details_0.
  ///
  /// In en, this message translates to:
  /// **'Arranging transportation and tour bookings'**
  String get guest_services_details_0;

  /// No description provided for @guest_services_details_1.
  ///
  /// In en, this message translates to:
  /// **'Recommending restaurants and local attractions'**
  String get guest_services_details_1;

  /// No description provided for @guest_services_details_2.
  ///
  /// In en, this message translates to:
  /// **'Handling luggage and valet requests'**
  String get guest_services_details_2;

  /// No description provided for @guest_services_details_3.
  ///
  /// In en, this message translates to:
  /// **'Coordinating special occasions for guests'**
  String get guest_services_details_3;

  /// No description provided for @guest_services_details_4.
  ///
  /// In en, this message translates to:
  /// **'Assisting with tickets and event reservations'**
  String get guest_services_details_4;

  /// No description provided for @guest_services_details_5.
  ///
  /// In en, this message translates to:
  /// **'Resolving guest requests promptly and politely'**
  String get guest_services_details_5;

  /// No description provided for @guest_services_details_6.
  ///
  /// In en, this message translates to:
  /// **'Providing wake-up calls and personalized support'**
  String get guest_services_details_6;

  /// No description provided for @emergency_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Procedures'**
  String get emergency_title;

  /// No description provided for @emergency_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay safe, stay ready'**
  String get emergency_subtitle;

  /// No description provided for @emergency_items_0.
  ///
  /// In en, this message translates to:
  /// **'Know the location of all emergency exits and evacuation routes'**
  String get emergency_items_0;

  /// No description provided for @emergency_items_1.
  ///
  /// In en, this message translates to:
  /// **'Report fires immediately to the front desk and activate alarms'**
  String get emergency_items_1;

  /// No description provided for @emergency_items_2.
  ///
  /// In en, this message translates to:
  /// **'Follow the evacuation plan calmly and assist guests first'**
  String get emergency_items_2;

  /// No description provided for @emergency_items_3.
  ///
  /// In en, this message translates to:
  /// **'Keep emergency contact numbers accessible at all times'**
  String get emergency_items_3;

  /// No description provided for @emergency_items_4.
  ///
  /// In en, this message translates to:
  /// **'Never use elevators during a fire emergency'**
  String get emergency_items_4;

  /// No description provided for @emergency_items_5.
  ///
  /// In en, this message translates to:
  /// **'Administer first aid only if trained and certified'**
  String get emergency_items_5;

  /// No description provided for @emergency_items_6.
  ///
  /// In en, this message translates to:
  /// **'Report suspicious activity or safety hazards right away'**
  String get emergency_items_6;

  /// No description provided for @ethics_title.
  ///
  /// In en, this message translates to:
  /// **'Professional Ethics'**
  String get ethics_title;

  /// No description provided for @ethics_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Our code of conduct'**
  String get ethics_subtitle;

  /// No description provided for @ethics_items_0.
  ///
  /// In en, this message translates to:
  /// **'Treat every guest with respect, honesty, and fairness'**
  String get ethics_items_0;

  /// No description provided for @ethics_items_1.
  ///
  /// In en, this message translates to:
  /// **'Maintain confidentiality of guest information at all times'**
  String get ethics_items_1;

  /// No description provided for @ethics_items_2.
  ///
  /// In en, this message translates to:
  /// **'Arrive on time and maintain a professional appearance'**
  String get ethics_items_2;

  /// No description provided for @ethics_items_3.
  ///
  /// In en, this message translates to:
  /// **'Avoid conflicts of interest and accepting improper gifts'**
  String get ethics_items_3;

  /// No description provided for @ethics_items_4.
  ///
  /// In en, this message translates to:
  /// **'Communicate honestly with colleagues and management'**
  String get ethics_items_4;

  /// No description provided for @ethics_items_5.
  ///
  /// In en, this message translates to:
  /// **'Take responsibility for mistakes and learn from them'**
  String get ethics_items_5;

  /// No description provided for @ethics_items_6.
  ///
  /// In en, this message translates to:
  /// **'Uphold the hotel\'s values both on and off duty'**
  String get ethics_items_6;

  /// No description provided for @royalblue.
  ///
  /// In en, this message translates to:
  /// **'Royal Blue'**
  String get royalblue;

  /// No description provided for @dustyrose.
  ///
  /// In en, this message translates to:
  /// **'Dusty Rose'**
  String get dustyrose;

  /// No description provided for @darkespresso.
  ///
  /// In en, this message translates to:
  /// **'Dark Espresso'**
  String get darkespresso;

  /// No description provided for @warmlinen.
  ///
  /// In en, this message translates to:
  /// **'Warm Linen'**
  String get warmlinen;

  /// No description provided for @forestemerald.
  ///
  /// In en, this message translates to:
  /// **'Forest Emerald'**
  String get forestemerald;

  /// No description provided for @babyblue.
  ///
  /// In en, this message translates to:
  /// **'Baby Blue'**
  String get babyblue;

  /// No description provided for @babypink.
  ///
  /// In en, this message translates to:
  /// **'Baby Pink'**
  String get babypink;

  /// No description provided for @blackgold.
  ///
  /// In en, this message translates to:
  /// **'Black Gold'**
  String get blackgold;

  /// No description provided for @midnightpurple.
  ///
  /// In en, this message translates to:
  /// **'Midnight Purple'**
  String get midnightpurple;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'in_progress'**
  String get in_progress;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @serviceFromCustomer.
  ///
  /// In en, this message translates to:
  /// **'Service From Customer'**
  String get serviceFromCustomer;

  /// No description provided for @serverErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again later.'**
  String get serverErrorDefault;

  /// No description provided for @networkErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get networkErrorDefault;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get sessionExpired;

  /// No description provided for @validationErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'Please check the entered data.'**
  String get validationErrorDefault;

  /// No description provided for @cacheErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while reading the saved data.'**
  String get cacheErrorDefault;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'The connection timed out. Please try again.'**
  String get connectionTimeout;

  /// No description provided for @unexpectedServerResponse.
  ///
  /// In en, this message translates to:
  /// **'Unexpected response from the server.'**
  String get unexpectedServerResponse;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested data was not found.'**
  String get dataNotFound;

  /// No description provided for @complaintTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the complaint title.'**
  String get complaintTitleRequired;

  /// No description provided for @complaintDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the complaint description.'**
  String get complaintDescriptionRequired;

  /// No description provided for @complaintSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Complaint submitted successfully.'**
  String get complaintSubmittedSuccess;

  /// No description provided for @leaveDatesRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the start and end dates.'**
  String get leaveDatesRequired;

  /// No description provided for @leaveReasonRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the reason for the leave.'**
  String get leaveReasonRequired;

  /// No description provided for @leaveTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the leave type.'**
  String get leaveTypeRequired;

  /// No description provided for @invalidDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid date format.'**
  String get invalidDateFormat;

  /// No description provided for @endDateAfterStartDate.
  ///
  /// In en, this message translates to:
  /// **'The end date must be after the start date.'**
  String get endDateAfterStartDate;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noServiceRequests.
  ///
  /// In en, this message translates to:
  /// **'No service requests'**
  String get noServiceRequests;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No Notifications Yet'**
  String get noNotificationsYet;

  /// No description provided for @whenYouarereceiveNotificationItWillBeSEEHere.
  ///
  /// In en, this message translates to:
  /// **'When you are receive notifications you are see here'**
  String get whenYouarereceiveNotificationItWillBeSEEHere;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
