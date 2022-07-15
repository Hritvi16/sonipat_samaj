import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/BannerListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';
import 'package:transparent_image/transparent_image.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  List<Banners> rbanners = [];
  List<Banners> nrbanners = [];
  List<Users> users = [];
  bool load = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int rcurrent = 0;
  int nrcurrent = 0;
  final CarouselController rcontroller = CarouselController();
  final CarouselController nrcontroller = CarouselController();

  List<Widget> slider = [];
  List<Widget> slidenr = [];

  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_alt_outlined
              ),
              onPressed: () {
              },
            )
          ],
        ),
        // bottomNavigationBar: CarouselSlider(
        //   items: slider,
        //   carouselController: rcontroller,
        //   options: CarouselOptions(
        //       enlargeCenterPage: true,
        //       height: 70,
        //       viewportFraction: 1,
        //       initialPage: 0,
        //       autoPlay: true,
        //       autoPlayInterval: Duration(seconds: 3),
        //       onPageChanged: (index, reason) {
        //         setState(() {
        //           rcurrent = index;
        //         });
        //       }),
        // ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 30),
                height: 160,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/app_icon.jpg"
                        ),
                      )
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  closeDrawer();
                },
                child: ListTile(
                  textColor: _currentIndex==0 ? MyColors.colorPrimary : Colors.black,
                  iconColor: _currentIndex==0 ? MyColors.colorPrimary : Colors.grey,
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _currentIndex = 1;
                  // });
                  closeDrawer();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => TrusteeScreen()));
                },
                child: ListTile(
                  textColor: _currentIndex==1 ? MyColors.colorPrimary : Colors.black,
                  iconColor: _currentIndex==1 ? MyColors.colorPrimary : Colors.grey,
                  leading: Icon(Icons.people),
                  title: Text('Trustee'),
                ),
              ),
            ],
          ),
        ),
        body: load ? SingleChildScrollView(
          child: Column(
            children: [
              // CarouselSlider(
              //   items: slidenr,
              //   carouselController: nrcontroller,
              //   options: CarouselOptions(
              //       enlargeCenterPage: true,
              //       height: 200,
              //       viewportFraction: 1,
              //       initialPage: 0,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       onPageChanged: (index, reason) {
              //         setState(() {
              //           nrcurrent = index;
              //         });
              //       }),
              // ),
              ListView.separated(
                itemCount: users.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext buildContext, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (BuildContext buildContext, index) {
                  return getUserDesign(users[index]);
                },
              ),
            ],
          ),
        ) :
        Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void start() {
    getUsers();
    // getRBanners();
  }

  Widget getUserDesign(Users user) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 10),
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
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40,
              // child: ClipOval(
              //   child: Image.network(
              //     Environment.imageUrl + (user.image??"")
              //   )
              // ),
            child: ClipOval(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: Environment.imageUrl + (user.image??""),
                  imageErrorBuilder: (context, error, stacktrace) { // Handle Error for the 1st time
                    return FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: Environment.imageUrl + (user.image??""),
                      imageErrorBuilder: (context, error,
                          stacktrace) { // Handle Error for the 2nd time
                        return FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: Environment.imageUrl + (user.image??""),
                          imageErrorBuilder: (context, error,
                              stacktrace) { // Handle Error for the 3rd time to return text
                            return Center(child: Text('Image Not Available'));
                          },
                        );
                      },
                    );
                  }
               ),
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
                  (user.name??"").trim(),
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
                    text: user.mobile1??"",
                    style: TextStyle(
                      color: MyColors.black,
                      fontWeight: FontWeight.w500
                    ),
                    children: [
                      if((user.mobile2??"").isNotEmpty)
                        TextSpan(
                          text: " ,"+(user.mobile2??"")
                        ),
                      if((user.mobile3??"").isNotEmpty)
                        TextSpan(
                          text: " ,"+(user.mobile3??"")
                        )
                    ]
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  (user.resadd1??"").trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void closeDrawer() {
    if(_scaffoldKey.currentState!.isDrawerOpen)
      Navigator.of(context).pop();
  }

  Future<void> getRBanners() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getR;

    BannerListResponse bannerListResponse = await APIService().getBanners(queryParameters);
    if(bannerListResponse.status=="Success" && bannerListResponse.message=="Banners Retrieved") {
      rbanners = bannerListResponse.banners ?? [];
    }

    getNRBanners();
  }

  Future<void> getNRBanners() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getNR;

    BannerListResponse bannerListResponse = await APIService().getBanners(queryParameters);
    if(bannerListResponse.status=="Success" && bannerListResponse.message=="Banners Retrieved") {
      nrbanners = bannerListResponse.banners ?? [];
    }

    setState(() {

    });
    setRBanner();
  }

  setRBanner() {
    int len = rbanners.length;
    for (int i = 0; i < len; i++) {
      slider.add(
          Container(
            height: 200,
            child: Image.network(
                Environment.bannerUrl + (rbanners[i].location ?? ""),
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width),
          )
      );
      i++;
    }

    setNRBanner();
  }

  setNRBanner() {
    int len = nrbanners.length;
    for (int i = 0; i < len; i++) {
      slidenr.add(
          Container(
            height: 200,
            child: Image.network(
                Environment.bannerUrl + (nrbanners[i].location ?? ""),
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width),
          )
      );
      i++;
    }

    getUsers();
  }

  Future<void> getUsers() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getAll;
    queryParameters[APIConstant.offset] = users.length;
    print(users.length);
    print(queryParameters);

    UserListResponse userListResponse = await APIService().getUsers(queryParameters);
    print(userListResponse.toJson());
    if(userListResponse.status=="Success" && userListResponse.message=="Users Retrieved") {
      users.addAll(userListResponse.users ?? []);
    }

    if(!load) {
      load = true;
    }

    setState(() {

    });

    if(userListResponse.users!.isNotEmpty)
      getUsers();
  }
}
