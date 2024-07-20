import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// for getting formatted time milleSecondSinceEpochs String
class MyDateUtil {
  static String getFormattedTime0(
      {required BuildContext context, required String time}) {
        final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}
