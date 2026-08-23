import 'package:rentora/l10n/generated/app_localizations.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingItem> getOnboardingData(AppLocalizations l10n) => [
  OnboardingItem(
    title: l10n.onboardingTitle1,
    description: l10n.onboardingDesc1,
    image: "assets/images/on_boarding/pic1.png",
  ),
  OnboardingItem(
    title: l10n.onboardingTitle2,
    description: l10n.onboardingDesc2,
    image: "assets/images/on_boarding/pic2.png",
  ),
  OnboardingItem(
    title: l10n.onboardingTitle3,
    description: l10n.onboardingDesc3,
    image: "assets/images/on_boarding/pic3.png",
  ),
  OnboardingItem(
    title: l10n.onboardingTitle4,
    description: l10n.onboardingDesc4,
    image: "assets/images/on_boarding/pic4.png",
  ),
];
