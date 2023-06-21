class User {
  String? id;
  String name;
  String email;
  String? dateOfBirth;
  String? token;
  bool? isAdmin;

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email, date of birth : $dateOfBirth, token: $token ,is admin $isAdmin';
  }

  User(
      {this.id,
      required this.name,
      required this.email,
      this.dateOfBirth,
      this.token,
      this.isAdmin});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'date_of_birth': dateOfBirth,
    };
  }

  Map<String, dynamic> toMapForSharedPreferences() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'date_of_birth': dateOfBirth,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      dateOfBirth: map['birth_day'].toString(),
    );
  }

  factory User.fromMapFromSharedPreferences(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      dateOfBirth: map['birth_day']?.toString(),
      token: map['token'].toString(),
    );
  }
}
