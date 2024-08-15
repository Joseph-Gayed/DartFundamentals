/**
 * SOlving the challenge if we have many mixins that implements same iterface differently , 
 * We want to use both of them dynamically
 */

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

mixin class MeatEater implements Eating {
  @override
  void eat() {
    eatMeat();
  }

  void eatMeat() {
    print("Eating meat");
  }
}
mixin class PlantsEater implements Eating {
  @override
  void eat() {
    eatPlants();
  }

  void eatPlants() {
    print("Eating plants");
  }
}

mixin AnythingEater implements Eating {
  Eating? eatingBehavior;

  void setEatingBehavior(Eating eatingBehavior) {
    this.eatingBehavior = eatingBehavior;
  }

  @override
  void eat() {
    eatingBehavior?.eat();
  }
}

//=====================================================
abstract class Animal implements Eating,Moving {}
//=====================================================

class Koala extends Animal with PlantsEater,WalkingOn2 {}

class Lion extends Animal with MeatEater,WalkingOn4 {}

class Pig extends Animal with AnythingEater,WalkingOn4 {}

//=====================================================
void main() {
  print("Koala - Plants eater");
  Animal koala = Koala();
  koala.eat(); // Output: Eating plants
  koala.move(); // Output: Walking on 2

  print("Lion - Meats eater");
  Animal lion = Lion();
  lion.eat(); // Output: Eating meat
  lion.move(); // Output: Walking on 4


  print("Pig - Anything eater");
  Pig pig = Pig();
  pig.setEatingBehavior(MeatEater());
  pig.eat(); // Output: Eating meat

  pig.setEatingBehavior(PlantsEater());
  pig.eat(); // Output: Eating plants
  
  pig.move(); // Output: Walking on 4
}