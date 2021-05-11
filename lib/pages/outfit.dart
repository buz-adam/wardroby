import 'package:flutter/material.dart';

class Outfit extends StatefulWidget {
  @override
  _OutfitState createState() => _OutfitState();
}
class _OutfitState extends State<Outfit> with TickerProviderStateMixin {
  List<Tab> tabs = [
    Tab(
      child: Text(
        "All",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ),
    Tab(
      child: Text(
        "Business",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ),
    Tab(
      child: Text(
        "Sport & Activities",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ),
    Tab(
      child: Text(
        "Events",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ),
  ];
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.teal[200],
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
           child:Container(
             color: Colors.amberAccent[100],
             child: Padding(
               
               padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
               child: TabBar( isScrollable: true,tabs: tabs,
                   indicatorColor: Colors.blue,
                   ),
             ),
           ), 
          ),
          body: Container()),
    );
  }
}
