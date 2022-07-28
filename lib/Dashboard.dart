import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sonipat_samaj/Filter.dart';
import 'package:sonipat_samaj/Trustee.dart';
import 'package:sonipat_samaj/Events.dart';
import 'package:sonipat_samaj/Notifications.dart';
import 'package:sonipat_samaj/UserDetails.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/BannerListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';

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
  static const _pageSize = 20;

  late PagingController<int, Users> _pagingController =
  PagingController(firstPageKey: 0);

  bool load = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int rcurrent = 0;
  int nrcurrent = 0;
  final CarouselController rcontroller = CarouselController();
  final CarouselController nrcontroller = CarouselController();

  List<Widget> slider = [];
  List<Widget> slidenr = [];

  TextEditingController name = new TextEditingController();

  late bool mmarried, mumarried, cmarried, cumarried;
  late bool mrj, mnrj, crj, cnrj;
  late bool m1, m2, m3, m4, m5, m6, c1, c2, c3, c4, c5, c6;

  List<String> mp = [];
  List<String> cp = [];

  String filter = "";

  APIService apiService = APIService();
  @override
  void initState() {
    apiService.init();
    _pagingController.addPageRequestListener((pageKey) {
      getUsers(pageKey);
    });
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        appBar: AppBar(
          title: TextFormField(
            onChanged: (value) {
              print("change");
            //   _pagingController.dispose();
            //   _pagingController =  PagingController(firstPageKey: 0);
            //   if(name.text.isNotEmpty) {
            //     _pagingController.addPageRequestListener((pageKey) {
            //       getSearchUsers(pageKey);
            //     });
            //     getSearchUsers(0);
            //   }
            //   else {
            //     _pagingController.addPageRequestListener((pageKey) {
            //       getUsers(pageKey);
            //     });
            //     getUsers(0);
            //   }
            },
            onFieldSubmitted: (value) {
              print("submit");
              _pagingController.dispose();
              _pagingController =  PagingController(firstPageKey: 0);
              _pagingController.addPageRequestListener((pageKey) {
                    getSearchUsers(pageKey);
                  });
              getSearchUsers(0);
            },
            onEditingComplete: () {
              print("complete");

            },
            onSaved: (value) {
              print("saved");

            },
            controller: name,
            style: TextStyle(color: MyColors.black),
            decoration: InputDecoration(
              hintText: "Search Member",
            ),
            cursorColor: MyColors.black,
            keyboardType: TextInputType.name,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_alt_outlined
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Filter(
                  mmarried: mmarried, cmarried: cmarried, mumarried: mumarried, cumarried: cumarried,
                  mrj: mrj, mnrj: mnrj, crj: crj, cnrj: cnrj,
                  m1: m1, m2: m2, m3: m3, m4: m4, m5: m5, m6: m6,
                  c1: c1, c2: c2, c3: c3, c4: c4, c5: c5, c6: c6,
                  mp: mp, cp: cp
                ))).then((value) {
                      if(value!=null) {
                        load = false;
                        mmarried = value["mmarried"];
                        cmarried = value["cmarried"];
                        mumarried = value["mumarried"];
                        cumarried = value["cumarried"];
                        mrj = value["mrj"];
                        mnrj = value["mnrj"];
                        crj = value["crj"];
                        cnrj = value["cnrj"];
                        m1 = value["m1"];
                        m2 = value["m2"];
                        m3 = value["m3"];
                        m4 = value["m4"];
                        m5 = value["m5"];
                        m6 = value["m6"];
                        c1 = value["c1"];
                        c2 = value["c2"];
                        c3 = value["c3"];
                        c4 = value["c4"];
                        c5 = value["c5"];
                        c6 = value["c6"];
                        mp = value["mp"];
                        cp = value["cp"];
                        filter = value['query'];
                        setState(() {

                        });
                        _pagingController.dispose();
                        _pagingController =  PagingController(firstPageKey: 0);
                        _pagingController.addPageRequestListener((pageKey) {
                          getFilterUsers(pageKey);
                        });
                        getFilterUsers(0);
                      }
                });
              },
            )
          ],
        ),
        bottomNavigationBar: CarouselSlider(
          items: slider,
          carouselController: rcontroller,
          options: CarouselOptions(
              enlargeCenterPage: true,
              height: 70,
              viewportFraction: 1,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  rcurrent = index;
                });
              }),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: MyColors.colorPrimary,
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      child: ClipOval(
                          child: Image.asset(
                            "assets/app_icon.jpg",
                          )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sonipat Samaaj Seva Samiti Surat",
                      style: TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
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
                  // closeDrawer();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Trustee()));
                },
                child: ListTile(
                  textColor: _currentIndex==1 ? MyColors.colorPrimary : Colors.black,
                  iconColor: _currentIndex==1 ? MyColors.colorPrimary : Colors.grey,
                  leading: Icon(Icons.people),
                  title: Text('Trustee'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _currentIndex = 1;
                  // });
                  // closeDrawer();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Events()));
                },
                child: ListTile(
                  textColor: _currentIndex==2 ? MyColors.colorPrimary : Colors.black,
                  iconColor: _currentIndex==2 ? MyColors.colorPrimary : Colors.grey,
                  leading: Icon(Icons.event),
                  title: Text('Events'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _currentIndex = 1;
                  // });
                  // closeDrawer();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Notifications()));
                },
                child: ListTile(
                  textColor: _currentIndex==3 ? MyColors.colorPrimary : Colors.black,
                  iconColor: _currentIndex==3 ? MyColors.colorPrimary : Colors.grey,
                  leading: Icon(Icons.notifications_none),
                  title: Text('Notifications'),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: slidenr,
                carouselController: nrcontroller,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 200,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        nrcurrent = index;
                      });
                    }),
              ),
              PagedListView<int, Users>.separated(
                pagingController: _pagingController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate<Users>(
                  itemBuilder: (context, item, index)
                  {
                    return getUserDesign(item);
                  },
                ),
                separatorBuilder: (BuildContext buildContext, index) {
                  return SizedBox(height: 10);
                },
              )
              // ListView.separated(
              //   itemCount: users.length,
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   separatorBuilder: (BuildContext buildContext, index) {
              //     return SizedBox(height: 10);
              //   },
              //   itemBuilder: (BuildContext buildContext, index) {
              //     return getUserDesign(users[index]);
              //   },
              // ),
            ],
          ),
        )
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void start() {
    mmarried = mumarried = cmarried = cumarried = false;
    mrj = mnrj = crj = cnrj = false;
    m1 = m2 = m3 = m4 = m5 = m6 = c1 = c2 = c3 = c4 = c5 = c6 = false;

    getRBanners();
  }

  Widget getUserDesign(Users user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  UserDetails(id: user.id??"")
            )
        );
      },
      child: Container(
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
                child: ClipOval(
                  child: Image.network(
                    Environment.imageUrl + (user.image??""),
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
                    (user.name??"").trim()+" "+(user.surname??"").trim(),
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

    BannerListResponse bannerListResponse = await apiService.getBanners(queryParameters);
    if(bannerListResponse.status=="Success" && bannerListResponse.message=="Banners Retrieved") {
      rbanners = bannerListResponse.banners ?? [];
    }

    getNRBanners();
  }

  Future<void> getNRBanners() async {
    Map<String, dynamic> queryParameters = new Map();
    queryParameters[APIConstant.act] = APIConstant.getNR;

    BannerListResponse bannerListResponse = await apiService.getBanners(queryParameters);
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
    }

    getUsers(0);
  }

  Future<void> getUsers(int pageKey) async {
    try {
      Map<String, dynamic> queryParameters = new Map();
      queryParameters[APIConstant.act] = APIConstant.getAll;
      queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;
      // print(queryParameters);

      UserListResponse userListResponse = await apiService.getUsers(
          queryParameters);

      if (userListResponse.status == "Success" && userListResponse.message == "Users Retrieved") {
        final isLastPage = userListResponse.users!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(userListResponse.users ?? []);
        } else {
          final nextPageKey = pageKey + userListResponse.users!.length;
          _pagingController.appendPage(userListResponse.users ?? [], nextPageKey);
        }
        if(_pagingController.itemList!.length <=_pageSize) {
          load = true;

          setState(() {

          });
        }
        // users = userListResponse.users ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }



    // setState(() {
    //
    // });
  }

  Future<void> getSearchUsers(int pageKey) async {
    try {
      Map<String, dynamic> queryParameters = new Map();
      queryParameters[APIConstant.act] = APIConstant.getByName;
      queryParameters["search"] = name.text;
      queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;

      UserListResponse userListResponse = await apiService.getUsers(
          queryParameters);

      if (userListResponse.status == "Success" && userListResponse.message == "Users Retrieved") {
        final isLastPage = userListResponse.users!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(userListResponse.users ?? []);
        } else {
          final nextPageKey = pageKey + userListResponse.users!.length;
          _pagingController.appendPage(userListResponse.users ?? [], nextPageKey);
        }
        if(_pagingController.itemList!.length <=_pageSize) {
          load = true;


          setState(() {

          });
        }
        // users = userListResponse.users ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }


    // load = true;

    setState(() {

    });
  }

  Future<void> getFilterUsers(int pageKey) async {
    try {
      Map<String, dynamic> queryParameters = new Map();
      queryParameters[APIConstant.act] = APIConstant.getByFilter;
      queryParameters["filter"] = filter;
      queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;

      UserListResponse userListResponse = await apiService.getUsers(
          queryParameters);

      if (userListResponse.status == "Success" && userListResponse.message == "Users Retrieved") {
        final isLastPage = userListResponse.users!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(userListResponse.users ?? []);
        } else {
          final nextPageKey = pageKey + userListResponse.users!.length;
          _pagingController.appendPage(userListResponse.users ?? [], nextPageKey);
        }
        if(_pagingController.itemList!.length <=_pageSize) {
          load = true;


          setState(() {

          });
        }
        // users = userListResponse.users ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }


    setState(() {

    });

  }
}
