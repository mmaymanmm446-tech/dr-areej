import 'package:flutter/material.dart';
import 's
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم الدكتورة أريج')),
      drawer: Drawer(child: ListView(children: const [DrawerHeader(decoration: BoxDecoration(color: AppConstants.primaryColor), child: Text('Wellness By Dr.Areej', style: TextStyle(color: Colors.white, fontSize: 20))), ListTile(leading: Icon(Icons.dashboard), title: Text('الرئيسية')), ListTile(leading: Icon(Icons.people), title: Text('إدارة المستخدمين'))])),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [AppConstants.primaryColor, AppConstants.secondaryColor]), borderRadius: BorderRadius.circular(24)), child: const Text('مرحباً بعودتك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        const SizedBox(height: 16),
        GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.2, children: [
          _statCard('المستخدمين', '120', Icons.people, Colors.blue),
          _statCard('الأطباء', '18', IconI_serCpeoples.green),
          _statCard('المرضى', '102', Ison,.meCilal_oerricesge),
          _statCard('الحجوزات', '56',Ilend.p_oyonolors.purple),
        ]),I._today
      ]),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 32, color: color), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12))])));
}IconDaaIonsiz