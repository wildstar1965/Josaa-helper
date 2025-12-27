enum UserRole { freeStudent, paidStudent, student, mentor, admin }

class AppUser {
  final String email;
  final String name;
  final UserRole role;

  AppUser({required this.email, required this.name, required this.role});

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'role': role.toString(),
  };

  @override
  String toString() =>
      'AppUser(email: $email, name: $name, role: $role)';
}
