import 'package:flutter/material.dart';
import 'package:flutter_app/common/widgets/rti_action_button.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../config/config.dart';
import '../controllers/controllers.dart';

mixin AppMixin {
  AppSizes get sizes => GetIt.I<AppSizes>();
  AppTheme get theme => GetIt.I<AppTheme>();
  EmployeeController get employeeCtlr => Get.put(EmployeeController());
  Widget get gap16 => const SizedBox(height: 16);
  Widget get gap12 => const SizedBox(height: 12);
  Widget get gap10 => const SizedBox(height: 10);
  Widget get gap16W => const SizedBox(width: 16);
  Widget get gap12W => const SizedBox(width: 12);
  Widget rtiCancelButton({void Function()? onTap}) => RtiActionButton(
        text: 'Cancel',
        onTap: onTap,
        backgroundColor: const Color(0xffEDF8FF),
        textColor: const Color(0xff1DA1F2),
      );
  Widget rtiSaveButton({void Function()? onTap}) => RtiActionButton(
        text: 'Save',
        onTap: onTap,
        backgroundColor: const Color(0xff1DA1F2),
        textColor: Colors.white,
      );

  DateTime get nextMonday {
    DateTime today = DateTime.now();
    int daysUntilNextMonday = DateTime.monday - today.weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    DateTime nextMonday = today.add(Duration(days: daysUntilNextMonday));
    return nextMonday;
  }

  DateTime get nextTuesday {
    DateTime today = DateTime.now();
    int daysUntilNextTuesday = DateTime.tuesday - today.weekday;
    if (daysUntilNextTuesday <= 0) {
      daysUntilNextTuesday += 7;
    }
    DateTime nextTuesday = today.add(Duration(days: daysUntilNextTuesday));
    return nextTuesday;
  }

  DateTime get afterOneWeek {
    DateTime today = DateTime.now();
    DateTime nextWeek = today.add(const Duration(days: 7));
    DateTime dayAfterOneWeek = nextWeek.add(const Duration(days: 1));
    return dayAfterOneWeek;
  }

  bool dateCompare(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }

  void logoutUser() {
    Get.delete<EmployeeController>();
  }
}
