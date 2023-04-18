import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;

class RtiCalendar extends StatefulWidget with AppMixin {
  final DateTime? date;
  final void Function(DateTime, DateTime)? onDaySelected;
  final bool outsideDaysVisible;
  final DateTime? focusToDate;
  final void Function(DateTime)? onPageChanged;
  final DateTime? rangeStartDay;

  final bool to;

  const RtiCalendar({
    Key? key,
    this.date,
    this.onDaySelected,
    this.outsideDaysVisible = false,
    this.to = false,
    this.rangeStartDay,
    this.onPageChanged,
    this.focusToDate,
  }) : super(key: key);

  @override
  State<RtiCalendar> createState() => _RtiCalendarState();
}

class _RtiCalendarState extends State<RtiCalendar> with AppMixin {
  DateTime pageFocus = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: CalendarFormat.month,
      currentDay: DateTime.now(),
      onDaySelected: (p, q) {
        if (widget.onDaySelected != null) {
          if (widget.rangeStartDay != null && widget.rangeStartDay!.isAfter(p)) {
          } else {
            widget.onDaySelected!(p, q);
          }
        }
      },
      //rangeStartDay: widget.rangeStartDay,

      selectedDayPredicate: (day) {
        return isSameDay(day, widget.date);
      },
      onPageChanged: widget.onPageChanged,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: theme.head1(color: Colors.black),
        leftChevronIcon: widget.to && widget.rangeStartDay!.month == widget.focusToDate!.month
            ? GestureDetector(
                onTap: () {},
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: const Color(0xff949C9E).withOpacity(0.5),
                    size: 32,
                  ),
                ),
              )
            : Transform.rotate(
                angle: math.pi / 2,
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff949C9E),
                  size: 32,
                ),
              ),
        rightChevronIcon: Transform.rotate(
          angle: -90 * math.pi / 180,
          child: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xff949C9E),
            size: 32,
          ),
        ),
        leftChevronPadding: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        leftChevronMargin: EdgeInsets.only(left: 40),
        rightChevronMargin: EdgeInsets.only(right: 40),
      ),
      rangeStartDay: widget.rangeStartDay,
      rangeSelectionMode: widget.to ? RangeSelectionMode.toggledOff : RangeSelectionMode.disabled,
      rangeEndDay: DateTime(2050),
      daysOfWeekHeight: 32,
      rowHeight: 44,
      calendarStyle: CalendarStyle(
        defaultTextStyle: theme.bodySmall(color: widget.to ? Colors.black.withOpacity(0.2) : Colors.black),
        outsideTextStyle: theme.bodySmall(color: Colors.black.withOpacity(0.2)),
        weekendTextStyle: theme.bodySmall(color: widget.to ? Colors.black.withOpacity(0.2) : Colors.black),
        rangeStartTextStyle: theme.bodySmall(),
        withinRangeTextStyle: theme.bodySmall(),
        withinRangeDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        rangeStartDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        rangeEndDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        rangeHighlightColor: Colors.transparent,
        selectedTextStyle: widget.to && widget.date != null && dateCompare(widget.date!, widget.focusToDate!)
            ? theme.bodySmall(color: const Color(0xff1DA1F2))
            : theme.bodySmall(color: Colors.white),
        selectedDecoration:
            BoxDecoration(color: widget.to ? Colors.transparent : const Color(0xff1DA1F2), shape: BoxShape.circle),
        outsideDaysVisible: false,
        todayTextStyle: theme.bodySmall(color: widget.to ? Colors.black : const Color(0xff1DA1F2)),
        todayDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
      ),
      focusedDay: widget.to ? widget.focusToDate! : widget.date ?? DateTime.now(),
      firstDay: DateTime(1900),
      lastDay: DateTime(2050),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: theme.bodySmall(),
        weekendStyle: theme.bodySmall(),
      ),
    );
  }
}
