import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/common/widgets/rti_calendar.dart';
import 'package:flutter_app/common/widgets/rti_drop_down.dart';
import 'package:flutter_app/common/widgets/rti_text_field.dart';
import 'package:flutter_app/models/employee.dart';
import 'package:flutter_app/pages/employee/widgets/rti_from_widget.dart';
import 'package:flutter_app/pages/employee/widgets/rti_to_widget.dart';
import 'package:flutter_app/routing/routes.dart';
import 'package:get/get.dart';

class AddAndEditEmployee extends StatelessWidget with AppMixin {
  const AddAndEditEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(employeeCtlr.editMode.value ? 'Edit Employee Details' : 'Add Employee Details',
              style: theme.appBarHeading()),
        ),
        actions: [
          Obx(() {
            return employeeCtlr.editMode.value
                ? IconButton(
                    onPressed: () {
                      var editedEmployee = employeeCtlr.editedEmployee.value;
                      if (editedEmployee != null) {
                        employeeCtlr.deleteEmployee(editedEmployee!);
                        Navigator.pushNamedAndRemoveUntil(context, Routes.employeeListPage, (route) => false);
                        employeeCtlr.clear();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar(editedEmployee));
                      }
                    },
                    icon: const Icon(CupertinoIcons.delete_solid),
                  )
                : const SizedBox();
          }),
        ],
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
                          child: RtiFrom(
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
                          child: RtiTo(
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
                    Navigator.pushNamedAndRemoveUntil(context, Routes.employeeListPage, (route) => false);
                  }),
                  gap16W,
                  rtiSaveButton(onTap: () {
                    bool action =
                        employeeCtlr.editMode.value ? employeeCtlr.editEmployee() : employeeCtlr.addEmployee();
                    if (action) {
                      employeeCtlr.clear();
                      Navigator.pushNamedAndRemoveUntil(context, Routes.employeeListPage, (route) => false);
                    }
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  SnackBar snackBar(Employee e) => SnackBar(
        content: const Text('Employee data has been deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            employeeCtlr.undoDeleteEmployee(e);
          },
        ),
      );
}
