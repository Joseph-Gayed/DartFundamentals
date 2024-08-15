
//function out of class is called function,
//function inside class is called method.

//positional paramters . 
//must pass all parameters with the same order.
void printUserRequiredPositionalParams(int id, String name){
  print("id: $id , name: $name");
}

//you can call method without passing the params , and it will use the default values . 
//You can also pass paramters in any order
//if you pass a parmeter , you must write the parameter name 
void printUserOptionalNamedParams({int id = 0,String name=""}){
  print("id: $id , name: $name");
}

//you can call method , must pass id ,and you can skip passing the name, and it will use the default value.
void printUserRequiredNamedParams({required int id ,String name=""}){
  print("id: $id , name: $name");
}

//you can call method and you can skip passing the id,name, and it will use the default value.
//you must pass the parameters with the same order.
void printUserOptionalPositionalParams([int id = 0,String name=""]){
  print("id: $id , name: $name");
}

//you can call method , must pass id ,and you can skip passing the name, and it will use the default value.
//You can also pass paramters in any order
//if you pass the 'name' parmeter , you must write the parameter name 
void printUserPositionalAndNamedParams(int id,{String name=""}){
  print("id: $id , name: $name");
}



//=> used with the single statement functions , replace '{}', 'return' with '=>'
int singleLineFunction (int x, int y) => x*y;

void main(List<String> args) {
  printUserRequiredPositionalParams(1,"Jo");

  printUserOptionalNamedParams(name:"Jo", id: 1);
  printUserOptionalNamedParams(id: 1);

  printUserRequiredNamedParams(name:"Jo", id: 1);

  printUserOptionalPositionalParams();
  printUserOptionalPositionalParams(0,"Jo");

  printUserPositionalAndNamedParams(0);
  printUserPositionalAndNamedParams(0,name: "Jo");
}