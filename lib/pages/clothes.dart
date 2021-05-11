

import 'package:wardroby/pages/section-title.dart';
import 'package:wardroby/db_files/Clothes_db.dart';
import 'package:wardroby/db_files/db_helper.dart';

import 'clothes_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Clothes_DB> clothes_db = [];
List<String> clothes_types = [];
class Clothes extends StatefulWidget {
  @override
  _ClothesState createState() => _ClothesState();
}
class _ClothesState extends State<Clothes> {

  bool again = true;
  int ind = 0;

  Future<List<String>> _query() async {
    List<Map<String, dynamic>> list = await DB.query(Clothes_DB.table);
    clothes_db.clear();
    clothes_types.clear();
    list.forEach((element) {
      clothes_db.add(Clothes_DB.fromMap(element));
      if (isEqual(Clothes_DB.fromMap(element).type)) {
        clothes_types.add(Clothes_DB.fromMap(element).type);
      }
    });
    clothes_types.sort();
    if (clothes_types == null) {
      clothes_types = ["null"];
      return clothes_types;
    }
    return clothes_types;
  }

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  TextEditingController editingController;
  List<String> searchResultData = [];
  List<String> initialData = [];
  bool list_Add = true;

  @override
  Widget build(BuildContext context) {
    editingController = TextEditingController();

    return FutureBuilder(
      future: _query(),
      // ignore: missing_return
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return CircularProgressIndicator();
        } else if (snapshots.hasError) {
          print("error!");
        } else {
          if (list_Add) {
            searchResultData = clothes_types;
            list_Add = false;
          }

          return Scaffold(
            backgroundColor: Colors.cyan[100],
            appBar: AppBar(
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                    icon: cusIcon,
                    onPressed: () {
                      setState(() {
                        if (this.cusIcon.icon == Icons.search) {
                          this.cusIcon = Icon(Icons.cancel);
                          this.cusSearchBar = TextField(
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              onSearchBarTextChanged(value);
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          );
                        } else {
                          this.cusIcon = Icon(Icons.search);
                          this.cusSearchBar = Text("");}});}
                    )],
              title: cusSearchBar,
            ),
            body: ListView.builder(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 55),
                itemCount: searchResultData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  ind = index;
                  return SingleChildScrollView(
                    child: Column(children: [
                      SectionTitle(
                        text: searchResultData[index],
                        press: () {},
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView.builder(
                            itemCount: _imgshow(ind),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              List<int> ids = []; List<String> lists = [];
                              String note;
                              clothes_db.forEach((element) {
                                if (element.type == searchResultData[ind]) {
                                  lists.add(element.address);
                                  ids.add(element.id);
                                  note = element.note;}});
                              String ad = lists[index];
                              return ClothesCard(
                                image: ad,
                                id: ids[index],
                                note: note,);
                            }),
                      ),
                    ]),
                  );
                }),
          );}},
    );}
  void onSearchBarTextChanged(String textToBeSearched) {
    searchResultData = clothes_types.where(
          (data) => data.toLowerCase().contains(
            textToBeSearched.toLowerCase(),),).toList();
    setState(() {});}
  static bool isEqual(String x) {
    bool gets = true;
    clothes_types.forEach((element) {if (element == x) {gets = false;}});
    return gets;}
  _imgshow(int ix) {
    int ifa = 0;
    clothes_db.forEach((element) {if (element.type == clothes_types[ix]) {ifa++;}});
    return ifa;}}
