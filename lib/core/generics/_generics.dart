// Name	  Work
// T	    Type
// E	    Element
// K	    Key
// V	    Value

class ClassName<T> {}

// Using Generics
class Data<T> {
  T data;
  Data(this.data);
}

/*
  Example using:

  // create an object of type int and double
  Data<int> intData = Data<int>(10);
  Data<double> doubleData = Data<double>(10.5);
  Data<String> stringData = Data<String>("Hello, World!");
*/

// Dart implementation of Map class
// abstract class Map<K, V> {
//   // code
//   external factory Map();
// }

/*
 Example using:

   final info = {
    "name": "John",
    "age": 20,
    "height": 5.5,
  };
 */

// Define generic method
T genericMethod<T>(T value) {
  return value;
}

/*
  Example using:

  // call the generic method
  print("Int: ${genericMethod<int>(10)}");
  print("Double: ${genericMethod<double>(10.5)}");
  print("String: ${genericMethod<String>("Hello")}");
*/

class Repository<T> {
  final List<T> _dataStore = [];

  void add(T item) => _dataStore.add(item);

  List<T> getAll() => _dataStore;

  T? getByIndex(int index) {
    if (index < 0 || index >= _dataStore.length) {
      return null;
    }

    return _dataStore[index];
  }
}
