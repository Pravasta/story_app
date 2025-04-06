import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../theme/app_color.dart';

class AppDialog {
  void showLoadingDialog(
    BuildContext context,
    SimpleFontelicoProgressDialog dialog,
  ) {
    dialog.show(
      message: "Loading ...",
      type: SimpleFontelicoProgressDialogType.iphone,
      horizontal: false,
      hideText: false,
      indicatorColor: AppColor.primary,
      radius: 8.0,
      backgroundColor: Colors.white.withOpacity(0.25),
    );
  }

  static defaultDialog(
    BuildContext context,
    String title, {
    required Widget child,
    bool isDynamicHeight = true,
  }) {
    Widget header() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: AppColor.primary,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: Text(title)),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close, color: AppColor.primary),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      scrollable: isDynamicHeight ? false : true,
      insetPadding: const EdgeInsets.all(16.0),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
        height: isDynamicHeight ? null : MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: isDynamicHeight ? MainAxisSize.min : MainAxisSize.min,
          children: [
            header(),
            const SizedBox(height: 24.0),
            isDynamicHeight
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: child,
                )
                : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: child,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
