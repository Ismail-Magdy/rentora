import 'package:rentora/l10n/generated/app_localizations.dart';

class CategoryModel {
  final String id;
  final String name;
  final String iconPath;

  CategoryModel({required this.id, required this.name, required this.iconPath});

  String getLocalizedName(AppLocalizations l10n) {
    final key = id.toLowerCase();
    if (key == 'all') return l10n.all;
    if (key.contains('gaming') || key.contains('game')) return l10n.categoryGaming;
    if (key.contains('camera')) return l10n.categoryCameras;
    if (key.contains('sport')) return l10n.categorySports;
    if (key.contains('electronic')) return l10n.categoryElectronics;
    if (key.contains('tool')) return l10n.categoryTools;
    if (key.contains('camp')) return l10n.categoryCamping;
    if (key.contains('equip')) return l10n.categoryEquipment;
    if (key.contains('book')) return l10n.categoryBooks;
    if (key.contains('other')) return l10n.categoryOther;
    if (key.contains('laptop')) return l10n.categoryLaptops;
    if (key.contains('travel')) return l10n.categoryTravel;
    return name;
  }

  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'gaming',
      name: 'Gaming',
      iconPath: 'assets/svgs/categories/gaming.svg',
    ),
    CategoryModel(
      id: 'cameras',
      name: 'Cameras',
      iconPath: 'assets/svgs/categories/camera.svg',
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sports',
      iconPath: 'assets/svgs/categories/sports.svg',
    ),
    CategoryModel(
      id: 'electronics',
      name: 'Electronics',
      iconPath: 'assets/svgs/categories/electronics.svg',
    ),
    CategoryModel(
      id: 'tools',
      name: 'Tools',
      iconPath: 'assets/svgs/categories/tools.svg',
    ),
    CategoryModel(
      id: 'camping',
      name: 'Camping',
      iconPath: 'assets/svgs/categories/camping.svg',
    ),
    CategoryModel(
      id: 'equipment',
      name: 'Equipment',
      iconPath: 'assets/svgs/categories/equipment.svg',
    ),
    CategoryModel(
      id: 'books',
      name: 'Books',
      iconPath: 'assets/svgs/categories/books.svg',
    ),
  ];
}
