abstract class Moving {
  void move();
}

mixin WalkingOn2 implements Moving{
  @override
  void move() {
    print("Walking on 2");
  }
}
mixin WalkingOn4 implements Moving{
  @override
  void move() {
    print("Walking on 4");
  }
}

//=====================================================
abstract class Eating {
  void eat();
}

mixin MeatEater on Animal implements Eating {
  @override
  void eat() {
    eatMeat();
  }

  void eatMeat() {
    print("Eating meat");
  }
}
mixin PlantsEater implements Eating {
  @override
  void eat() {
    eatPlants();
  }

  void eatPlants() {
    print("Eating plants");
  }
}

//=====================================================

abstract class Animal implements Moving ,Eating {
  void breath() {
    print("Normal breathing");
  }
}


class Dog extends Animal with WalkingOn4, MeatEater {}

class Chicken extends Animal with WalkingOn2, PlantsEater {}

class Champanzi extends Animal with MeatEater, PlantsEater, WalkingOn2{}

void main() {
  print("Dog");
  
  Animal dog = Dog();

  dog.breath();
  dog.move();
  dog.eat();

  print("Chicken");
  Animal kooky = Chicken();
  kooky.move();
  kooky.eat();


  
  print("Champanzii");
  Champanzi kingkong = Champanzi();
  kingkong.move();
  kingkong.eat();
}


