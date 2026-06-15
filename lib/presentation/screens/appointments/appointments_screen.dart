import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('الحجوزات')), body: ListView.builder(itemCount: 4, itemBuilder: (_, index) => Card(margin: const EdgeInsets.all(12), child: ListTile(title: Text('موعد ${index + 1}'), subtitle: const Text('اليوم • 3:00 مساءً')))));
  }
}
