import 'package:flutter/material.dart';
import 'package:flutter_client/services/user.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:velocity_x/velocity_x.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  double width;
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Services Booked".text.center.size(22.0).make(),
      ),
      body: FutureBuilder(
        future: user.bookingsHistory(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ResponsiveBuilder(
              builder: (context, sizingInformation) {
                if (sizingInformation.isDesktop) {
                  width = 0.4;
                } else if (sizingInformation.isTablet) {
                  width = 0.8;
                } else {
                  width = 1.0;
                }
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * width,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Map data = snapshot.data[index];

                        DateTime date = DateTime.parse(data['date']).toLocal();
                        print(date);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(date);

                        return Container(
                          padding: EdgeInsets.all(
                            12.0,
                          ),
                          margin: EdgeInsets.all(
                            12.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date : $formattedDate")
                                  .text
                                  .size(22.0)
                                  .semiBold
                                  .make(),
                              Text("Service : ${data['service']}")
                                  .text
                                  .size(22.0)
                                  .make(),
                              Text("Status : ${data['status']}")
                                  .text
                                  .size(22.0)
                                  .make(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
