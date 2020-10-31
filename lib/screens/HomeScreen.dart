import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/BottomNavigationBarWidget.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app/screens/ProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_item/multi_select_item.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var mailArray = [];
  var subjectArray = [];
  var messageArray = [];
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> _initializeDataInBackground() async {
    await Duration(milliseconds: 500);
    var url = "https://api2.funedulearn.com/init/demo-mails";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var mydata = await json.decode(response.body);
      mailArray.clear();
      subjectArray.clear();
      messageArray.clear();
      for (int i = 0; i <= 4; i++) {
        mailArray.add(mydata["data"][i]["from"].toString());
        subjectArray.add(mydata["data"][i]["subject"].toString());
        messageArray.add(mydata["data"][i]["body"]["message"].toString());
      }
    }
    controller.set(mailArray.length);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: selectedIndex,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF846A9E),
        title: Text(
          "ALL EMAILS",
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return Container(
                child: Center(
                    child: Text(
                  "Internet connection error",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: // list skeleton
                    CardListSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: true,
                    isCircleAvatar: true,
                    barCount: 2,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _initializeDataInBackground,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: subjectArray.length,
                itemBuilder: (context, index) {
                  return MultiSelectItem(
                    onSelected: () {
                      setState(() {
                        controller.toggle(index);
                        print(index);
                      });
                    },
                    isSelecting: controller.isSelecting,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22.5,
                                  child: FaIcon(
                                    controller.isSelected(index)
                                        ? FontAwesomeIcons.check
                                        : FontAwesomeIcons.userCircle,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            subjectArray.elementAt(index),
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          Text(mailArray.elementAt(index))
                                        ],
                                      ),
                                      Text(
                                        messageArray.elementAt(index),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          future: _initializeDataInBackground(),
        ),
      ),
    );
  }
}
