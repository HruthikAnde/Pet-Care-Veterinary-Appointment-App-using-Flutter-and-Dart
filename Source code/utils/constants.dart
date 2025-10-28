class AppConstants {
  // App info
  static const String appName = 'Pet Care';
  static const String appVersion = '1.0.0';
  
  // API endpoints
  static const String baseUrl = 'https://api.petcare.com';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String petsEndpoint = '/pets';
  static const String appointmentsEndpoint = '/appointments';
  
  // Storage keys
  static const String themeKey = 'theme_mode';
  static const String userKey = 'user_data';
  static const String tokenKey = 'auth_token';
  
  // Date formats
  static const String dateFormat = 'MMM d, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM d, yyyy hh:mm a';
  
  // Default values
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const int defaultAnimationDuration = 300;
}

class AppStrings {
  static const String welcome = 'Welcome to Pet Care';
  static const String slogan = 'Your Pet\'s Health Companion';
  static const String noPets = 'No pets added yet';
  static const String noAppointments = 'No appointments scheduled';
  static const String addFirstPet = 'Tap the + button to add your first pet';
  static const String bookFirstAppointment = 'Book your first appointment to get started';
}

class AppImages {
  static const String appLogo = 'assets/images/icons/app_icon.png';
  static const String dogAvatar = 'assets/images/icons/dog_avatar.png';
  static const String catAvatar = 'assets/images/icons/cat_avatar.png';
  static const String splashBg = 'assets/images/backgrounds/splash_bg.jpg';
}