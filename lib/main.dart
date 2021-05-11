
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wardroby/assets/my_flutter_app_icons.dart';
import 'package:wardroby/bridge/filer.dart';
import 'package:wardroby/db_files/db_helper.dart';
import 'pages/clothes.dart';
import 'pages/add_clothes.dart';
import 'pages/calender.dart';
import 'pages/outfit.dart';

Directory _appDocsDir;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _appDocsDir = await getApplicationDocumentsDirectory();
  Filer ad = Filer();
  ad.dir = _appDocsDir;
  await DB.init();

  runApp(MaterialApp(
    home: HomePage(),
  ));
}
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current_index = 1;

  List<Widget> _widgetOptions = [];
  @override
  Widget build(BuildContext context) {
    _widgetOptions = [Clothes(), Outfit(), Calender()];
    
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            if (_current_index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddClothes(),
                ),
              ).then((value) => setState(() {}));
            }
          }),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            color: Colors.white,
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                child: BottomNavigationBar(
                  elevation: 0,
                  iconSize: 30,
                  selectedItemColor: Colors.black,
                  currentIndex: _current_index,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(MyFlutterApp.clothes_icon),
                      label: 'Clothes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(MyFlutterApp.outfit_icon),
                      label: 'Outfits',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_rounded),
                      label: 'Calendar',
                    ),
                  ],
                  onTap: (index) {setState(() {_current_index = index;});},
                ),
              ),
            )),
      ),
      body: _widgetOptions[_current_index],
    );
  }
}
