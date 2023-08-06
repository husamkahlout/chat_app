import 'package:easy_localization/easy_localization.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../router/router.dart';
import '../resources/colors_manager.dart';
import '../resources/strings_manager.dart';

class CustomAlertDialog {
  static showQuickAlert(
      {required Function()? onConfirmTap,
      required String title,
      required String text}) {
    QuickAlert.show(
      context: AppRouter.navKey.currentContext!,
      showCancelBtn: true,
      type: QuickAlertType.error,
      cancelBtnText: StringsManager.cancel.tr(),
      confirmBtnText: StringsManager.delete.tr(),
      confirmBtnColor: ColorsManager.errorColor,
      titleColor: ColorsManager.errorColor,
      title: title,
      text: text,
      onConfirmBtnTap: onConfirmTap,
    );
  }
}
// class CustomDialog {
//   static showDialogFunction(String itemName) {
//     showDialog(
//         context: AppRouter.navKey.currentContext!,
//         builder: (context) => AlertDialog(
//               actionsPadding: const EdgeInsets.only(bottom: 20, top: 10, right: 20, left: 20),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               elevation: 2,
//               contentPadding: EdgeInsets.zero,
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 80.h,
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         color: ColorsManager.errorColor),
//                     child: const Center(
//                         child: Icon(
//                       Icons.delete_forever_rounded,
//                       color: ColorsManager.whiteColor,
//                       size: 40,
//                     )),
//                   ),
//                   Padding(
//                     padding:
//                         EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Text(
//                           itemName,
//                           style: TextStyle(
//                               color: ColorsManager.errorColor,
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(
//                           height: 8.h,
//                         ),
//                         Text(
//                           StringsManager.cardDeleteText.tr(), 
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                           fontSize: 18.sp,
                          
//                         ),),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 50,
//                       width: 110.w,
//                       decoration: BoxDecoration(
//                         color: ColorsManager.errorColor,
//                         borderRadius: BorderRadius.circular(15)
//                       ),
//                       child: Center(child: Text(StringsManager.delete.tr(),
//                        style: TextStyle(
//                               color: ColorsManager.whiteColor,
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w600),)),
//                     ),
//                     SizedBox(width: 8.w),
//                     Container(
//                       height: 50,
//                       width: 110.w,
//                                          decoration: BoxDecoration(
//                             color: ColorsManager.neutral_30,
//                             borderRadius: BorderRadius.circular(15)),
//                       child: Center(
//                         child: Text(StringsManager.cancel.tr(),
//                          style: TextStyle(
//                               color: ColorsManager.neutral_100,
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w600)),
//                       )
//                     ),
//                   ],
//                 )
//               ],
//             ));
//   }
// }


