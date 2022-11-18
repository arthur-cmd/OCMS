// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ocms/landing/landing_page.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
           MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
            ),
            debugShowCheckedModeBanner: false,
            title: 'OCMS',
            home: Landingpage(),
          );
}