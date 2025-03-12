
import 'package:flutter/material.dart';

import '../resources/appcolor.dart';
import 'CustomText.dart';

class CustomDialog extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String? okayText; // Optional okay button text
  final String? cancelText; // Optional cancel button text
  final Function? onOkay; // Optional onOkay callback
  final Function? onCancel; // Optional onCancel callback

  CustomDialog({
    required this.imageUrl,
    required this.message,
    this.okayText,
    this.cancelText,
    this.onOkay,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(imageUrl, width: 100, height: 100, fit: BoxFit.contain),
      content: CustomText(text: message,textAlign: TextAlign.center,fontWeight: FontWeight.normal,fontsize: 18,fontcolor: appcolor.color_black,),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (cancelText != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: appcolor.redbright
                ),
                child: TextButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    }
                    Navigator.pop(context);
                  },
                  child:CustomText(text: cancelText!,textAlign: TextAlign.center,fontWeight: FontWeight.normal,fontsize: 18,fontcolor: appcolor.color_white,),
                ),
              ),
            SizedBox(width: 20,),
            if (okayText != null)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: appcolor.color_blue_dark
                ),
                child: TextButton(
                  onPressed: () {
                    if (onOkay != null) {
                      onOkay!();
                    }
                    Navigator.pop(context);
                  },
                  child: CustomText(text: okayText!,textAlign: TextAlign.center,fontWeight: FontWeight.normal,fontsize:18,fontcolor: appcolor.color_white,),
                ),
              ),
          ],
        )

      ],
    );
  }
}
