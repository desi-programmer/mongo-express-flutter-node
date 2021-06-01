// ERROR DIALOG WHEN NETWORK IS NOT PRESENT

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String data) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "ERROR",
      ),
      content: Text(
        "$data",
      ),
    ),
  );
}
