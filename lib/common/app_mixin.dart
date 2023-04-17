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
  Widget get gap10 => const SizedBox(height: 10);
  Widget get gap16W => const SizedBox(width: 16);
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

  void logoutUser() {
    Get.delete<EmployeeController>();
  }
}
