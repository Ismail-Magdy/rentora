class CategoryModel {
  final String id;
  final String name;
  final String iconPath;

  CategoryModel({required this.id, required this.name, required this.iconPath});

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
