// call api for registering user

import 'dart:convert';
import 'package:flutter_client/config.dart';
import 'package:flutter_client/pages/widgets/error_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void login(BuildContext context, String email, String password) async {
  try {
    var response = await http.post(
      Uri.parse(APIROUTES.login),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode == 200) {
      // grab the token
      var token = jsonDecode(response.body)['token'];
      // put in a local storage
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', token);
      // redirect to home
      VxNavigator.of(context).clearAndPush(
        Uri(path: '/'),
      );
      // everything is ok
    } else if (response.statusCode == 400) {
      // show errors
      List errors = jsonDecode(response.body)['errors'];
      print(errors);
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(
            12.0,
          ),
          color: Color(0xffeeeeee),
          child: Column(
            children: [
              for (var err in errors)
                Column(
                  children: [
                    Text(
                      "${err['msg']}",
                    ).text.center.size(18.0).make(),
                    //
                    Divider(),
                  ],
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                ),
              ),
            ],
          ),
        ),
      );
    }
  } catch (SocketException) {
    errorDialog(context, "No or Slow Network Detected !");
  }
}
