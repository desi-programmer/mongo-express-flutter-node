import 'package:flutter/material.dart';
import 'package:flutter_client/pages/widgets/drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double width = 1;
  int count;
  double aspect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rural Clap",
        ),
        centerTitle: true,
      ),
      //
      drawer: drawer(context),
      //
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isDesktop) {
            width = 0.8;
            aspect = 1 / 1;
            if (sizingInformation.screenSize.width < 1440.0) {
              count = 3;
            } else {
              count = 4;
            }
          } else if (sizingInformation.isTablet) {
            width = 0.9;
            count = 2;
            aspect = 1 / 1;
          } else {
            width = 1.0;
            count = 1;
            aspect = 4 / 3;
          }
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * width,
              child: GridView.count(
                crossAxisCount: count,
                childAspectRatio: aspect,
                children: [
                  serviceCard(
                    "Cleaning",
                    "assets/images/cleaning.png",
                  ),
                  serviceCard(
                    "Plumber",
                    "assets/images/plumber.png",
                  ),
                  serviceCard(
                    "Sanitization",
                    "assets/images/sanitization.png",
                  ),
                  serviceCard(
                    "A/C Repair",
                    "assets/images/a_c_repair.png",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget serviceCard(String title, String asset) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              height: 156.0,
            ),
            title.text.size(28.0).bold.make(),
          ],
        ),
      ),
    );
  }
}
