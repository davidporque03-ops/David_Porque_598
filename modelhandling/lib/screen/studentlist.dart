import 'package:flutter/material.dart';
import 'package:modelhandling/model/studentdata.dart';
import 'package:modelhandling/model/studentmodel.dart';

class Studentlist extends StatefulWidget {
  const Studentlist({super.key});

  @override
  State<Studentlist> createState() => _StudentlistState();
}

class _StudentlistState extends State<Studentlist> {
  final StudentService studentService = StudentService();
  List<Student> _students = [];
  bool _isLoading = true;

  //errohandling
  bool isloading = true;
  String? errorMessage;

  Future<void> _loadStudents() async {
    //capture data
    try {
      final students = await studentService.fetchStudents();
      setState(() {
        _students = students;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load student data $e';
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    _loadStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(body: Center(child: Text(errorMessage!)));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return ListTile(title: Text(student.name));
        },
      ),
    );
  }
}
