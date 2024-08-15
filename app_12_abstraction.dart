abstract class Animal {
  String name ="Animal";
  
  void breath();
   void move(){
    print("super is moving..");
  }
}


//in this case animal is implcit interface
class Dog implements Animal{
  @override
  void breath() {
    print("dog is breathing..");
  }
  @override
  void move() {
    // super.move();
    print("$name dog is moving..");
  }
  @override
  String name = "Roky";
}

//in this case animal is abstract class
class Cat extends Animal{
  @override
  void breath() {
    print("cat is breathing..");
  }

  @override
  void move() {
    super.move();
    print("$name cat is moving..");
  }
}


void main() {
  Animal dog= Dog();
  dog.breath(); 
  dog.move();

  Animal cat= Cat();
  cat.breath(); 
  cat.move();
}