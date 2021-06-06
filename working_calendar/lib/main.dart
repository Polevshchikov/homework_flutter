import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:working_calendar/utils.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double doubleVar = 0.0;
  double item = 0.0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TableCalendar(
                      // pageJumpingEnabled: true,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      locale: 'ru_RU',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _rangeStart = _selectedDay
                              .subtract(Duration(days: item.ceil()));
                          _rangeEnd = _selectedDay;
                          print(_rangeStart);
                          print(_rangeEnd);
                        });
                      },
                      // onRangeSelected: (start, end, focusedDay) {
                      //   setState(() {
                      //     _selectedDay = null;
                      //     _focusedDay = focusedDay;
                      //     _rangeStart = start;
                      //     _rangeEnd = end;
                      //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
                      //   });
                      // },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: _titleController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'Введите дату окончания обучения',
                              hintText: 'xxxx.xx.xx',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            print(_selectedDay);
                            item = doubleVar / 4;
                          });
                          // Reset
                          // setState(() {
                          //   _focusedDay = DateTime.now();
                          // });
                          if (_titleController.text.isNotEmpty) {
                            setState(() {
                              var variv = DateTime.parse(_titleController.text)
                                  .subtract(Duration(days: item.ceil()));
                              _rangeEnd = DateTime.parse(_titleController.text);
                              _rangeStart = variv;
                              _focusedDay = variv;
                              _selectedDay =
                                  DateTime.parse(_titleController.text);
                            });
                          }
                        },
                        child: Text('click')),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          controller: _subtitleController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Введите количество часов курса',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            doubleVar = double.parse(value);
                          }),
                    ),
                    SizedBox(height: 20),
                    Text('Ваш результат:'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
