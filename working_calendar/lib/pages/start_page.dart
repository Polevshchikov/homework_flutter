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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              InputDate(),
              const SizedBox(height: 10),
              InputStudyingTime(),
              ActionButton(),
              SwitchButton(),
              CalendarStartPage(),
              const SizedBox(height: 20),
              TextPage(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
