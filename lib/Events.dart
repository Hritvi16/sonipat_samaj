import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sonipat_samaj/UserDetails.dart';
import 'package:sonipat_samaj/api/APIConstant.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/EventDetails.dart';
import 'package:sonipat_samaj/models/EventListResponse.dart' as e;

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  List<e.Events> events = [];
  bool load = false;
  
  static const _pageSize = 20;

  late PagingController<int, e.Events> _pagingController =
  PagingController(firstPageKey: 0);

  APIService apiService = APIService();

  @override
  void initState() {
    apiService.init();
    _pagingController.addPageRequestListener((pageKey) {
      getEvents(pageKey);
    });
    getEvents(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: load ? Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PagedListView<int, e.Events>.separated(
            pagingController: _pagingController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            builderDelegate: PagedChildBuilderDelegate<e.Events>(
              itemBuilder: (context, item, index)
              {
                return getEventDesign(item);
              },
            ),
            separatorBuilder: (BuildContext buildContext, index) {
              return SizedBox(height: 10);
            },
          ),
          // child: ListView.separated(
          //   itemCount: events.length,
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   separatorBuilder: (BuildContext buildContext, index) {
          //     return SizedBox(height: 10);
          //   },
          //   itemBuilder: (BuildContext buildContext, index) {
          //     return getEventDesign(events[index]);
          //   },
          // ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getEventDesign(e.Events event) {
    print(Environment.eventUrl + (event.eventImage??""));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  EventDetails(event: event)
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
            Image.network(
                Environment.eventUrl + (event.eventImage??""),
                height: 70,
                width: 70,
                errorBuilder: (BuildContext buildContext, objrct, stacktrace) {
                  return Icon(
                    Icons.event,
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
                    (event.eventName??"").trim(),
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
                      text: "Start Date: ",
                      style: TextStyle(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                          text: (event.eventDate??"").trim(),
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
                      text: "End Date: ",
                      style: TextStyle(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500
                      ),
                      children: [
                        TextSpan(
                          text: (event.endDate??"").trim(),
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

  Future<void> getEvents(int pageKey) async {
    try {
        Map<String, dynamic> queryParameters = new Map();
        queryParameters[APIConstant.offset] = (_pagingController.itemList?.length ?? 1) - 1;
        print(queryParameters);
      e.EventListResponse eventListResponse = await apiService.getEvents(queryParameters);
      
      if (eventListResponse.status=="Success" && eventListResponse.message=="Events Retrieved") {
        final isLastPage = eventListResponse.events!.length < _pageSize;
        print(isLastPage);
        if (isLastPage) {
          _pagingController.appendLastPage(eventListResponse.events ?? []);
        } 
        else {
          final nextPageKey = pageKey + eventListResponse.events!.length;
          _pagingController.appendPage(eventListResponse.events ?? [], nextPageKey);
        }
        
        if(_pagingController.itemList!.length <=_pageSize) {
          load = true;

          setState(() {

          });
        }
        // events = eventListResponse.events ?? [];
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
