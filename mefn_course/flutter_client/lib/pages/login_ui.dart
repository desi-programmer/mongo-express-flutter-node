import 'package:flutter/material.dart';
import 'package:flutter_client/services/login_service.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginUi extends StatefulWidget {
  final String msg;
  LoginUi(this.msg);
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  double width;
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
      ),
      // body
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isDesktop) {
            // desktop
            width = 0.3;
          } else if (sizingInformation.isTablet) {
            width = 0.5;
            // tab
          } else {
            // phone
            width = 0.9;
            // ignoring watches
          }

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * width,
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  children: [
                    // show if a msg exists
                    if (widget.msg != null)
                      Text(
                        'You must Login to continue !',
                      ).text.red400.size(20.0).make(),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      onChanged: (_val) {
                        email = _val;
                      },
                      // validator: MultiValidator([
                      //   RequiredValidator(
                      //     errorText: "Email Required !",
                      //   ),
                      //   EmailValidator(
                      //     errorText: "Enter Valid email !",
                      //   ),
                      // ]),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                      onChanged: (_val) {
                        password = _val;
                      },
                      // validator: MinLengthValidator(
                      //   6,
                      //   errorText: "At least use 6 characters",
                      // ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                          if (formkey.currentState.validate()) {
                            // form validated
                            login(context, email, password);
                          }
                        },
                        child: Text(
                          "Login",
                        ).text.size(20.0).semiBold.make(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
