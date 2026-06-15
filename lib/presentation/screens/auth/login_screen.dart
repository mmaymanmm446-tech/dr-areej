import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/2.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  GlassmorphicContainer(
                    width: 110,
                    height: 110,
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlassmorphicContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text('مرحباً بك', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('سجل دخولك للمتابعة', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
                        const SizedBox(height: 32),
                        TextFormField(controller: authProvider.emailController, decoration: InputDecoration(hintText: 'البريد الإلكتروني أو رقم الهاتف', prefixIcon: const Icon(Icons.email_outlined), filled: true, fillColor: Colors.white.withOpacity(0.92), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none))),
                        const SizedBox(height: 16),
                        TextFormField(controller: authProvider.passwordController, obscureText: true, decoration: InputDecoration(hintText: 'كلمة المرور', prefixIcon: const Icon(Icons.lock_outline), filled: true, fillColor: Colors.white.withOpacity(0.92), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none))),
                        const SizedBox(height: 16),
                        Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())), child: const Text('نسيت كلمة المرور؟'))),
                        const SizedBox(height: 24),
                        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: authProvider.isLoading ? null : () => authProvider.signIn(context), child: authProvider.isLoading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('تسجيل الدخول'))),
                        const SizedBox(height: 16),
                        Row(children: [Expanded(child: Divider()), Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('أو')), Expanded(child: Divider())]),
                        const SizedBox(height: 16),
                        Row(children: [Expanded(child: OutlinedButton.icon(onPressed: () => authProvider.signInWithGoogle(context), icon: const Icon(Icons.g_mobiledata), label: const Text('Google'))), const SizedBox(width: 16), Expanded(child: OutlinedButton.icon(onPressed: () => authProvider.signInWithApple(context), icon: const Icon(Icons.apple), label: const Text('Apple')))]),
                        const SizedBox(height: 24),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('ليس لديك حساب؟'), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())), child: const Text('إنشاء حساب', style: TextStyle(fontWeight: FontWeight.bold)))]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
