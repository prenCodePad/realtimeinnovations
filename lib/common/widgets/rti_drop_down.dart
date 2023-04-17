import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_mixin.dart';
import 'package:get/get.dart';

class RtiDropDown extends StatelessWidget with AppMixin {
  const RtiDropDown({Key? key}) : super(key: key);

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
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              context: context,
              builder: (context) {
                var items = employeeCtlr.availableRoles;
                return SizedBox(
                  height: Get.height * 0.3,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            employeeCtlr.employeeRole.value = items[index];
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              items[index],
                              style: theme.body(),
                            ),
                          ),
                        );
                      }),
                );
              });
        },
        child: Obx(
          () => TextFormField(
            enabled: false,
            style: theme.body(),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.work_outline, color: Color(0xff1DA1F2)),
                hintText: employeeCtlr.employeeRole.value ?? "Select Role",
                hintStyle:
                    theme.body(color: employeeCtlr.employeeRole.value == null ? const Color(0xff949C9E) : Colors.black),
                suffixIcon: const Icon(Icons.arrow_drop_down, color: Color(0xff1DA1F2))),
          ),
        ),
      ),
    );
  }
}
