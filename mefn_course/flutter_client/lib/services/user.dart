import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/config.dart';
import 'package:flutter_client/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class User {
  Future<String> get token async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.value(pref.getString('token'));
  }

  Future<bool> get isLoggedIn async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map> userProfile(BuildContext context) async {
    try {
      String _token = await token;
      var response = await http.get(
        Uri.parse(APIROUTES.profile),
        headers: {
          'x-auth-token': _token,
        },
      );

      if (response.statusCode == 200) {
        // everything is ok

        Map decoded = jsonDecode(response.body);
        return Future.value(decoded);
      } else {
        // NOTE : Better check for 401 response code
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        //
        // redirect to login page
        VxNavigator.of(context).replace(
          Uri(
            path: '/login',
            queryParameters: {'msg': 'not-authenticated'},
          ),
        );
        return Future.error("ERROR");
      }
    } catch (SocketException) {
      print("Netwrok Error !");
      return Future.error("ERROR");
    }
  }

  void logout(BuildContext context) async {
    String _token = await token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // make a request to server
    http.get(
      Uri.parse(APIROUTES.logout),
      headers: {
        'x-auth-token': _token,
      },
    );
    //
    VxNavigator.of(context).clearAndPush(Uri(path: '/'));
  }

  bookService(BuildContext context, String service, String date) async {
    try {
      String _token = await token;
      var response = await http.post(
        Uri.parse(APIROUTES.bookService),
        body: jsonEncode({
          'service': service,
          'date': date,
        }),
        headers: {
          'x-auth-token': _token,
          'Content-Type': "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        // everything is ok
        print("Booked !");
        VxToast.show(context, msg: "Service Booked !");
      } else if (response.statusCode == 401) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        //
        // redirect to login page
        VxNavigator.of(context).replace(
          Uri(
            path: '/login',
            queryParameters: {'msg': 'not-authenticated'},
          ),
        );
        return Future.error("ERROR");
      } else {
        print("Unexpcted Error ");
      }
    } catch (SocketException) {
      print("Netwrok Error !");
    }
  }

  Future<List> bookingsHistory(BuildContext context) async {
    try {
      String _token = await token;
      var response = await http.get(
        Uri.parse(APIROUTES.bookings),
        headers: {
          'x-auth-token': _token,
        },
      );

      if (response.statusCode == 200) {
        // everything is ok
        Map decodedData = jsonDecode(response.body);
        return Future.value(decodedData['bookings']);
      } else if (response.statusCode == 401) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        //
        // redirect to login page
        VxNavigator.of(context).replace(
          Uri(
            path: '/login',
            queryParameters: {'msg': 'not-authenticated'},
          ),
        );
        return Future.error("ERROR");
      } else {
        print("Unexpcted Error ");
        return Future.error("ERROR");
      }
    } catch (SocketException) {
      print("Netwrok Error !");
      return Future.error("ERROR");
    }
  }
}
