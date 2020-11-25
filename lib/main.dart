import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project2/textInput.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2021, 1, 1): ['New Year\'s Day'],
  DateTime(2021, 1, 6): ['Epiphany'],
  DateTime(2021, 2, 14): ['Valentine\'s Day'],
  DateTime(2021, 4, 21): ['Easter Sunday'],
  DateTime(2021, 4, 22): ['Easter Monday'],
};

void main() => runApp(MaterialApp(
      home: MyHomePage(),
    ));

// class MyApp extends StatelessWidget {
//   final String actualTask;

//   MyApp({this.actualTask});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'To-Do List',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: MyHomePage(title: 'To-Do List'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;
  final String actualTask;

  MyHomePage({this.actualTask});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime noww = new DateTime.now();

  DateTime dayy;

  // _MyHomePageState({Key key, @required this.text}) : super(key: key);

  @override
  void initState() {
    dayy = new DateTime(noww.year, noww.month, noww.day);
    super.initState();
    // final _selectedDay = DateTime.now();
    print(dayy);

    DateTime now = new DateTime.now();
    final DateTime _selectedDay = new DateTime(now.year, now.month, now.day);

    print(_selectedDay);

    _events = {
      DateTime.parse("2020-11-18 12:00:00.000Z"): [
        'Event A0',
        'Event B0',
        'Event C0',
      ],
      DateTime.parse("2020-11-23 12:00:00.000Z"): [
        'Event A2',
        'Event B2',
      ],
      DateTime.parse("2020-11-13 12:00:00.000Z"): [
        'Event A4',
      ],
    };

    // _events[DateTime.now()][0] = 'shahid';
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    // print(day);
    dayy = day;

    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Switch out 2 lines below to play with TableCalendar's settings
            //-----------------------
            _buildTableCalendar(),
            // _buildTableCalendarWithBuilders(),
            // const SizedBox(height: 8.0),
            // _buildButtons(),
            const SizedBox(height: 8.0),
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => TxtIn()));
          // Navigator.of(context)
          //     .pushReplacement(MaterialPageRoute(builder: (context) {
          //   return TxtIn();
          // }));
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TxtIn();
            })).then((data) {
              // print(data.dateTime);
              // print(data.text);
              // print(_events[data.dateTime]);
              if (_events[dayy] == null) {
                _events[dayy] = [];
              }
              if (data.isNotEmpty) {
                _events[dayy].add(data);
              }
              // _events[_onDaySelected()].add(data.text);
              // print(_events);
            });
          });

          // setState(() {
          //   // if date is empty create

          //   // if (_events[dayy] == null) {
          //   //   _events[dayy] = [];
          //   // }
          //   // if (widget.actualTask == null) {
          //   //   _events[dayy].add("asdfgh");
          //   // } else {
          //   //   _events[dayy].add(widget.actualTask);
          //   //   print(widget.actualTask);
          //   //   print(_events[dayy]);
          //   // }
          //   // _selectedEvents = _events[dayy];

          //   // print(DateTime.parse("2020-11-24"));
          // });
        },
      ),
    );
  }
  // adv calendar table configs
  // built buttons

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.black,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.black, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange[700],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Dismissible(
                  key: Key(event.hashCode.toString()),
                  onDismissed: (direction) => setState(() {
                    // _selectedEvents.remove(event);
                    _events[dayy].remove(event);
                  }),
                  child: ListTile(
                    title: Text(event.toString()),
                    trailing: GestureDetector(
                      child: Icon(Icons.check_box),
                      onTap: () {
                        print(_selectedEvents);
                        print(event);

                        print(_events[dayy]);
                      },
                    ),
                    onTap: () => print('$event tapped!'),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
