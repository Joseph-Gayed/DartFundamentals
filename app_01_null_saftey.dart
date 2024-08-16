void main(List<String> args) {
  //? means name is a nullable string , the name can hold null value.
  String? name;

  //Not nullable String, can't hold null value. Must be initialized before usage
  String notNullableString = "inital value";

  //?? means if the nullable string name is not null use it's value , else use the default value "default value"
  notNullableString = name ?? "default value";

  //! means Iam sure that value of the nullable name is not null , if it's null I'm ok to crash.
  notNullableString = name!;

  //?. means if the value is not null , execute the line else ignore it.
  User? user;
  user?.printDetails();
}

class User{
  printDetails(){}
}