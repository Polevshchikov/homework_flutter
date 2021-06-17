import 'package:flutter/material.dart';
import 'package:working_calendar/widgets/action_button.dart';
import 'package:working_calendar/widgets/calendar_start_page.dart';
import 'package:working_calendar/widgets/input_date.dart';
import 'package:working_calendar/widgets/input_studying_time.dart';
import 'package:working_calendar/widgets/switch_button.dart';
import 'package:working_calendar/widgets/text_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        // backgroundColor: Colors.blue[100],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/date.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MediaQuery.of(context).size.width < 450
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                InputDate(),
                                const SizedBox(height: 10),
                                InputStudyingTime(),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              ActionButton(),
                              SwitchButton(),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                InputDate(),
                                const SizedBox(height: 10),
                                InputStudyingTime(),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              ActionButton(),
                              SwitchButton(),
                            ],
                          ),
                        ],
                      ),
                CalendarStartPage(),
                const SizedBox(height: 20),
                TextPage(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
