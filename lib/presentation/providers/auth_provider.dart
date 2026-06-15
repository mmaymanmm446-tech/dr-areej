import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io';
import '../../data/models/user_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final SecureStorage _secureStorage = SecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;
  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _loadUserData(user.uid);
    }
  }

  Future<void> signIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await _loadUserData(credential.user!.uid);
      await _secureStorage.saveData(AppConstants.prefIsLoggedIn, 'true');
      _navigateToHome(context);
    } catch (e) {
      _showError(context, 'فشل تسجيل الدخول: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final newUser = UserModel(
        id: credential.user!.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        userType: 'patient',
        photoUrl: null,
        createdAt: DateTime.now(),
        additionalData: {},
      );
      await _firestore.collection(AppConstants.usersCollection).doc(newUser.id).set(newUser.toJson());
      await _firestore.collection(AppConstants.patientsCollection).doc(newUser.id).set({
        'userId': newUser.id,
        'medicalHistory': [],
        'allergies': [],
        'medications': [],
        'createdAt': DateTime.now().toIso8601String(),
      });
      _currentUser = newUser;
      await _secureStorage.saveData(AppConstants.prefIsLoggedIn, 'true');
      _navigateToHome(context);
    } catch (e) {
      _showError(context, 'فشل إنشاء الحساب: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      await _handleSocialSignIn(userCredential);
      _navigateToHome(context);
    } catch (e) {
      _showError(context, 'فشل تسجيل الدخول بواسطة Google: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithApple(BuildContext context) async {
    if (!Platform.isIOS) return;
    _isLoading = true;
    notifyListeners();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      final oauthCredential = OAuthProvider('apple.com').credential(idToken: credential.identityToken, accessToken: credential.authorizationCode);
      final userCredential = await _auth.signInWithCredential(oauthCredential);
      await _handleSocialSignIn(userCredential);
      _navigateToHome(context);
    } catch (e) {
      _showError(context, 'فشل تسجيل الدخول بواسطة Apple: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _handleSocialSignIn(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) return;
    final userDoc = await _firestore.collection(AppConstants.usersCollection).doc(user.uid).get();
    if (!userDoc.exists) {
      final newUser = UserModel(
        id: user.uid,
        name: user.displayName ?? 'مستخدم',
        email: user.email ?? '',
        phone: user.phoneNumber,
        userType: 'patient',
        photoUrl: user.photoURL,
        createdAt: DateTime.now(),
        additionalData: {},
      );
      await _firestore.collection(AppConstants.usersCollection).doc(newUser.id).set(newUser.toJson());
      await _firestore.collection(AppConstants.patientsCollection).doc(newUser.id).set({
        'userId': newUser.id,
        'medicalHistory': [],
        'allergies': [],
        'medications': [],
        'createdAt': DateTime.now().toIso8601String(),
      });
      _currentUser = newUser;
    } else {
      _currentUser = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    }
    await _secureStorage.saveData(AppConstants.prefIsLoggedIn, 'true');
    await _secureStorage.saveData(AppConstants.prefUserId, user.uid);
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      _showSuccess(context, 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني');
    } catch (e) {
      _showError(context, 'فشل إرسال رابط إعادة التعيين: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadUserData(String userId) async {
    try {
      final userDoc = await _firestore.collection(AppConstants.usersCollection).doc(userId).get();
      if (userDoc.exists) {
        _currentUser = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
    notifyListeners();
  }

  void _navigateToHome(BuildContext context) {
    if (_currentUser?.userType == 'admin') {
      Navigator.pushReplacementNamed(context, '/admin_dashboard');
    } else if (_currentUser?.userType == 'doctor') {
      Navigator.pushReplacementNamed(context, '/doctor_dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/patient_home');
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _secureStorage.clearAll();
    _currentUser = null;
    Navigator.pushReplacementNamed(context, '/login');
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
