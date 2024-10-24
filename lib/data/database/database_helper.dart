import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';
import '../models/user_model.dart'; // Import your user model
import '../models/project_model.dart'; // Import your project model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    print('Database Path: $path'); // Log the path to the console

    return await openDatabase(
      path,
      version: 3, // Incremented database version
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          date TEXT,
          isCompleted INTEGER,
          category TEXT
        )''');

        await db.execute('''CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT UNIQUE,
          password TEXT,
          name TEXT,
          role TEXT // Ensure the role field exists
        )''');

        await db.execute('''CREATE TABLE projects (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          priority TEXT,
          status TEXT,
          duration INTEGER,
          startDate TEXT,
          lastDate TEXT
        )'''); // Ensuring the projects table includes new fields
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('''ALTER TABLE projects ADD COLUMN priority TEXT''');
          await db.execute('''ALTER TABLE projects ADD COLUMN status TEXT''');
          await db
              .execute('''ALTER TABLE projects ADD COLUMN duration INTEGER''');
          await db
              .execute('''ALTER TABLE projects ADD COLUMN startDate TEXT''');
          await db.execute('''ALTER TABLE projects ADD COLUMN lastDate TEXT''');
        }
      },
    );
  }

  // Get all tasks from the database
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        isCompleted: maps[i]['isCompleted'] == 1,
        category: maps[i]['category'],
      );
    });
  }

  // Get a user by email from the database
  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(
          maps.first); // Use the fromMap method to create User instances
    }
    return null; // Return null if no user found
  }

  // Get all projects from the database
  Future<List<Project>> getAllProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('projects');

    return List.generate(maps.length, (i) {
      return Project.fromMap(
          maps[i]); // Use the fromMap method to create Project instances
    });
  }

  // Insert a new project into the database
  Future<int> insertProject(Project project) async {
    final db = await database;
    return await db.insert('projects', project.toMap());
  }

  // Update an existing project in the database
  Future<int> updateProject(Project project) async {
    final db = await database;
    return await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  // Delete a project from the database
  Future<int> deleteProject(int? id) async {
    final db = await database;
    return await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Add additional CRUD methods for users and tasks as needed.
}
