import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/auth/forgot_password_screen.dart';
import 'presentation/screens/patient/patient_home_screen.dart';
import 'presentation/screens/doctor/doctor_dashboard.dart';
import 'presentation/screens/admin/admin_dashboard.dart';
import 'presentation/screens/ai_assistant/ai_assistant_screen.dart';
import 'presentation/screens/doctors/doctors_screen.dart';
import 'presentation/screens/articles/articles_screen.dart';
import 'presentation/screens/store/products_screen.dart';
import 'presentation/screens/appointments/appointments_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String patientHome = '/patient_home';
  static const String doctorDashboard = '/doctor_dashboard';
  static const String adminDashboard = '/admin_dashboard';
  static const String aiAssistant = '/ai_assistant';
  static const String doctors = '/doctors';
  static const String articles = '/articles';
  static const String store = '/store';
  static const String appointments = '/appointments';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case patientHome:
        return MaterialPageRoute(builder: (_) => const PatientHomeScreen());
      case doctorDashboard:
        return MaterialPageRoute(builder: (_) => const DoctorDashboard());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case aiAssistant:
        return MaterialPageRoute(builder: (_) => const AIAssistantScreen());
      case doctors:
        return MaterialPageRoute(builder: (_) => const DoctorsScreen());
      case articles:
        return MaterialPageRoute(builder: (_) => const ArticlesScreen());
      case store:
        return MaterialPageRoute(builder: (_) => const ProductsScreen());
      case appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
