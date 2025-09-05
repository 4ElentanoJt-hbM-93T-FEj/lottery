// class Person {
//   final String name;
//   final int age;

//   Person.undefined() : this("", 1);

//   Person.withName(String name) : this(name, 18);

//   // Person(this.name, this.age);

//   Person(String name, this.age) : name = name.trim() {
//     if (age < 0) throw ArgumentError('Возраст не может быть отрицательным');
//   }

//   void display() {
//     print("Name: $name \tAge: $age");
//   }
// }

// void main() {
//   var person = Person("Tom", 1);
//   person.display();
// }
