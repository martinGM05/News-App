import 'package:flutter/material.dart';
import 'package:news/src/pages/tabs_page.dart';
import 'package:news/src/theme/tema.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: miTema,
      home: TabsPage()
    );
  }
}