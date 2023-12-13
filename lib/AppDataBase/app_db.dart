import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wscube_bloc_with_note/Model/note_model.dart';
import 'package:wscube_bloc_with_note/Model/user_model.dart';

class AppDataBase {
  AppDataBase._();

  Database? myDb;

  static final AppDataBase instance = AppDataBase._();

  static final String LOGIN_UID = "uid";

  /// Table
  static final String NOTE_TABLE = "notes";
  static final String USER_TABLE = "users";

  /// Note Columns
  static final String COLUMN_NOTE_ID = "noteId";
  static final String COLUMN_NOTE_TITLE = "noteTitle";
  static final String COLUMN_NOTE_DESC = "noteDesc";

  /// Users Columns
  static final String COLUMN_USER_ID = "userId";
  static final String COLUMN_USER_NAME = "userName";
  static final String COLUMN_USER_EMAIL = "userEmail";
  static final String COLUMN_USER_PASS = "userPass";

  Future<Database> getDB() async {
    if (myDb != null) {
      return myDb!;
    } else {
      myDb = await initDB();
      return myDb!;
    }
  }

  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(docDirectory.path, "noteDb.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "create table $NOTE_TABLE ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )");

        db.execute(
            "create table $USER_TABLE ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_PASS text )");
      },
    );
  }

  Future<bool> addNote(NoteModel newNote) async {
    var uid = await getUID();
    newNote.userId = uid;

    var db = await getDB();

    var rowsEffected = await db.insert(NOTE_TABLE, newNote.toMap());

    return rowsEffected > 0;
  }

  Future<List<NoteModel>> fetchNote() async {
    var uid = await getUID();

    var db = await getDB();
    List<NoteModel> arrNote = [];

    var data = await db
        .query(NOTE_TABLE, where: "$COLUMN_USER_ID = ?", whereArgs: ["$uid"]);

    for (Map<String, dynamic> eachNote in data) {
      var noteModel = NoteModel.fromMap(eachNote);
      arrNote.add(noteModel);
    }

    return arrNote;
  }

  void updateNote(NoteModel updateNote) async {
    var db = await getDB();

    db.update(NOTE_TABLE, updateNote.toMap(),
        where: "$COLUMN_NOTE_ID = ?", whereArgs: ["${updateNote.noteId}"]);
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();

    var rowsEffected = await db
        .delete(NOTE_TABLE, where: "$COLUMN_NOTE_ID = ?", whereArgs: ["$id"]);

    return rowsEffected > 0;
  }

  Future<int> getUID() async {
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getInt(AppDataBase.LOGIN_UID);
    return uid ?? 0;
  }

  Future<bool> createAccount(UserModel newUser) async {
    var check = await checkIfUserExists(newUser.userEmail);
    if (!check) {
      var db = await getDB();
      db.insert(USER_TABLE, newUser.toMap());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    var db = await getDB();

    var data = await db
        .query(USER_TABLE, where: "$COLUMN_USER_EMAIL = ?", whereArgs: [email]);

    return data.isNotEmpty;
  }

  Future<bool> authenticateUser(String email, String pass) async {
    var db = await getDB();

    var data = await db.query(USER_TABLE,
        where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?",
        whereArgs: [email, pass]);

    if (data.isNotEmpty) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt(LOGIN_UID, UserModel.fromMap(data[0]).userId);
    }

    return data.isNotEmpty;
  }
}
