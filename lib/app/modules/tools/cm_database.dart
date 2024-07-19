import 'package:calorie_manager/app/modules/first_page/first_page_controller.dart';
import 'package:calorie_manager/app/modules/tools/app_util.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CMDBUtil extends GetxService {
  late Database db;
  String lastTime = "";
  Future<CMDBUtil> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createTable(db);
    });
   
  }


  Future<void> createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS dates_table (date_id INTEGER PRIMARY KEY AUTOINCREMENT ,date TEXT,timestamp INT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS intake_table (id INTEGER PRIMARY KEY AUTOINCREMENT, date_id INT, isIntake BOOL ,iconName  TEXT,name TEXT,timestamp INT,kcal INT,dateStr TEXT, FOREIGN KEY (date_id) REFERENCES dates_table(date_id))');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS consume_table (id INTEGER PRIMARY KEY AUTOINCREMENT, date_id INT, isIntake BOOL  ,iconName  TEXT, name TEXT,timestamp INT,kcal INT ,dateStr TEXT, FOREIGN KEY (date_id) REFERENCES dates_table(date_id))');
  }

  Future<void> insertDate(CMDateModel date) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    await db.insert('dates_table', {
      'date': date.date,
      'timestamp': date.timestamp,
    });
  }

  Future<void> insertRecord(CMIntakemodel item) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    final result =
        await db.query('dates_table', orderBy: 'date_id DESC LIMIT 1');

    final today = DateTime.now();

    final todayStr = PMAppUtil.formatDateWithoutHour(dateTime: today);

    if (result.isNotEmpty) {
      final dateModel = CMDateModel.fromJson(result.first);
      if (todayStr == dateModel.date) {
        item.dateID = dateModel.id;
        await insetRecordNext(db, item);
      } else {
        final newDatemodel = CMDateModel();
        newDatemodel.date = todayStr;
        await insertDate(newDatemodel);
        await Future.delayed(const Duration(milliseconds: 300));
        final result =
            await db.query('dates_table', orderBy: 'date_id DESC LIMIT 1');
        final cDateModel = CMDateModel.fromJson(result.first);
        item.dateID = cDateModel.id;
        return insetRecordNext(db, item);
      }
    } else {
      final newDatemodel = CMDateModel();
      newDatemodel.date = todayStr;

      await insertDate(newDatemodel);
      await Future.delayed(const Duration(milliseconds: 300));
      final result =
          await db.query('dates_table', orderBy: 'date_id DESC LIMIT 1');
      final cDateModel = CMDateModel.fromJson(result.first);
      item.dateID = cDateModel.id;
      await insetRecordNext(db, item);
    }
  }

  Future<void> insetRecordNext(Database db, CMIntakemodel item) async {
    final tableName = item.isIntake == true ? 'intake_table' : 'consume_table';
    await db.insert(tableName, {
      'date_id': item.dateID,
      'name': item.name,
      'isIntake': item.isIntake,
      'timestamp': item.timestamp,
      'kcal': item.kcal,
      'iconName': item.iconName,
      "dateStr": item.dateStr
    });

  }

  Future<void> deleteDate(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    db.delete('dates_table', where: 'date_id = ?', whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    db.delete('intake_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clean() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('dates_table');
    await db.delete('intake_table');
    await db.delete('consume_table');
  }

  Future<List<CMDateModel>> getAllDates() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('dates_table', orderBy: 'date_id DESC');

    return result.map((e) => CMDateModel.fromJson(e)).toList();
  }

  Future<CMDateModel?> getToday() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    final today = PMAppUtil.formatDateWithoutHour(dateTime: DateTime.now());

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result =
        await db.query('dates_table', where: 'date = ?', whereArgs: [today]);

    return result.isEmpty ? null : CMDateModel.fromJson(result.first);
  }

  Future<List<CMIntakemodel>> getAllIntakeData({required int dateID}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('intake_table',
        where: 'date_id = ?', whereArgs: [dateID], orderBy: 'id DESC');
    return result.map((e) => CMIntakemodel.fromJson(e)).toList();
  }

  Future<List<CMIntakemodel>> getAllConsumData({required int dateID}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'life_record.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('consume_table',
        where: 'date_id = ?', whereArgs: [dateID], orderBy: 'id DESC');
    return result.map((e) => CMIntakemodel.fromJson(e)).toList();
  }
}
