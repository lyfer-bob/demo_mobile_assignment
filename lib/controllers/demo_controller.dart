import 'package:demo_mobile_assignment/models/fibonc_num_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DemoController extends GetxController {
  List<int> fiboncNum = [0, 1];
  int fiboncNumLengh = 0;

  ItemScrollController demoScrnScrollCtrl = ItemScrollController();
  ItemScrollController bottomScrollCtrl = ItemScrollController();

  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  RxList<FiboncNumModel> listFiboncNumModel = <FiboncNumModel>[].obs;

  List<int> formatIcon = [];

  Future<void> init() async {
    //if you want more  Fibonacci numbers.
    // you chante change it
    fiboncNumLengh = 39;

    // format icon can change but follow up with icon
    // ex.formatIcon = [1, 2, 2, 3]; ,formatIcon =  [1, 1, 2, 2, 3, 3];
    // if ex.formatIcon = [1, 2, 3, 4] , you need to add icon format type 4 in demo page
    formatIcon = [1, 2, 2, 3, 1, 3, 3, 2];

    // fiboncNumLengh = 39 + 2(fiboncNum.lenng) = 41 after add item
    //but first index = 0 , last index = 40 follow up "Example of Diaplay list fibonacci"
    for (var i = 0; i < fiboncNumLengh; i++) {
      fiboncNum.add(fiboncNum.last + fiboncNum[fiboncNum.length - 2]);
    }

    // add icon flag for check icon type
    for (var i = 0; i < fiboncNum.length; i++) {
      listFiboncNumModel.add(
        FiboncNumModel(
          indexNo: i,
          fiboncNum: fiboncNum[i],
          iconFlag: formatIcon[i % formatIcon.length],
          isFocus: false,
          isBottomSheet: false,
        ),
      );
    }
  }

  void addItemToBottomSheeet(int index) {
    listFiboncNumModel
      ..[index].isBottomSheet = true
      ..where((ele) => ele.isBottomSheet == true)
          .fold(false, (focus, FiboncNumModel model) => model.isFocus = focus)
      ..[index].isFocus = true
      ..refresh();
  }

  void addItemScroll(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottomScrollCtrl.jumpTo(index: index, alignment: 0);
    });
  }

  void removeItemFromBottomSheet(int index) {
    listFiboncNumModel
      ..[index].isBottomSheet = false
      ..where((ele) => ele.isBottomSheet == false)
          .fold(false, (focus, FiboncNumModel model) => model.isFocus = focus)
      ..[index].isFocus = true
      ..refresh();

    Get.back(); // same as Navigator.pop(context);

    if (!demoScrnScrollCtrl.isAttached) return;

    demoScrnScrollCtrl.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.linear,
      alignment: 0,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!demoScrnScrollCtrl.isAttached) return;

      // set align when scrolling
      double align = index > 30
          ? 0.9
          : index > 15
              ? 0.5
              : 0;

      demoScrnScrollCtrl.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.linear,
        alignment: align,
      );
    });
  }

  bool isShowInBottomSheet(int index) {
    if (listFiboncNumModel[index].isBottomSheet == true) {
      int iconFlagShow = listFiboncNumModel
          .firstWhere((ele) => ele.isFocus == true && ele.isBottomSheet == true,
              orElse: () => FiboncNumModel(iconFlag: -1))
          .iconFlag!;
      if (listFiboncNumModel[index].iconFlag == iconFlagShow) return true;
    }
    return false;
  }

  Color checkhighlight(int index) {
    if (listFiboncNumModel[index].isBottomSheet! &&
        listFiboncNumModel[index].isFocus!) return Colors.blue;
    if (!listFiboncNumModel[index].isBottomSheet! &&
        listFiboncNumModel[index].isFocus!) return Colors.amber;

    return Colors.transparent;
  }
}
