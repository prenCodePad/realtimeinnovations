import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/common/widgets/rti_calendar.dart';
import 'package:flutter_app/common/widgets/rti_drop_down.dart';
import 'package:flutter_app/common/widgets/rti_text_field.dart';
import 'package:flutter_app/routing/routes.dart';
import 'package:get/get.dart';

class AddAndEditEmployee extends StatelessWidget with AppMixin {
  const AddAndEditEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee Details', style: theme.appBarHeading()),
        centerTitle: false,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RtiTextField(controller: employeeCtlr.nameController),
              gap16,
              const RtiDropDown(),
              gap16,
              Row(
                children: [
                  Obx(() => Expanded(
                          child: RtiCalendar(
                        dateTime: employeeCtlr.employeeFromDate.value,
                        onDateSelected: (p0) {
                          employeeCtlr.employeeFromDate.value = p0;
                        },
                        onCancel: () {
                          employeeCtlr.employeeFromDate.value = DateTime.now();
                        },
                      ))),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xff1DA1F2),
                      )),
                  Obx(() => Expanded(
                          child: RtiCalendar(
                        dateTime: employeeCtlr.employeeToDate.value,
                        onDateSelected: (p0) {
                          employeeCtlr.employeeToDate.value = p0;
                        },
                        onCancel: () {
                          employeeCtlr.employeeToDate.value = null;
                        },
                      ))),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  rtiCancelButton(onTap: () {
                    employeeCtlr.clear();
                    Navigator.of(context).pop();
                  }),
                  gap16W,
                  rtiSaveButton(onTap: () {
                    employeeCtlr.editMode.value ? employeeCtlr.editEmployee() : employeeCtlr.addEmployee();
                    employeeCtlr.clear();
                    Navigator.pushNamedAndRemoveUntil(context, Routes.employeeListPage, (route) => false);
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
