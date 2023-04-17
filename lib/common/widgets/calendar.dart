import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class Calendar extends StatefulWidget {
  final DateTime? date;
  final Function(DateTime)? onDateSelected;
  const Calendar({Key? key, this.date, this.onDateSelected}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date ?? DateTime.now();
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: math.pi,
          child: InkWell(
            child: const Icon(Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
              });
            },
          ),
        ),
        Text(
          DateFormat.yMMMM().format(_selectedDate),
          style: const TextStyle(fontSize: 20),
        ),
        Transform.rotate(
          angle: 0,
          child: InkWell(
            child: const Icon(Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDaysOfWeek() {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      children: daysOfWeek
          .map((day) => Expanded(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    final firstWeekdayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;
    final weeks = ((firstWeekdayOfMonth + daysInMonth) / 7).ceil();

    List<Widget> rows = [];
    for (int week = 0; week < weeks; week++) {
      List<Widget> days = [];
      for (int weekday = 1; weekday <= 7; weekday++) {
        int dayOfMonth = (week * 7) + weekday - firstWeekdayOfMonth + 1;
        if (dayOfMonth < 1 || dayOfMonth > daysInMonth) {
          days.add(Expanded(child: Container()));
        } else {
          DateTime date = DateTime(_selectedDate.year, _selectedDate.month, dayOfMonth);
          days.add(Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(date);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: date == DateTime.now() ? Colors.blueAccent : null,
                ),
                child: Center(
                  child: Text(
                    dayOfMonth.toString(),
                    style: TextStyle(color: date == _selectedDate ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          ));
        }
      }
      rows.add(Row(children: days));
    }

    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildDaysOfWeek(),
        _buildCalendar(),
      ],
    );
  }
}
