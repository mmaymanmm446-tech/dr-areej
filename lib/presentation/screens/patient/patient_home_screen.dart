import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_constants.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _buildHeroCard(),
          const SizedBox(height: 16),
          _buildQuickActions(),
          const SizedBox(height: 16),
          _buildSection('الأطباء المميزون'),
          _isLoading ? _buildShimmerCards() : _buildDoctorCards(),
          const SizedBox(height: 16),
          _buildSection('أحدث المقالات'),
          _isLoading ? _buildShimmerCards() : _buildArticleCards(),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'), BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'الأطباء'), BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'المتجر')]),
    );
  }

  Widget _buildHeroCard() => Card(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [AppConstants.primaryColor, AppConstants.secondaryColor]), borderRadius: BorderRadius.circular(24)),
      child: Row(children: [const CircleAvatar(radius: 30, child: Icon(Icons.person)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('مرحباً سارة', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), Text('كيف يمكننا مساعدتك اليوم؟', style: TextStyle(color: Colors.white.withOpacity(0.9)))]))]),
    ),
  );

  Widget _buildQuickActions() => GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.2, children: [
    _actionCard('المساعد الذكي', 'assets/icons/assistant.svg', () => Navigator.pushNamed(context, '/ai_assistant')),
    _actionCard('الحجوزات', 'assets/icons/calendar.svg', () => Navigator.pushNamed(context, '/appointments')),
    _actionCard('الأطباء', 'assets/icons/assistant.svg', () => Navigator.pushNamed(context, '/doctors')),
    _actionCard('المتجر', 'assets/icons/shop.svg', () => Navigator.pushNamed(context, '/store')),
  ]);

  Widget _actionCard(String title, String iconPath, VoidCallback onTap) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(iconPath, height: 32, width: 32),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
      ),
    ),
  );

  Widget _buildSection(String title) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)), TextButton(onPressed: () {}, child: const Text('عرض الكل'))]);

  Widget _buildDoctorCards() => SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 4, itemBuilder: (context, index) => Container(width: 180, margin: const EdgeInsets.only(right: 16), child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const CircleAvatar(radius: 30, child: Icon(Icons.person)), const SizedBox(height: 8), Text('د. أحمد محمد', style: const TextStyle(fontWeight: FontWeight.bold)), Text('أمراض القلب', style: TextStyle(color: AppConstants.primaryColor, fontSize: 12)), const Spacer(), const Row(children: [Icon(Icons.star, size: 14, color: Colors.amber), SizedBox(width: 4), Text('4.8')])]))))));

  Widget _buildArticleCards() => SizedBox(height: 150, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 3, itemBuilder: (context, index) => Container(width: 260, margin: const EdgeInsets.only(right: 16), child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('فوائد الصحة', style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('نصائح يومية لتحسين نمط الحياة...', maxLines: 3, overflow: TextOverflow.ellipsis)]))))));

  Widget _buildShimmerCards() => SizedBox(height: 180, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 3, itemBuilder: (context, index) => Shimmer.fromColors(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, child: Container(width: 180, margin: const EdgeInsets.only(right: 16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24))))));
}
