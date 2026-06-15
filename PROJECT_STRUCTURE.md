# Wellness By Dr.Areej - Project File Map

## Root
- pubspec.yaml
- PROJECT_STRUCTURE.md

## Assets
### icons
- assets/icons/article.svg
- assets/icons/assistant.svg
- assets/icons/calendar.svg
- assets/icons/shop.svg

### images
- assets/images/1.jpg
- assets/images/2.png

## lib
- lib/main.dart
- lib/app_routes.dart

### core
- lib/core/constants/app_constants.dart
- lib/core/themes/app_theme.dart
- lib/core/utils/secure_storage.dart
- lib/core/widgets/glassmorphic_container.dart

### data
- lib/data/models/appointment_model.dart
- lib/data/models/chat_message.dart
- lib/data/models/user_model.dart
- lib/data/repositories/chat_repository.dart

### firebase
- lib/firebase/firebase_options.dart

### presentation
#### providers
- lib/presentation/providers/ai_assistant_provider.dart
- lib/presentation/providers/auth_provider.dart

#### screens
- lib/presentation/screens/splash_screen.dart
- lib/presentation/screens/admin/admin_dashboard.dart
- lib/presentation/screens/ai_assistant/ai_assistant_screen.dart
- lib/presentation/screens/ai_assistant/message_bubble.dart
- lib/presentation/screens/appointments/appointments_screen.dart
- lib/presentation/screens/articles/articles_screen.dart
- lib/presentation/screens/auth/forgot_password_screen.dart
- lib/presentation/screens/auth/login_screen.dart
- lib/presentation/screens/auth/register_screen.dart
- lib/presentation/screens/doctor/doctor_dashboard.dart
- lib/presentation/screens/doctors/doctors_screen.dart
- lib/presentation/screens/onboarding/onboarding_screen.dart
- lib/presentation/screens/patient/patient_home_screen.dart
- lib/presentation/screens/store/products_screen.dart
