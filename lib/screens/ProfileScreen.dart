import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/BottomNavigationBarWidget.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _postMyData() async {
    var url = 'https://api2.funedulearn.com/init/demo-profile';
    var response = await http.post(url, body: {
      "name": "Rajkumar Raman",
      "image": "https://api2.funedulearn.com/uploads/default.png"
    });
    if (response.statusCode == 200) {
      print("Post Successful");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF846A9E),
        title: Text(
          "ALL EMAILS",
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: selectedIndex,
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListSkeleton(
                style: SkeletonStyle(
                  theme: SkeletonTheme.Light,
                  isShowAvatar: false,
                  barCount: 2,
                  colors: [Colors.grey.withAlpha(5), Colors.grey, Colors.white],
                  isAnimation: true,
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _postMyData,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 95, right: 95, top: 27),
                        child: CircleAvatar(
                          backgroundColor: accentColor,
                          radius: 60.0,
                          child: FaIcon(
                            FontAwesomeIcons.userCircle,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                      ),
                      Text(
                        "Pallav Chaudhari",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text("pallavc34@gmail.com"),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.cog),
                        title: Text("Settings"),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.infoCircle),
                        title: Text("About us"),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.star),
                        title: Text("Rate us"),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.signOutAlt),
                        title: Text("Logout"),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          future: _postMyData(),
        ),
      ),
    );
  }
}
