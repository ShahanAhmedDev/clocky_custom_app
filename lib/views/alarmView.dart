import 'package:clocky_custom_app/Database/alarm_helper.dart';
import 'package:clocky_custom_app/constants/theme_data.dart';
import 'package:clocky_custom_app/data.dart';
import 'package:clocky_custom_app/enums.dart';
import 'package:clocky_custom_app/main.dart';
import 'package:clocky_custom_app/models/alarm_info.dart';
import 'package:clocky_custom_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// class AlarmView {
// MenuType menuType;
// AlarmView(this.menuType);
// }

class AlarmView extends StatefulWidget {
  AlarmView(this.menuType, {Key? key}) : super(key: key);
  MenuType menuType;

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  late DateTime _alarmTime;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.ininitializeDatabase().then((value) async {
      print('Database Initiailzed');
      await loadAlarms();
    });
    super.initState();
  }

  Future<void> loadAlarms() async {
    if (mounted)
      setState(() {
        _alarms = _alarmHelper.getAlarms();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var test = ref.watch(menuProvider);

        return Scaffold(
          backgroundColor: Color(0xff202F41),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  test.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Flexible(
                flex: 1,
                child: FutureBuilder(
                  future: _alarms,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AlarmInfo>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!
                              .map<Widget>(
                        (alarm) => Container(
                          // var gradientColor = GradientTemplate.gradientTemplate[e.]

                          padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            height: 130,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: GradientColors.sky,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    // color: alarm.gradientColors.last.withOpacity(0.4),
                                    color: Colors.black,
                                    blurRadius: 8,
                                    spreadRadius: 4,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.label,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            alarm.title!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                          value: true,
                                          onChanged: (bool value) {}),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Mon-Fri',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    alarm.alarmDateTime.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('pressed so deleted');
                                    _alarmHelper.delete(alarm.id!);
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                              .followedBy([
                        Container(
                          padding: EdgeInsets.all(24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomColors.clockBG,
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            height: 116,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: TextButton(
                              onPressed: () {
                                var _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                // DateTime scheduleAlarmDateTime;
                                // _alarmTimeString =
                                //     DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            children: [
                                              FlatButton(
                                                onPressed: () async {
                                                  var selectedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );
                                                  if (selectedTime != null) {
                                                    final now = DateTime.now();
                                                    var selectedDateTime =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            selectedTime.hour,
                                                            selectedTime
                                                                .minute);
                                                    _alarmTime =
                                                        selectedDateTime;
                                                    setModalState(() {
                                                      _alarmTimeString =
                                                          DateFormat('HH:mm')
                                                              .format(
                                                                  selectedDateTime);
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  _alarmTimeString,
                                                  style:
                                                      TextStyle(fontSize: 32),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Repeat'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              ListTile(
                                                title: Text('Sound'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              ListTile(
                                                title: Text('Title'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: () {
                                                  DateTime
                                                      scheduleAlarmDateTime;
                                                  if (_alarmTime
                                                      .isAfter(DateTime.now()))
                                                    scheduleAlarmDateTime =
                                                        _alarmTime;
                                                  else
                                                    scheduleAlarmDateTime =
                                                        _alarmTime.add(
                                                            Duration(days: 1));

                                                  var alarmInfo = AlarmInfo(
                                                      title: 'Work Damn int',
                                                      alarmDateTime:
                                                          scheduleAlarmDateTime
                                                              .toString(),
                                                      isPending:
                                                          true.toString(),
                                                      gradientColorIndex:
                                                          alarms.length);
                                                  _alarmHelper
                                                      .insertAlarm(alarmInfo);
                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                                // scheduleAlarm();
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/add_alarm.png',
                                    scale: 1.5,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Add Alarm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]).toList());
                    }
                    ;
                    return Center(child: Text('Loading...'));
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void scheduleAlarm() async {
    tz.initializeTimeZones();

    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Sup Bro',
        'Drink some Pani',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
