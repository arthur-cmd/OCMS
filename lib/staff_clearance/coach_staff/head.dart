// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ocms/students/clearance.dart';
import 'package:ocms/students/monitoring.dart';

import '../../student_clearance/head_of_unit/claims.dart';

class Head extends StatefulWidget {
  const Head(String text, {Key? key}) : super(key: key);

  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  int index = 1;
  final Screen = [Clearance(''), Claims(), Monitoring()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: Screen[index],
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: HexColor('#013221'),
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                  primaryColor: HexColor("#013221"),
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: TextStyle(
                          color: HexColor(
                              '#fdbe33')))), // sets the inactive color of the `BottomNavigationBar`
              child: BottomNavigationBar(
                selectedItemColor: HexColor('#fdbe33'),
                unselectedItemColor: HexColor('#ffffff'),
                backgroundColor: HexColor("#013221"),
                items: [
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      label: 'Start Clearance'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box_outlined),
                      label: 'Clearance Status'),
                  // BottomNavigationBarItem(
                  //     icon: FaIcon(FontAwesomeIcons.shoppingCart),
                  //     label: 'Cart'),
                  // BottomNavigationBarItem(
                  //     icon: Image.asset(
                  //       'assets/navigation.jpg',
                  //       width: 30,
                  //       height: 30,
                  //     ),
                  //     label: 'Events'),
                ],
                currentIndex: index,
                onTap: (index) {
                  if (mounted) setState(() => this.index = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
