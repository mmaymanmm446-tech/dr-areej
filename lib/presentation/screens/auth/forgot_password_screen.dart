import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نسيت كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () async {
            await Provider.of<AuthProvider>(context, listen: false).resetPassword(context, _emailController.text);
            if (mounted) Navigator.pop(context);
          }, child: const Text('إرسال رابط إعادة التعيين'))),
        ]),
      ),
    );
  }
}
