import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/order_screen.dart';
import 'views/scanner_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order App',
      home: OrderScreen(),
      getPages: [
        GetPage(name: '/scanner', page: () => ScannerScreen()),
      ],
    );
  }
}