import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/storage_prefs.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';

class EmployeeController extends GetxController {
  var employeeList = <Employee>[].obs;
  var employeeRole = Rxn<String>();
  var employeeFromDate = DateTime.now().obs;
  var employeeToDate = Rxn<DateTime>();
  var editMode = false.obs;
  var editEmployeeId = Rxn<String>();
  var employeeToFocusDate = DateTime.now().obs;
  var editedEmployee = Rxn<Employee>();

  TextEditingController nameController = TextEditingController();

  List<String> availableRoles = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];
  var uuid = const Uuid();
  var employeeDatabase = StoragePrefs.getStorageValue('employeelist');

  @override
  void onInit() {
    super.onInit();
    getEmployees();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void getEmployees() {
    if (employeeDatabase == null) {
      return;
    } else {
      var data = List.from(jsonDecode(employeeDatabase));
      data.map((e) {
        employeeList.add(Employee.fromJson(e));
      }).toList();
    }
  }

  void setEmployeeListInDatabase(List<Employee> employees) {
    StoragePrefs.setStorageValue('employeelist', jsonEncode(employees.map((e) => e.toJson()).toList()));
  }

  void clear() {
    employeeRole.value = null;
    nameController.clear();
    employeeFromDate.value = DateTime.now();
    employeeToFocusDate.value = DateTime.now();
    employeeToDate.value = null;
    editMode = false.obs;
    editEmployeeId.value = null;
    editedEmployee.value = null;
  }

  Error? validate() {
    if (nameController.text.trim().isEmpty) {
      return const Error('Warning', 'Please provide name of the employee');
    } else if (employeeRole.value == null) {
      return const Error('Warning', 'Please provide role of the employee');
    } else {
      return null;
    }
  }

  bool addEmployee() {
    Error? check = validate();
    if (check == null) {
      var id = uuid.v4();
      employeeList.insert(
          0,
          Employee(
            id: id,
            name: nameController.text,
            role: employeeRole.value!,
            from: employeeFromDate.value,
            to: employeeToDate.value,
          ));
      setEmployeeListInDatabase(employeeList);
      return true;
    } else {
      showSnackBar(check.title, check.message);
      return false;
    }
  }

  void undoDeleteEmployee(Employee e) {
    employeeList.insert(0, e);
    setEmployeeListInDatabase(employeeList);
  }

  void showSnackBar(String message, String title) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      backgroundColor: Colors.white,
      borderRadius: 8,
    );
  }

  void fillEditDetails(Employee employee) {
    editMode.value = true;
    editedEmployee.value = employee;
    editEmployeeId.value = employee.id;
    nameController.text = employee.name;
    employeeRole.value = employee.role;
    employeeFromDate.value = employee.from;
    employeeToDate.value = employee.to;
  }

  bool editEmployee() {
    var index = employeeList.indexWhere((e) => e.id == editEmployeeId.value);
    Error? check = validate();
    if (index != -1) {
      if (check == null) {
        employeeList[index] = Employee(
          id: editEmployeeId.value!,
          name: nameController.text,
          role: employeeRole.value!,
          from: employeeFromDate.value,
          to: employeeToDate.value,
        );
        setEmployeeListInDatabase(employeeList);
        return true;
      } else {
        showSnackBar(check.title, check.message);
        return false;
      }
    } else {
      showSnackBar('Error', 'Something Went Wrong');
      return false;
    }
  }

  void deleteEmployee(Employee employee) {
    employeeList.removeWhere((e) => e.id == employee.id);
    setEmployeeListInDatabase(employeeList);
  }
}
