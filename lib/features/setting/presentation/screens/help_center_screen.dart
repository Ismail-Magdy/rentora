import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final searchController = TextEditingController();
  String _query = '';
  String? _selectedCategory;

  static const List<_HelpCategory> _categories = [
    _HelpCategory('Renting', Icons.shopping_bag_outlined),
    _HelpCategory('Getting Started', Icons.rocket_launch_outlined),
    _HelpCategory('Payments', Icons.payments_outlined),
    _HelpCategory('Lending', Icons.volunteer_activism_outlined),
    _HelpCategory('Account Management', Icons.manage_accounts_outlined),
    _HelpCategory('Safety & Trust', Icons.shield_outlined),
  ];

  static const List<_Faq> _faqs = [
    _Faq(
      category: 'Getting Started',
      question: 'How do I verify my account?',
      answer:
          'Go to Settings > Account Verification, upload a clear selfie and your ID (front & back). Our team will review them and you will be notified once approved.',
    ),
    _Faq(
      category: 'Renting',
      question: 'How do I rent an item?',
      answer:
          'Browse items on the Home screen, pick your rental dates, and send a booking request. Once the owner accepts, a chat opens to arrange the meetup.',
    ),
    _Faq(
      category: 'Renting',
      question: 'What if I return the item late?',
      answer:
          'Late returns may require extra daily fees agreed with the owner. Please communicate with the owner through the chat if you need an extension.',
    ),
    _Faq(
      category: 'Payments',
      question: 'How do I pay for a rental?',
      answer:
          'Rentora currently supports Cash on Delivery. You pay the owner in person during the meetup handover.',
    ),
    _Faq(
      category: 'Payments',
      question: 'When do I get my security deposit back?',
      answer:
          'The deposit is returned in person when you hand the item back and the owner confirms it is in good condition.',
    ),
    _Faq(
      category: 'Lending',
      question: 'How do I list my item for rent?',
      answer:
          'Press the + button, take a photo of your item, and either fill the details manually or let the AI auto-fill them for you, then publish.',
    ),
    _Faq(
      category: 'Account Management',
      question: 'How do I update my phone number or bio?',
      answer:
          'Go to your Profile from the Settings screen and press edit on the field you want to change. Your email cannot be changed.',
    ),
    _Faq(
      category: 'Safety & Trust',
      question: 'Is my ID data safe?',
      answer:
          'Yes. Verification documents are stored in a secured separate collection and are only accessible by the admin team for review.',
    ),
  ];

  List<_Faq> get _filteredFaqs {
    return _faqs.where((faq) {
      final matchesCategory =
          _selectedCategory == null || faq.category == _selectedCategory;
      final matchesQuery =
          _query.isEmpty ||
          faq.question.toLowerCase().contains(_query.toLowerCase()) ||
          faq.answer.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4),
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF1F3F4),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'support_fab',
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Support chat is coming soon!')),
          );
        },
        child: const Icon(Icons.headset_mic, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          SizedBox(height: 8.h),
          Text(
            'How can we help you?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Text(
            'Search for articles, guides, and more.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 16.h),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search the Help Center...',
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                  size: 20.w,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 12.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.4,
            children: _categories.map((category) {
              final selected = _selectedCategory == category.title;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = selected ? null : category.title;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.15,
                        ),
                        child: Icon(
                          category.icon,
                          color: AppColors.primaryColor,
                          size: 20.w,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          category.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 12.h),

          if (_filteredFaqs.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                'No results found. Try a different search.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            )
          else
            ..._filteredFaqs.map(
              (faq) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                  childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  iconColor: AppColors.primaryColor,
                  collapsedIconColor: Colors.grey.shade500,
                  title: Text(
                    faq.question,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    Text(
                      faq.answer,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HelpCategory {
  final String title;
  final IconData icon;

  const _HelpCategory(this.title, this.icon);
}

class _Faq {
  final String category;
  final String question;
  final String answer;

  const _Faq({
    required this.category,
    required this.question,
    required this.answer,
  });
}
