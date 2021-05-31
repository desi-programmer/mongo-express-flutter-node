import 'package:flutter/material.dart';
import 'package:flutter_client/services/user.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: user.userProfile(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data;
            return Center(
              child: Column(
                children: [
                  Text(
                    "${data['name']}",
                  ).text.size(24.0).semiBold.make(),
                  Text(
                    "${data['email']}",
                  ).text.size(24.0).semiBold.make(),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
