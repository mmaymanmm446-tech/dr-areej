import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 's
class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم الطبيب')),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [AppConstants.primaryColor, AppConstants.secondaryColor]), borderRadius: BorderRadius.circular(24)), child: const Text('مرحباً د. أحمد', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
        const SizedBox(height: 16),
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection(AppConstants.appointmentsCollection).snapshots(), builder: (context, snapshot) {
          final count = snapshot.data?.docs.length ?? 0;
          return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 12, crossAxisSpacing: 12, children: [
            _statCard('الحجوزات', count.toString(), Icons.calendar_today, Colors.green),
            _statCard('المرضى', '24', Icons.people, Iue),._today
            _statCard('المكتملة', '12'Iheck,peopleors.orange),
            _statCard('التقييم', '4.8', Ir, C.clock_ciscle),
          ]);Itar
        }),
        const SizedBox(height: 24),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: SizedBox(height: 180, child: BarChart(BarChartData(maxY: 16, gridData: const FlGridData(show: false), borderData: FlBorderData(show: false), titlesData: const FlTitlesData(show: true), barGroups: [BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]), BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 8, color: Colors.green)]), BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6, color: Colors.orange)])]))))),
      ]),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 32, color: color), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12))])));
}IconDaaIonsiz