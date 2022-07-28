import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/NotificationListResponse.dart' as n;

import 'NotificationDetails.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<n.Notifications> notifications = [];
  bool load = false;

  static const _pageSize = 20;

  late PagingController<int, n.Notifications> _pagingController =
  PagingController(firstPageKey: 0);

  APIService apiService = APIService();

  @override
  void initState() {
    apiService.init();
    _pagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });
    getNotifications(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PagedListView<int, n.Notifications>.separated(
            pagingController: _pagingController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            builderDelegate: PagedChildBuilderDelegate<n.Notifications>(
              itemBuilder: (context, item, index)
              {
                return getNotificationDesign(item);
              },
            ),
            separatorBuilder: (BuildContext buildContext, index) {
              return SizedBox(height: 10);
            },
          ),
          // child: ListView.separated(
          //   itemCount: notifications.length,
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   separatorBuilder: (BuildContext buildContext, index) {
          //     return SizedBox(height: 10);
          //   },
          //   itemBuilder: (BuildContext buildContext, index) {
          //     return getNotificationDesign(notifications[index]);
          //   },
          // ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getNotificationDesign(n.Notifications notification) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  NotificationDetails(notification: notification)
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              Environment.notiUrl + (notification.image??""),
              height: 70,
              width: 70,
              errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                return Icon(
                  Icons.notifications_none,
                  size: 70,
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (notification.title??"").trim(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "Notification Date: ",
                        style: TextStyle(
                            color: MyColors.black,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          TextSpan(
                            text: (notification.notiDate??"").trim(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ]
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "Posted Date: ",
                        style: TextStyle(
                            color: MyColors.black,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          TextSpan(
                            text: (notification.createdDate??"").trim().substring(0, (notification.createdDate??"").trim().indexOf(" ")),
                            style: TextStyle(
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getNotifications(int pageKey) async {
    try {
      Map<String, dynamic> queryParameters = new Map();
      queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;
      print(queryParameters);
      n.NotificationListResponse notificationListResponse = await apiService.getNotifications(queryParameters);


      if (notificationListResponse.status=="Success" && notificationListResponse.message=="Notifications Retrieved") {
        final isLastPage = notificationListResponse.notifications!.length < _pageSize;
        print(isLastPage);
        if (isLastPage) {
          _pagingController.appendLastPage(notificationListResponse.notifications ?? []);
        }
        else {
          final nextPageKey = pageKey + notificationListResponse.notifications!.length;
          _pagingController.appendPage(notificationListResponse.notifications ?? [], nextPageKey);
        }

        if(_pagingController.itemList!.length <=_pageSize) {
          load = true;

          setState(() {

          });
        }
        // notifications = notificationListResponse.notifications ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
