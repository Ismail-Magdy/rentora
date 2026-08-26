import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final String _query = '';
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

  String _getLocalizedCategory(String title, AppLocalizations l10n) {
    switch (title) {
      case 'Renting':
        return l10n.helpRenting;
      case 'Getting Started':
        return l10n.helpGettingStarted;
      case 'Payments':
        return l10n.helpPayments;
      case 'Lending':
        return l10n.helpLending;
      case 'Account Management':
        return l10n.helpAccountManagement;
      case 'Safety & Trust':
        return l10n.helpSafetyTrust;
      default:
        return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(text: l10n.helpCenter),
      floatingActionButton: FloatingActionButton(
        heroTag: 'support_fab',
        backgroundColor: isDark
            ? AppColors.secondaryColor
            : AppColors.primaryColor,
        onPressed: () {
          showFeedbackDialog(
            context,
            icon: Icons.headset_mic,
            color: AppColors.primaryColor,
            title: l10n.oops,
            message: l10n.supportChatSoon,
          );
        },
        child: const Icon(Icons.headset_mic, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView(
        padding: .all(16.w),
        children: [
          verticalSpace(8),
          Text(
            l10n.howCanWeHelp,
            textAlign: .center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: .bold,
              color: isDark ? AppColors.darkTextPrimary : AppColors.black,
            ),
          ),
          verticalSpace(20),

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
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: .circular(12.r),
                    border: .all(
                      color: selected
                          ? (isDark
                                ? AppColors.secondaryColor
                                : AppColors.primaryColor)
                          : (isDark
                                ? AppColors.darkBorder
                                : Colors.transparent),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor:
                            (isDark
                                    ? AppColors.secondaryColor
                                    : AppColors.primaryColor)
                                .withValues(alpha: 0.15),
                        child: Icon(
                          category.icon,
                          color: isDark
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                          size: 27.w,
                        ),
                      ),
                      verticalSpace(8),
                      Padding(
                        padding: .symmetric(horizontal: 8.w),
                        child: Text(
                          _getLocalizedCategory(category.title, l10n),
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: .w700,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          verticalSpace(20),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.frequentlyAskedQuestions,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.black,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          if (_filteredFaqs.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                l10n.noFaqResults,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : Colors.grey.shade600,
                ),
              ),
            )
          else
            ..._filteredFaqs.map(
              (faq) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : Colors.transparent,
                  ),
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
                  iconColor: isDark
                      ? AppColors.secondaryColor
                      : AppColors.primaryColor,
                  collapsedIconColor: isDark
                      ? AppColors.darkTextMuted
                      : Colors.grey.shade500,
                  title: Text(
                    faq.question,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.black,
                    ),
                  ),
                  children: [
                    Text(
                      faq.answer,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : Colors.grey.shade700,
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
