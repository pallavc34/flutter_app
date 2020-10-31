import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/ProfileScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int selectedIndex;

  BottomNavigationBarWidget({@required this.selectedIndex});

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.inbox,
            ),
            label: "Inbox"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userCircle), label: "Profile"),
      ],
      selectedItemColor: Color(0xFF846A9E),
      currentIndex: widget.selectedIndex,
      onTap: (value) {
        setState(() {
          widget.selectedIndex = value;
          Navigator.pop(context);
          if (widget.selectedIndex == 0) {
            //homeScreen
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          } else {
            //Profile
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
          }
        });
      },
    );
  }
}
