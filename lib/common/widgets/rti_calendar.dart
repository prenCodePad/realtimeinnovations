import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/common/widgets/calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class RtiCalendar extends StatelessWidget with AppMixin {
  final DateTime? dateTime;
  final Function(DateTime)? onDateSelected;
  final Function()? onCancel;
  const RtiCalendar({Key? key, this.dateTime, this.onDateSelected, this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              DateTime? date;
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.5, vertical: 16),
                  width: Get.width * 0.98,
                  height: Get.height * 0.8,
                  child: Column(
                    children: [
                      Calendar(
                          date: date,
                          onDateSelected: (p) {
                            if (onDateSelected != null) {
                              onDateSelected!(p);
                            }
                          }),
                      // TableCalendar(
                      //   calendarFormat: CalendarFormat.month,
                      //   headerStyle: const HeaderStyle(
                      //     formatButtonVisible: false,
                      //     titleCentered: true,
                      //     leftChevronPadding: EdgeInsets.zero,
                      //     rightChevronPadding: EdgeInsets.zero,
                      //     leftChevronMargin: EdgeInsets.zero,
                      //     rightChevronMargin: EdgeInsets.zero,
                      //   ),
                      //   calendarStyle: CalendarStyle(
                      //     defaultTextStyle: theme.bodySmall(),
                      //   ),
                      //   focusedDay: DateTime.now(),
                      //   firstDay: DateTime.now(),
                      //   lastDay: DateTime(2050),
                      // ),
                      Row(
                        children: [
                          _calendarIcon(),
                          Text(_text(date: date)),
                          const Spacer(),
                          rtiCancelButton(onTap: () {
                            if (onCancel != null) {
                              onCancel!();
                            }
                            employeeCtlr.employeeFromDate.value = DateTime.now();
                            Navigator.of(context).pop();
                          }),
                          gap16,
                          rtiSaveButton(onTap: () {
                            Navigator.of(context).pop();
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                // actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                // actions: [],
              );
            },
          );
          // showDatePicker(
          //   context: context,
          //   initialEntryMode: DatePickerEntryMode.input,
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime(1900),
          //   lastDate: DateTime(2500),
          //   // builder: (context, child) {
          //   //   return Text('calendar');
          //   // },
          // );
        },
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          enabled: false,
          //style: theme.body2(color: Colors.black),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: _text(),
              hintStyle: theme.body2(color: dateTime == null ? const Color(0xff949C9E) : Colors.black),
              //hintStyle: theme.overline(color: Colors.black),
              prefixIcon: _calendarIcon()),
        ),
      ),
    );
  }

  _calendarIcon() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: const Icon(
        Icons.today_outlined,
        color: Color(0xff1DA1F2),
      ),
    );
  }

  _text({DateTime? date}) {
    var now = DateTime.now();
    var datetime = date ?? dateTime;
    if (datetime == null) {
      return 'No date';
    } else if (datetime.day == now.day && datetime.month == now.month && datetime.year == now.year) {
      return 'Today';
    } else {
      return DateFormat('d MMM, y').format(datetime);
    }
  }
}
