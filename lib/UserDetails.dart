import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/ChildListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatefulWidget {
  final String? id;
  const UserDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  bool load = true;
  Users user = Users();
  List<Child> children = [];
  APIService apiService = APIService();
  @override
  void initState() {
    apiService.init();
    getUserDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      child: ClipOval(
                        child: Image.network(
                          Environment.imageUrl + (user.image??""),
                          errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                            return ClipOval(
                              child: Icon(
                                Icons.account_circle
                              ),
                            );
                          },
                        )
                      ),
                  ),
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
      : Center(
        child: CircularProgressIndicator(
          color: MyColors.colorPrimary,
        ),
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: "MEMBER ID: ",
                  style: TextStyle(
                      color: MyColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                  ),
                  children: [
                    TextSpan(
                        text: user.id??""
                    ),
                  ]
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (user.name??"").trim()+" "+(user.surname??"").trim(),
              style: TextStyle(
                  color: MyColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () {
                  openwhatsapp();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Message ",
                      style: TextStyle(
                          color: MyColors.green500,
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                    Icon(
                      Icons.whatsapp,
                      color: MyColors.green500,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () {
                  launchURL("tel:"+(user.mobile1??""));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Call ",
                      style: TextStyle(
                          color: MyColors.blue300,
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                    Icon(
                      Icons.call,
                      color: MyColors.blue300,
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }


  getDetailCard3() {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
            getTextDesign("Wife Name", (user.wife??"")+" - "+(user.wifemobile??"")),
            getTextDesign("Mobile", (user.mobile1??"")+((user.mobile2??"").isNotEmpty ? ", "+(user.mobile2??"") : "")+((user.mobile3??"").isNotEmpty ? ", "+(user.mobile3??"") : "")),
            getTextDesign("Date of Birth [YYYY-MM-DD]", user.dateOfBirth??""),
            getTextDesign("Residence Address", (user.resadd1??"")+(user.resadd2??"")+(user.resadd3??"")),
            getTextDesign("Office Address", (user.offadd1??"")+(user.offadd2??"")+(user.offadd3??"")),
            getChildrenDesign()
            // getTextDesign("Mobile", user.mobile1??""),
          ],
        )
    );
  }

  getTextDesign(String title, String data) {
    TextEditingController controller = TextEditingController(text: data);
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: false,
      style: TextStyle(color: MyColors.black),
      maxLines: (data.length/30).round()==0 ? 1 : (data.length/30).round(),
      decoration: InputDecoration(
        label: Text(title),
        labelStyle: TextStyle(
          color: MyColors.colorPrimary,
        )
      ),
      cursorColor: MyColors.black,
      keyboardType: TextInputType.name,
    );
  }

  getChildrenDesign() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Children Details",
          style: TextStyle(
            color: MyColors.colorPrimary
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          itemCount: children.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext buildContext, index) {
            return SizedBox(
              height: 5,
            );
          },
          itemBuilder: (BuildContext buildContext, index) {
            return getChildDesign(children[index]);
          },
        ),
      ],
    );
  }

  getChildDesign(Child child) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: ClipOval(
              child: Image.network(
                Environment.imageUrl + (child.image??""),
                errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                  return ClipOval(
                    child: Icon(
                      Icons.account_circle,
                      size: 70,
                    ),
                  );
                },
              )
            ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (child.name??"").trim(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: "Mobile: ",
                    style: TextStyle(
                        color: MyColors.black,
                        fontWeight: FontWeight.w500
                    ),
                    children: [
                      TextSpan(
                        text: child.mobile??""
                      ),
                    ]
                ),
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: "Gender: ",
                    style: TextStyle(
                        color: MyColors.black,
                        fontWeight: FontWeight.w500
                    ),
                    children: [
                      TextSpan(
                        text: child.gender??""
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openwhatsapp() async{
    var whatsapp ="+91"+(user.mobile1??"");
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    print(whatsappURl_android);
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if(await launch(whatappURL_ios, forceSafariVC: false)){

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));

      }

    }else{
      // android , web
      if( await launch(whatsappURl_android)) {
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));

      }


    }

  }

  void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getByID;
    queryParameters["id"] = widget.id;

    UserResponse userResponse = await apiService.getUserDetails(queryParameters);
    // print(userListResponse.toJson());
    if(userResponse.status=="Success" && userResponse.message=="User Retrieved") {
      user = userResponse.user ?? Users();
    }

    getChildDetails();
  }
  Future<void> getChildDetails() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getAll;
    queryParameters["id"] = widget.id;

    ChildListResponse childListResponse = await apiService.getChildren(queryParameters);
    print(childListResponse.toJson());
    if(childListResponse.status=="Success" && childListResponse.message=="Children Retrieved") {
      children = childListResponse.child ?? [];
    }

    load = true;

    setState(() {

    });
  }
}
