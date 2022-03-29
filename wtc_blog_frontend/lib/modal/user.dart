class User {
  String email;
  String username;
  String password;
  String name;
  String surname;

  User({this.email, this.password, this.name, this.surname, this.username});

  User.withEmail(this.email, this.password) {
    username = "";
    name = "";
    surname = "";
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "username": username,
        "surname": surname,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"],
      surname: json["surname"],
      password: json["password"],
      email: json["email"],
      name: json["name"],
    );
  }
}
