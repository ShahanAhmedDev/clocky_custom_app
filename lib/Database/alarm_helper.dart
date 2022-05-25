import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDataTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';


class AlarmHelper{

  AlarmHelper._createInstance();
  AlarmHelper _alarmHelper = AlarmHelper();
  static late Database _database;


  factory AlarmHelper(){
    // if(_alarmHelper == null){
    //   _alarmHelper = AlarmHelper._createInstance();
    // }
    // return _alarmHelper;
   return AlarmHelper._createInstance();
  }

  Future<Database> get database async{
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
    $columnDataTime text not null,
    $columnPending integer,
    $columnColorIndex integer
    )
    
    ''');

  });

  return database;
  }
}