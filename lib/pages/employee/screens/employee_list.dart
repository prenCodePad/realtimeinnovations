import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:flutter_app/pages/employee/widgets/employee_record.dart';
import 'package:flutter_app/routing/routes.dart';
import 'package:get/get.dart';

class EmployeeListPage extends StatelessWidget with AppMixin {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List', style: theme.appBarHeading()),
        centerTitle: false,
      ),
      body: SafeArea(child: Obx(() {
        var employeeList = employeeCtlr.employeeList;
        var currentEmployeeList = employeeList.where((e) => e.to == null).toList();
        var previousEmployeeList = employeeList.where((f) => f.to != null).toList();
        if (employeeList.isEmpty) {
          return Container(
            height: Get.height * 0.8,
            width: Get.width,
            color: const Color(0xffF2F2F2),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/no_employee.png'),
              ),
            ),
          );
        } else {
          return Container(
            height: Get.height * 0.8,
            width: Get.width,
            color: const Color(0xffF2F2F2),
            child: Column(
              children: [
                _header('Current employees'),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        itemCount: currentEmployeeList.length,
                        itemBuilder: (context, index) {
                          return EmployeeRecord(employee: currentEmployeeList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                              width: Get.width, height: 0.5, color: const Color(0xff949C9E).withOpacity(0.2));
                        },
                      ),
                    )),
                _header('Previous employees'),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        itemCount: previousEmployeeList.length,
                        itemBuilder: (context, index) {
                          return EmployeeRecord(employee: previousEmployeeList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                              width: Get.width, height: 0.5, color: const Color(0xff949C9E).withOpacity(0.2));
                        },
                      ),
                    )),
                gap12,
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Swipe left to delete',
                    style: theme.bodySmall(color: const Color(0xff949C9E)),
                  ),
                )
              ],
            ),
          );
        }
      })),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, Routes.addAndEditEmployeePage, (route) => false);
          },
          child: const Icon(Icons.add, color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  _header(String heading) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        heading,
        style: const TextStyle(
          color: Color(0xff1DA1F2),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
