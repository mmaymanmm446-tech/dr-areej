import 'package:flutter/material.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('الأطباء')), body: ListView.builder(itemCount: 5, itemBuilder: (_, index) => Card(margin: const EdgeInsets.all(12), child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text('د. الطبيب ${index + 1}'), subtitle: const Text('أمراض القلب')))));
  }
}
