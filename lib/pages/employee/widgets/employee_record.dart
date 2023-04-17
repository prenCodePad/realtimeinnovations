import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/models/employee.dart';
import 'package:flutter_app/routing/routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeRecord extends StatelessWidget with AppMixin {
  final Employee employee;
  const EmployeeRecord({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        employeeCtlr.fillEditDetails(employee);
        Navigator.pushNamedAndRemoveUntil(context, Routes.addAndEditEmployeePage, (route) => false);
      },
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (_) => employeeCtlr.deleteEmployee(employee),
            backgroundColor: const Color(0xFFF34642),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: '',
          ),
        ]),
        child: Container(
          width: Get.width,
          height: 104,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.name, style: theme.label()),
              gap10,
              Text(employee.role, style: theme.label1(color: const Color(0xff949C9E))),
              gap10,
              Text(_dateString(), style: theme.label1(color: const Color(0xff949C9E)))
            ],
          ),
        ),
      ),
    );
  }

  _dateString() {
    if (employee.to == null) {
      return 'From ${DateFormat('d MMM, y').format(employee.from)}';
    } else {
      return '${DateFormat('d MMM, y').format(employee.from)} - ${DateFormat('d MMM, y').format(employee.to!)}';
    }
  }
}
