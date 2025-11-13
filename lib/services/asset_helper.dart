final class AssetHelper {
  static const String _categoriesPath = 'assets/images/dummy-categories';

  static List<String> getDummyCategoryImages(int count) {
    return List.generate(
        count, (index) => '$_categoriesPath/category_${index + 1}.png');
  }
}
