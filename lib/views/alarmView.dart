import 'package:clocky_custom_app/constants/theme_data.dart';
import 'package:clocky_custom_app/data.dart';
import 'package:clocky_custom_app/enums.dart';
import 'package:clocky_custom_app/main.dart';
import 'package:clocky_custom_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// class AlarmView {
// MenuType menuType;
// AlarmView(this.menuType);
// }

class AlarmView extends StatelessWidget {
  AlarmView(this.menuType, {Key? key}) : super(key: key);
  MenuType menuType;

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
              Expanded(
                child: ListView(
                    children: alarms
                        .map(
                  (e) => Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      height: 130,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: e.gradientColors,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: e.gradientColors.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      e.description,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Switch(value: true, onChanged: (bool value) {}),
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
                              e.alarmDateTime.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
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
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: TextButton(
                        onPressed: () {
                          scheduleAlarm();
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
                ]).toList()),
              )
            ],
          ),
        );
      },
    );
  }
  void scheduleAlarm() async{
    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

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
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
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
