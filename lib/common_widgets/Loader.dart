
import 'package:flutter/material.dart';

import '../resources/appcolor.dart';
import '../utils/Constance.dart';


class Loader {

  showLoader(context) {
    Constance.is_loader_show = "yes";
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 70,
              height: 70,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(
                    color: appcolor.color_blue_dark,
                    strokeWidth: 4,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  hideLoader(context) {
    if (Constance.is_loader_show == "yes") {
      Constance.is_loader_show = "no";
      Navigator.of(context).pop();
    }
  }
}
