import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/NotificationListResponse.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class NotificationDetails extends StatefulWidget {
  final Notifications notification;
  const NotificationDetails({Key? key, required this.notification}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {

  var unescape = HtmlUnescape();
  late Notifications notification;
  @override
  void initState() {
    notification = widget.notification;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Image.network(
                    Environment.notiUrl + (notification.image??""),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                      return Icon(
                            Icons.notifications_none
                      );
                    },
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                getDetailCard1(),
                SizedBox(
                  height: 20,
                ),
                getDetailCard2(),
                SizedBox(
                  height: 20,
                ),
                getDetailCard3()
              ],
            ),
          ),
        ),
      )
    );
  }

  getDetailCard1() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Text(
          (notification.title??"").trim(),
          style: TextStyle(
              color: MyColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),
          overflow: TextOverflow.ellipsis,
        )
    );
  }

  getDetailCard2() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextDesign("Notification Date: ", (notification.notiDate??"").trim()),
            SizedBox(
              height: 10,
            ),
            getTextDesign("Posted Date: ", (notification.createdDate ??"").trim()),
          ],
        )
    );
  }


  getDetailCard3() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Text(
          (notification.noti??"").trim(),
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: MyColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16
          ),
        ),
    );
  }


  getTextDesign(String title, String data) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: title,
          style: TextStyle(
            color: MyColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18
          ),
          children: [
            TextSpan(
              text: data,
              style: TextStyle(
                  fontWeight: FontWeight.w400
              ),
            )
          ]
      ),
    );
  }
}
