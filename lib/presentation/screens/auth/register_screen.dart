import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          TextFormField(controller: auth.nameController, decoration: const InputDecoration(labelText: 'الاسم')),
          const SizedBox(height: 16),
          TextFormField(controller: auth.emailController, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
          const SizedBox(height: 16),
          TextFormField(controller: auth.phoneController, decoration: const InputDecoration(labelText: 'رقم الهاتف')),
          const SizedBox(height: 16),
          TextFormField(controller: auth.passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور')),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: auth.isLoading ? null : () => auth.signUp(context), child: const Text('إنشاء الحساب'))),
        ]),
      ),
    );
  }
}
