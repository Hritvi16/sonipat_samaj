import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sonipat_samaj/UserDetails.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/BannerListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';
import 'package:transparent_image/transparent_image.dart';

class Trustee extends StatefulWidget {
  const Trustee({Key? key}) : super(key: key);

  @override
  State<Trustee> createState() => _TrusteeState();
}

class _TrusteeState extends State<Trustee> {

  List<Users> trustees = [];
  bool load = false;

  static const _pageSize = 20;

  late PagingController<int, Users> _pagingController =
  PagingController(firstPageKey: 0);

  APIService apiService = APIService();
  @override
  void initState() {
    apiService.init();
    _pagingController.addPageRequestListener((pageKey) {
      getTrustees(pageKey);
    });
    getTrustees(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        body: PagedListView<int, Users>.separated(
          pagingController: _pagingController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          builderDelegate: PagedChildBuilderDelegate<Users>(
            itemBuilder: (context, item, index)
            {
              return getUserDesign(item);
            },
          ),
          separatorBuilder: (BuildContext buildContext, index) {
            return SizedBox(height: 10);
          },
        ),
        // body: ListView.separated(
        //   itemCount: trustees.length,
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   separatorBuilder: (BuildContext buildContext, index) {
        //     return SizedBox(height: 10);
        //   },
        //   itemBuilder: (BuildContext buildContext, index) {
        //     return getUserDesign(trustees[index]);
        //   },
        // ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getUserDesign(Users trustee) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  UserDetails(id: trustee.id??"")
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
                    Environment.imageUrl + (trustee.image??""),
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
                    (trustee.name??"").trim()+" "+(trustee.surname??"").trim(),
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
                        text: trustee.mobile1??"",
                        style: TextStyle(
                            color: MyColors.black,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          if((trustee.mobile2??"").isNotEmpty)
                            TextSpan(
                                text: " ,"+(trustee.mobile2??"")
                            ),
                          if((trustee.mobile3??"").isNotEmpty)
                            TextSpan(
                                text: " ,"+(trustee.mobile3??"")
                            )
                        ]
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    (trustee.resadd1??"").trim(),
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

  Future<void> getTrustees(int pageKey) async {
    try {
      Map<String, dynamic> queryParameters = new Map();
      queryParameters[APIConstant.act] = APIConstant.getTrustee;
      queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;
      print(queryParameters);

      UserListResponse userListResponse = await apiService.getUsers1(queryParameters);
      print("userListResponse.toJson()");
      print(userListResponse.toJson());
      print(userListResponse.status == "Success");
      print(userListResponse.message == "Users Retrieved");
      if (userListResponse.status == "Success" && userListResponse.message == "Users Retrieved") {
        print("helliiii");
      }
      else {
        print("helloooooo");
      }

      if (userListResponse.status == "Success" && userListResponse.message == "Users Retrieved") {
        print("result.data");
        final isLastPage = userListResponse.users!.length < _pageSize;
        print(isLastPage);
        if (isLastPage) {
          print("hellpppp");
          _pagingController.appendLastPage(userListResponse.users ?? []);
        } else {
          print("helluuu");
          final nextPageKey = pageKey + userListResponse.users!.length;
          _pagingController.appendPage(userListResponse.users ?? [], nextPageKey);
        }
        print(_pagingController.itemList?.length);
        print(_pageSize);
        if(_pagingController.itemList!.length <=_pageSize) {
          print("helloooo");
          load = true;

          setState(() {

          });
        }
        // users = userListResponse.users ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }

  }
}
