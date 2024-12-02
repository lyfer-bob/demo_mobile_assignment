import 'package:demo_mobile_assignment/controllers/demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DemoScreen extends StatelessWidget {
  // format icon
  // if you want new format you change it
  final DemoController ctrl = Get.find();

  DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text(
            'Example ',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 189, 189, 188)),
          ),
        )),
        body: Obx(() => ScrollablePositionedList.builder(
              padding: const EdgeInsets.only(bottom: 10),
              scrollDirection: Axis.vertical,
              itemScrollController: ctrl.demoScrnScrollCtrl,
              itemCount: ctrl.listFiboncNumModel.length,
              itemBuilder: (context, i) => _rowItems(
                index: i,
                isShow: ctrl.listFiboncNumModel[i].isBottomSheet == false,
                ontab: () => _showbottomsheet(context, i),
              ),
            )),
      ),
    );
  }

  Widget _rowItems({
    required int index,
    required bool isShow,
    required Function()? ontab,
  }) {
    return Obx(() => Visibility(
          visible: isShow,
          child: InkWell(
            onTap: ontab,
            child: Container(
              color: ctrl.checkhighlight(index),
              padding:
                  EdgeInsets.only(bottom: 10, top: 10, left: 3.w, right: 6.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                          'index : ${ctrl.listFiboncNumModel[index].indexNo}, ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      Text(
                          'isShow : ${ctrl.listFiboncNumModel[index].isBottomSheet}, ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      Text(
                          'Number : ${ctrl.listFiboncNumModel[index].fiboncNum}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      _getIconStop(
                        isShow: ctrl.listFiboncNumModel[index].iconFlag! == 1,
                        icon: Icons.stop_circle,
                      ),
                      _getIconCheck(
                        isShow: ctrl.listFiboncNumModel[index].iconFlag! == 2,
                        icon: Icons.check_circle,
                      ),
                      _getIconRemove(
                        isShow: ctrl.listFiboncNumModel[index].iconFlag! == 3,
                        icon: Icons.remove_circle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _getIconStop({required bool isShow, required IconData icon}) {
    return Visibility(
      visible: isShow,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          icon,
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _getIconCheck({required bool isShow, required IconData icon}) {
    return Visibility(
        visible: isShow,
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(
            icon,
            size: 20,
            color: const Color.fromARGB(255, 58, 209, 63),
          ),
        ));
  }

  Widget _getIconRemove({required bool isShow, required IconData icon}) {
    return Visibility(
      visible: isShow,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          icon,
          size: 20,
          color: Colors.red,
        ),
      ),
    );
  }

  Future<void> _showbottomsheet(BuildContext context, int index) async {
    ctrl.addItemToBottomSheeet(index);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Obx(() => ScrollablePositionedList.builder(
                padding: EdgeInsets.only(bottom: 5.h),
                scrollDirection: Axis.vertical,
                itemScrollController: ctrl.bottomScrollCtrl,
                itemCount: ctrl.listFiboncNumModel.length,
                itemBuilder: (context, i) => _rowItems(
                  index: i,
                  isShow: ctrl.isShowInBottomSheet(i),
                  ontab: () => ctrl.removeItemFromBottomSheet(i),
                ),
              ));
        });
    ctrl.addItemScroll(index);
  }
}
