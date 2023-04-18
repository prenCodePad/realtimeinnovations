import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/common/widgets/rti_calendar.dart';
import 'package:flutter_app/common/widgets/rti_action_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class RtiTo extends StatelessWidget with AppMixin {
  final DateTime? dateTime;
  final Function(DateTime)? onDateSelected;
  final Function()? onCancel;
  final Function()? onSave;
  const RtiTo({Key? key, this.dateTime, this.onDateSelected, this.onCancel, this.onSave}) : super(key: key);

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
                              employeeCtlr.employeeToDate.value == null,
                              'No date',
                              onTap: () => employeeCtlr.employeeToDate.value = null,
                            ),
                            gap16W,
                            _actionButton(
                              employeeCtlr.employeeToDate.value != null
                                  ? dateCompare(employeeCtlr.employeeToDate.value!, DateTime.now())
                                  : false,
                              'Today',
                              onTap: () {
                                employeeCtlr.employeeToDate.value = DateTime.now();
                                employeeCtlr.employeeToFocusDate.value = DateTime.now();
                              },
                            ),
                          ],
                        ),
                        Obx(() {
                          return RtiCalendar(
                              date: employeeCtlr.employeeToDate.value,
                              focusToDate: employeeCtlr.employeeToFocusDate.value,
                              outsideDaysVisible: true,
                              to: true,
                              onPageChanged: (p0) {
                                if (employeeCtlr.employeeToDate.value != null &&
                                    p0.month == employeeCtlr.employeeToDate.value!.month) {
                                  employeeCtlr.employeeToFocusDate.value = employeeCtlr.employeeToDate.value!;
                                } else {
                                  employeeCtlr.employeeToFocusDate.value = p0;
                                }
                              },
                              rangeStartDay: employeeCtlr.employeeFromDate.value,
                              onDaySelected: (p, q) {
                                employeeCtlr.employeeToDate.value = p;
                                employeeCtlr.employeeToFocusDate.value = p;
                              });
                        }),
                        const Spacer(),
                        Row(
                          children: [
                            _calendarIcon(),
                            gap12W,
                            Text(_text(date: employeeCtlr.employeeToDate.value)),
                            const Spacer(),
                            rtiCancelButton(onTap: () {
                              if (onCancel != null) {
                                onCancel!();
                              }
                              Navigator.of(context).pop();
                            }),
                            gap16W,
                            rtiSaveButton(onTap: () {
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
              hintText: _text(),
              contentPadding: const EdgeInsets.only(bottom: 12),
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
