import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonipat_samaj/Dashboard.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool first = true;
  bool load = false;
  List<Users> trustees = [];
  APIService apiService = APIService();

  @override
  void initState() {
    apiService.init();
    trustees.add(Users(name: "Name", mobile1: "Mobile"));
    getTrustees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        print("hrrrkk");
        if(first) {
          first = false;

          setState(() {

          });
        }
        else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const Dashboard()),
                  (Route<dynamic> route) => false);
        }

        return false;
      },
      child: getBody()
    );
  }

  getBody() {
    return SafeArea(
      child: Scaffold(
        body: first ?
        Image.asset(
          "assets/temple.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        )
            : load ?
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sonipat Samaj\nSeva Samiti",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: MyColors.red,
                    decoration: TextDecoration.underline
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Trustee List",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: MyColors.blue,
                    decoration: TextDecoration.underline
                ),
              ),
              Divider(
                thickness: 1,
                color: MyColors.grey30,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    itemCount: trustees.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext buildContext, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext buildContext, index) {
                      return getUserDesign(trustees[index], index);
                    },
                  ),
                ),
              ),
            ],
          ),
        )
            : Center(
          child: CircularProgressIndicator(
            color: MyColors.colorPrimary,
          ),
        ),
      ),
    );
  }

  getUserDesign(Users user, int ind) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (user.name??"")+(user.surname??""),
              style: TextStyle(
                fontSize: ind==0 ? 16 : 10,
                fontWeight: ind==0 ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            Text(
              user.mobile1??"",
              style: TextStyle(
                fontSize: ind==0 ? 16 : 10,
                fontWeight: ind==0 ? FontWeight.w600 : FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }

  Future<void> getTrustees() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getTrustee;

    UserListResponse userListResponse = await apiService.getUsers(queryParameters);

    if(userListResponse.status=="Success" && userListResponse.message=="Users Retrieved") {
      trustees.addAll(userListResponse.users ?? []);
    }

    load = true;

    setState(() {

    });

  }
}
