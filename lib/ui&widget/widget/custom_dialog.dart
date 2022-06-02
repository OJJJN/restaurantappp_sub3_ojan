import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restauranttt_sub3_rev3/navigation&style/navigation.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Coming Soon'),
            content: const Text('Fitur ini segera hadir!'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Okay'),
                onPressed: () => Navigation.back(),
              )
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Coming Soon'),
            content: const Text('Fitur ini segera hadir!'),
            actions: [
              TextButton(
                  onPressed: () => Navigation.back(), child: const Text('Okay'))
            ],
          );
        });
  }
}
