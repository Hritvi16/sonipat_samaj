import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/EventListResponse.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class EventDetails extends StatefulWidget {
  final Events event;
  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  var unescape = HtmlUnescape();
  late Events event;
  @override
  void initState() {
    event = widget.event;
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
                    Environment.eventUrl + (event.eventImage??""),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                      return Icon(
                            Icons.event
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
          (event.eventName??"").trim(),
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
            getTextDesign("Start Date: ", (event.eventDate??"").trim()),
            SizedBox(
              height: 10,
            ),
            getTextDesign("End Date: ", (event.endDate??"").trim()),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description: ",
              style: TextStyle(
                color: MyColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),
            ),
            Html(
              data: unescape.convert(utf8.decode(base64Decode(event.eventDescription??""))),
            ),
          ],
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
