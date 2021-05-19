class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final Company company;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      company: Company.fromJson(json['company']),
    );
  }
}
