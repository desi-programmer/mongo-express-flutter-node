import 'package:flutter/material.dart';
import 'package:flutter_client/pages/widgets/drawer.dart';
import 'package:flutter_client/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SanitizationService extends StatefulWidget {
  @override
  _SanitizationServiceState createState() => _SanitizationServiceState();
}

class _SanitizationServiceState extends State<SanitizationService> {
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sanitization",
        ),
        centerTitle: true,
      ),
      //
      drawer: drawer(context),
      //
      body: Center(
        child: Container(
          width: context.screenWidth > 1368
              ? context.screenWidth * 0.4
              : (context.screenWidth > 600
                  ? context.screenWidth * 0.8
                  : context.screenWidth * 0.95),
          child: ListView(
            children: [
              //
              SizedBox(
                height: 12.0,
              ),
              Image.asset(
                'assets/images/sanitization.png',
                height: 256.0,
              ),
              //
              SizedBox(
                height: 12.0,
              ),
              "Sanitization".text.size(32.0).teal500.bold.center.make(),
              //
              Container(
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed metus odio. Integer venenatis mi risus, eget ultricies mi elementum et. In id mmollis mi pulvinar posuere non vitae leo. In gravida finibus metus, et laoreet nulla facilisis in. Aenean nec neque mi. Quisque pulvinar ligula ac jconsequat convallis. Aliquam ac faucibus lorem. 

Nam consectetur felis orci, in consequat nisl facilisis vel. Morbi in pulvinar libero. Sed malesuada vehicula mauris. Pellentesque et fringilla neque, vel commodo turpis. Proin iaculis dolor mattis eleifend rhoncus. Maecenas commodo dolor quis mattis mattis. Proin nulla diam, posuere in nulla sagittis, varius viverra magna. Sed lacinia eros et euismod congue. Integer tristique leo elit.
'''
                    .text
                    .size(
                      18.0,
                    )
                    .gray500
                    .make(),
              ),
              //
              SizedBox(
                height: 12.0,
              ),

              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    User user = User();
                    if (await user.isLoggedIn) {
                      _selectDate(context);
                      if (selectedDate != null) {
                        // call api to book this service
                        print(selectedDate);
                        user.bookService(context, "Sanitization",
                            selectedDate.toString().substring(0, 19));
                      }
                    } else {
                      // redirect to login page
                      VxNavigator.of(context).replace(
                        Uri(
                          path: '/login',
                          queryParameters: {'msg': 'not-authenticated'},
                        ),
                      );
                    }
                  },
                  child: Text("Book Service").text.size(20.0).semiBold.make(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "Select a service Date",
      cancelText: "Cancel booking",
      confirmText: "Book Service ",
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
