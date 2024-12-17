import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addStudent(String id, String name, String email) async {
    await _db.collection('students').doc(id).set({
      'id': id,
      'name': name,
      'email': email,
      'enrollments': [],
    });
  }

  Future<List<Map<String, dynamic>>> getSubjects() async {
    QuerySnapshot querySnapshot = await _db.collection('subjects').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<void> addEnrollment(String studentId, Map<String, dynamic> subject) async {
    DocumentReference studentRef = _db.collection('students').doc(studentId);
    await studentRef.update({
      'enrollments': FieldValue.arrayUnion([subject]),
    });
  }
}
