import 'package:flutter/material.dart';
import 'package:flutter_app/pages/employee/screens/add_edit_employee.dart';
import 'package:flutter_app/pages/employee/screens/employee_list.dart';

import '../pages/pages.dart';
import 'package:flutter_app/routing/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var path = settings.name;
    if (settings.name == '/') path = Routes.employeeListPage;
    switch (path) {
      case Routes.employeeListPage:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const EmployeeListPage(), settings: settings);
      case Routes.addAndEditEmployeePage:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const AddAndEditEmployee(), settings: settings);
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const ErrorPage(), settings: settings);
    }
  }
}
