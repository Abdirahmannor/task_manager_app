class User {
  final int id; // Ensure you have an id field if necessary
  final String username;
  final String password;
  final String email;
  final String name; // Add this field

  User({
    this.id = 0, // Default value if not provided
    required this.username,
    required this.password,
    required this.email,
    required this.name, // Add this required parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'name': name, // Include name in the map
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      name: map['name'], // Ensure this is included
    );
  }
}
