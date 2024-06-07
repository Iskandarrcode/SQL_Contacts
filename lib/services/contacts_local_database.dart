import 'package:iyun6/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactsLocalDatabase {
  ContactsLocalDatabase._singleton();

  static final ContactsLocalDatabase _contactsLocalDatabase =
      ContactsLocalDatabase._singleton();

  factory ContactsLocalDatabase() {
    return _contactsLocalDatabase;
  }

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = "$databasePath/contacts.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phoneNumber TEXT NOT NULL
    )
    """);
  }

  Future<List<ContactModel>> getContacts() async {
    final Database databases = await database;
    final List<Map<String, dynamic>> contacts =
        await databases.query('contacts');

    List<ContactModel> loadedContacts = [];
    for (Map<String, dynamic> json in contacts) {
      loadedContacts.add(
        ContactModel.fromJson(json),
      );
    }
    return loadedContacts;
  }

  Future<void> addContact(
      {required String name, required String phoneNumber}) async {
    print(name);
    await _database!.insert(
      "contacts",
      {
        "name": name,
        "phoneNumber": phoneNumber,
      },
    );
  }

  Future<void> editContact({
    required int id,
    required String newName,
    required String newPhoneNumber,
  }) async {
    await _database!.update(
      "contacts",
      {
        "name": newName,
        "phoneNumber": newPhoneNumber,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteContact({required int id}) async {
    await _database!.delete(
      "contacts",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
