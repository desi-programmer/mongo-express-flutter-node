import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/services/user.dart';
import 'package:velocity_x/velocity_x.dart';

Widget drawer(BuildContext context) {
  User user = User();
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 150.0,
          color: Colors.teal,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(
            12.0,
          ),
          child: "RURAL Clap".text.size(24.0).white.bold.make(),
        ),
        //
        FutureBuilder(
          future: user.isLoggedIn,
          builder: (context, snashot) {
            if (snashot.hasData) {
              if (snashot.data) {
                // logged in user available
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        VxNavigator.of(context).push(
                          Uri(path: '/profile'),
                        );
                      },
                      title: Text("Profile").text.size(20.0).semiBold.make(),
                    ),
                    ListTile(
                      onTap: () {
                        VxNavigator.of(context).push(
                          Uri(path: '/bookings'),
                        );
                      },
                      title: Text("Bookings History")
                          .text
                          .size(20.0)
                          .semiBold
                          .make(),
                    ),
                    ListTile(
                      onTap: () {
                        user.logout(context);
                      },
                      title: Text("Logout").text.size(20.0).semiBold.make(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        VxNavigator.of(context).push(
                          Uri(path: '/login'),
                        );
                      },
                      title: Text("Login").text.size(20.0).semiBold.make(),
                    ),
                    ListTile(
                      onTap: () {
                        VxNavigator.of(context).push(
                          Uri(path: '/register'),
                        );
                      },
                      title: Text("Register").text.size(20.0).semiBold.make(),
                    ),
                  ],
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ],
    ),
  );
}
