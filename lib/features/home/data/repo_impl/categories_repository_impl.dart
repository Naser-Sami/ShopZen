import '/features/_features.dart';

class CategoriesRepositoryImpl implements ICategoriesRepository {
  @override
  Future<List<CategoriesEntity>> getCategories() async {
    return [
      CategoriesEntity(
        name: 'Fashion',
        image: 'fashion',
      ),
      CategoriesEntity(
        name: 'Fitness',
        image: 'fitness',
      ),
      CategoriesEntity(
        name: 'Living',
        image: 'living',
      ),
      CategoriesEntity(
        name: 'Games',
        image: 'games',
      ),
      CategoriesEntity(
        name: 'Stationery',
        image: 'stationery',
      ),
      CategoriesEntity(
        name: 'Beauty',
        image: 'beauty',
      ),
    ];
  }
}
