import 'package:clocky_custom_app/enums.dart';
import 'package:clocky_custom_app/models/menu_info.dart';
import 'package:clocky_custom_app/providers.dart';
import 'package:clocky_custom_app/views/clockview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data.dart';
import 'alarmView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (timeZoneString.startsWith('-')) offsetSign = '+';
    print(timeZoneString);

    return Scaffold(
      backgroundColor: Color(0xff202F41),
      // var now = Date
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                // CustomIconButton(changeMenuInfo: ,)
                menuList
                    .map((clock) => CustomIconButton(changeMenuInfo: clock))
                    .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Consumer(builder: (context, ref, child) {
            var clockType = ref.watch(menuProvider);

            if (clockType.menuType == MenuType.stopwatch) {
              return Expanded(
                  child: Container(
                child: Text(
                  'Clock',
                  style: TextStyle(color: Colors.white),
                ),
              ));
            }
            if (clockType.menuType == MenuType.alarm) {
              return Expanded(child: AlarmView(MenuType.alarm));
            }
            return Expanded(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Flexible (
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        'Clock',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedTime,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 64),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                              size: width * 0.7,
                            ))),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Timezone',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'UTC ' + offsetSign + timeZoneString,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CustomIconButton extends ConsumerWidget {
  MenuInfo changeMenuInfo;

  CustomIconButton({required this.changeMenuInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      return FlatButton(
          padding: EdgeInsets.symmetric(vertical: 16),
          onPressed: () {
            var menuInfo = ref.watch(menuProvider);
            menuInfo.updateMenu(changeMenuInfo);
            print('Pressed');
          },
          color: changeMenuInfo.title == ref.watch(menuProvider).title
              ? Colors.deepPurple
              : Colors.transparent,
          child: Column(
            children: [
              Image.asset(
                changeMenuInfo.imageSource,
                scale: 1.5,
              ),
              Text(
                changeMenuInfo.title,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ));
    });
  }
}
