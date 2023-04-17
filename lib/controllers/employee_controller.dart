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

  TextEditingController nameController = TextEditingController();

  List<String> availableRoles = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];
  var uuid = const Uuid();
  var employeeDatabase = StoragePrefs.getStorageValue('employeelist');

  @override
  void onInit() {
    employeeList.value = employeeDatabase ?? [];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setEmployeeListInDatabase(List<Employee> employees) {
    StoragePrefs.setStorageValue('employeelist', employees);
  }

  void clear() {
    employeeRole.value = null;
    nameController.clear();
    employeeFromDate.value = DateTime.now();
    employeeToDate.value = null;
    editMode = false.obs;
    editEmployeeId.value = null;
  }

  Error? validate() {
    if (nameController.text.isEmpty) {
      return const Error('Warning', 'Please provide name of the employee');
    } else if (employeeRole.value == null) {
      return const Error('Warning', 'Please provide role of the employee');
    } else {
      return null;
    }
  }

  void addEmployee() {
    Error? check = validate();
    if (check == null) {
      var id = uuid.v4();
      employeeList.add(Employee(
        id: id,
        name: nameController.text,
        role: employeeRole.value!,
        from: employeeFromDate.value,
        to: employeeToDate.value,
      ));
      //setEmployeeListInDatabase(employeeList);
    } else {
      showSnackBar(check.title, check.message);
    }
  }

  void showSnackBar(String title, String message) {
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
    editEmployeeId.value = employee.id;
    nameController.text = employee.name;
    employeeRole.value = employee.role;
    employeeFromDate.value = employee.from;
    employeeToDate.value = employee.to;
  }

  void editEmployee() {
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
        //setEmployeeListInDatabase(employeeList);
      } else {
        showSnackBar(check.title, check.message);
      }
    } else {
      showSnackBar('Error', 'Something Went Wrong');
    }
  }

  void deleteEmployee(Employee employee) {
    employeeList.removeWhere((e) => e.id == employee.id);
    //setEmployeeListInDatabase(employeeList);
  }
}
