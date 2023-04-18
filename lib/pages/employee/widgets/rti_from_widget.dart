import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/common/widgets/rti_calendar.dart';
import 'package:flutter_app/common/widgets/rti_action_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class RtiFrom extends StatelessWidget with AppMixin {
  final DateTime? dateTime;
  final Function(DateTime)? onDateSelected;
  final Function()? onCancel;
  final Function()? onSave;
  const RtiFrom({Key? key, this.dateTime, this.onDateSelected, this.onCancel, this.onSave}) : super(key: key);

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
          FocusManager.instance.primaryFocus?.unfocus();
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, animationBuilder) {
              DateTime? date;
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: Get.height * 0.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.5, vertical: 16),
                  width: Get.width,
                  height: Get.height,
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            _actionButton(
                              dateCompare(employeeCtlr.employeeFromDate.value, DateTime.now()),
                              'Today',
                              onTap: () => employeeCtlr.employeeFromDate.value = DateTime.now(),
                            ),
                            gap16W,
                            _actionButton(
                              dateCompare(employeeCtlr.employeeFromDate.value, nextMonday),
                              'Next Monday',
                              onTap: () => employeeCtlr.employeeFromDate.value = nextMonday,
                            ),
                          ],
                        ),
                        gap16,
                        Row(
                          children: [
                            _actionButton(
                              dateCompare(employeeCtlr.employeeFromDate.value, nextTuesday),
                              'Next Tuesday',
                              onTap: () => employeeCtlr.employeeFromDate.value = nextTuesday,
                            ),
                            gap16W,
                            _actionButton(
                              dateCompare(employeeCtlr.employeeFromDate.value, afterOneWeek),
                              'After 1 week',
                              onTap: () => employeeCtlr.employeeFromDate.value = afterOneWeek,
                            ),
                          ],
                        ),
                        Obx(
                          () => RtiCalendar(
                              date: employeeCtlr.employeeFromDate.value,
                              onDaySelected: (p, q) {
                                employeeCtlr.employeeFromDate.value = p;
                              }),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            _calendarIcon(),
                            gap12W,
                            Text(_text(date: employeeCtlr.employeeFromDate.value)),
                            const Spacer(),
                            rtiCancelButton(onTap: () {
                              if (onCancel != null) {
                                onCancel!();
                              }
                              Navigator.of(context).pop();
                            }),
                            gap16W,
                            rtiSaveButton(onTap: () {
                              if (!employeeCtlr.editMode.value) {
                                employeeCtlr.employeeToFocusDate.value = employeeCtlr.employeeFromDate.value;
                              }
                              Navigator.of(context).pop();
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          enabled: false,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 12),
              hintText: _text(),
              hintStyle: theme.body2(color: dateTime == null ? const Color(0xff949C9E) : Colors.black),
              //hintStyle: theme.overline(color: Colors.black),
              prefixIcon: _calendarIcon()),
        ),
      ),
    );
  }

  _actionButton(bool selected, String text, {void Function()? onTap}) {
    return Expanded(
      child: RtiActionButton(
        text: text,
        backgroundColor: selected ? const Color(0xff1DA1F2) : const Color(0xffEDF8FF),
        textColor: !selected ? const Color(0xff1DA1F2) : Colors.white,
        onTap: onTap,
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
