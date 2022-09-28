import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          AppStringsKeys.welcomeToLiveWell: 'Welcome to Livewell',
          AppStringsKeys.letsYourNewHealth:
              'Let\'s your new Health & Fitness Journey with us!',
          AppStringsKeys.getStarted: 'Get Started',
          AppStringsKeys.signIn: 'Sign In',
          AppStringsKeys.signUp: 'Sign Up',
          AppStringsKeys.alreadyHaveAccount: 'Already have account?',
          AppStringsKeys.dontHaveAccount: 'Don\'t have account?',
          AppStringsKeys.createNewAccount: 'Create New Account',
          AppStringsKeys.enterYourDetails:
              'Enter your details to create account',
          AppStringsKeys.email: 'Email Address',
          AppStringsKeys.password: 'Password',
          AppStringsKeys.fullName: 'Full Name',
          AppStringsKeys.orSignUpWith: 'Or Sign Up With',
          AppStringsKeys.firstName: 'First Name',
          AppStringsKeys.lastName: 'Last Name',
          AppStringsKeys.orSignInWith: 'Or Sign In With',
          AppStringsKeys.forgotPassword: 'Forgot Password?',
          AppStringsKeys.getStarted2: 'Get Started!',
          AppStringsKeys.youReadyToGo: 'You are ready to go!',
          AppStringsKeys.thanksForTakingYourTime:
              'Thanks for taking your time to create account with us. Let\'s start your wellness Journey',
          AppStringsKeys.forgotPasswordDesc:
              'Please enter your email address. You will receive a link to create a new password via email.',
          AppStringsKeys.submit: 'Submit',
          AppStringsKeys.forgotPassword2: 'Forgot Password',
        },
        'es_ES': {
          'title': 'Hola',
        },
        'pt_BR': {
          'title': 'Olá',
        },
      };
}

//create class for constant strings
class AppStringsKeys {
  static const String welcomeToLiveWell = 'welcome_to_live_well';
  static const String letsYourNewHealth = 'lets_your_new_health';
  static const String getStarted = 'get_started';
  static const String alreadyHaveAccount = 'already_have_account';
  static const String signIn = 'signIn';
  static const String signUp = 'signUp';
  static const String createNewAccount = 'create_new_account';
  static const String enterYourDetails = 'enter_your_details';
  static const String dontHaveAccount = 'dont_have_account';
  static const String email = 'email';
  static const String password = 'password';
  static const String fullName = 'full_name';
  static const String orSignUpWith = 'or_sign_up_with';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String orSignInWith = 'or_sign_in_with';
  static const String forgotPassword = 'forgot_password';
  static const String getStarted2 = 'get_started2';
  static const String youReadyToGo = 'you_ready_to_go';
  static const String thanksForTakingYourTime = 'thanks_for_taking_your_time';
  static const String forgotPasswordDesc = 'forgot_password_desc';
  static const String submit = 'submit';
  static const String forgotPassword2 = 'forgot_password2';
}
