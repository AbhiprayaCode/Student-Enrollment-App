class Student {
  final String id;
  final String name;
  final String email;
  final List<Map<String, dynamic>> enrollments;

  Student({required this.id, required this.name, required this.email, required this.enrollments});

  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      enrollments: List<Map<String, dynamic>>.from(data['enrollments'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enrollments': enrollments,
    };
  }
}
