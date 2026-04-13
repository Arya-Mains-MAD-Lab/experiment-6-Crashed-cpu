import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p; // Use 'as p' to avoid Context conflicts

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DBPage(),
    );
  }
}

class DBPage extends StatefulWidget {
  const DBPage({super.key});
  @override
  State<DBPage> createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  Database? db;
  List<Map<String, dynamic>> students = [];
  bool isLoading = true;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDB();
  }

  Future<void> initDB() async {
    // Using p.join because of the 'as p' import
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'student_v3.db');

    db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute("CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT)");
      },
      version: 1,
    );
    await refreshData();
  }

  Future<void> refreshData() async {
    if (db == null) return;
    final data = await db!.query('student', orderBy: "id DESC");
    setState(() {
      students = data;
      isLoading = false;
    });
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingStudent = students.firstWhere((element) => element['id'] == id);
      _nameController.text = existingStudent['name'];
    } else {
      _nameController.clear();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter Student Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await db?.insert('student', {'name': _nameController.text});
                } else {
                  await db?.update('student', {'name': _nameController.text},
                      where: "id = ?", whereArgs: [id]);
                }
                _nameController.clear();
                if (mounted) Navigator.of(context).pop();
                refreshData();
              },
              child: Text(id == null ? 'Create New' : 'Update Item'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Database')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
          ? const Center(child: Text("No students found. Tap + to add."))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(students[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showForm(students[index]['id']),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await db?.delete('student',
                        where: "id = ?", whereArgs: [students[index]['id']]);
                    refreshData();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
