import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String studentId;
  const SelectSubjectScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _SelectSubjectScreenState createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  final List<Map<String, dynamic>> _subjects = [
    {'id': 1, 'name': 'Mathematics', 'credits': 4},
    {'id': 2, 'name': 'Physics', 'credits': 3},
    {'id': 3, 'name': 'Chemistry', 'credits': 3},
    {'id': 4, 'name': 'Biology', 'credits': 2},
    {'id': 5, 'name': 'Computer Science', 'credits': 5},
    {'id': 6, 'name': 'History', 'credits': 2},
    {'id': 7, 'name': 'Geography', 'credits': 3},
    {'id': 8, 'name': 'English Literature', 'credits': 2},
  ];

  final List<Map<String, dynamic>> _selectedSubjects = [];
  int _totalCredits = 0;
  final int _maxCredits = 24;

  void _toggleEnrollment(Map<String, dynamic> subject) {
    setState(() {
      if (_selectedSubjects.contains(subject)) {
        _selectedSubjects.remove(subject);
        _totalCredits -= subject['credits'] as int;
      } else {
        if (_totalCredits + subject['credits'] as int <= _maxCredits) {
          _selectedSubjects.add(subject);
          _totalCredits += subject['credits'] as int;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cannot select ${subject['name']}. Maximum credits exceeded!'),
            ),
          );
        }
      }
    });
  }

  Future<void> _enrollSubjects() async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentId)
          .collection('enrollments')
          .doc('current')
          .set({
        'subjects': _selectedSubjects,
        'totalCredits': _totalCredits,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subjects successfully enrolled!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Subjects'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                final isSelected = _selectedSubjects.contains(subject);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(subject['name'] as String),
                    subtitle: Text('Credits: ${subject['credits']}'),
                    trailing: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: IconButton(
                        key: ValueKey(isSelected),
                        icon: Icon(
                          isSelected ? Icons.check_circle : Icons.add_circle_outline,
                          color: isSelected ? Colors.green : Colors.blue,
                        ),
                        onPressed: () => _toggleEnrollment(subject),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Subjects: ${_selectedSubjects.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Total Credits: $_totalCredits/$_maxCredits',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _selectedSubjects.isEmpty ? null : _enrollSubjects,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: const Text('Enroll Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
