import 'package:clocky_custom_app/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';


class AlarmHelper{
  // static final AlarmHelper _alarmHelper = AlarmHelper.();
  // AlarmHelper._createInstance();
  // AlarmHelper _alarmHelper = AlarmHelper();
  static AlarmHelper? _alarmHelper;
  static Database? _database;

  AlarmHelper._createInstance();
  factory AlarmHelper(){
    if(_alarmHelper ==null){
      return _alarmHelper = AlarmHelper._createInstance();
    }
    throw 'shitty AlarmHelper method';
    // if(_alarmHelper == null){
    //   _alarmHelper = AlarmHelper._createInstance();
    // }
    // return _alarmHelper;
   // return AlarmHelper._createInstance();
  }



  //If you write a get method, you can use it in methods to as this.database or something referring to it.
  Future<Database?> get database async{
    if( _database == null){
      _database = await  ininitializeDatabase();
    }
    return _database;
  }

  Future<Database> ininitializeDatabase() async{
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';
    
  var database = openDatabase(path,version: 1,onCreate:(db, version){
    db.execute('''
    create table $tableAlarm(
    $columnId integer primary key autoincrement,
    $columnTitle text not null,
    $columnDateTime text not null,
    $columnPending text,
    $columnColorIndex integer,
    )
    
    ''');
  });
  return database;
  }
  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.ininitializeDatabase();
    if(db != null){
    var result = db.insert(tableAlarm, alarmInfo.toMap());
    print('result: $result');
    // return result;
    }
    else
      throw 'insertAlarm Method some problem';
  }


  Future<List<AlarmInfo>> getAlarms()async{
    List<AlarmInfo> _alarms = [];

    var db = await database;
    var result = await db!.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }
  Future<int> delete(int id) async {
    var db = await database;
    return await db!.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

}