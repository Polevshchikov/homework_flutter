import 'dart:io';

import 'package:basa_dation/model/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  String studentsTable = 'Studets';
  String columnId = 'id';
  String columnName = 'name';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Student.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Student
  // Id | Name
  // 0......
  // 1......

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $studentsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
    );
  }

  //Чтение студента из таблицы
  Future<List<Student>> getStudents() async {
    Database db = await this.database; //обращаемся к базе данных
    final List<Map<String, dynamic>> studentsMapList =
        await db.query(studentsTable);
    final List<Student> studentsList = [];
    studentsMapList.forEach((studentMap) {
      studentsList.add(
        Student.fromMap(studentMap),
      );
    });
    return studentsList;
  }

  //Добавление новых студентов в базу данных
  Future<Student> insertStudent(Student student) async {
    Database db = await this.database;
    student.id = await db.insert(
      studentsTable,
      student.toMap(),
    );
    return student;
  }

  //Обновление(редактирование) студента в базе данных
  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    return await db.update(
      studentsTable,
      student.toMap(),
      where: '$columnId = ?',
      whereArgs: [student.id],
    );
  }

  //Удаление студента из базы данных
  Future<int> deleteStudent(int id) async {
    Database db = await this.database;
    return await db.delete(
      studentsTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
