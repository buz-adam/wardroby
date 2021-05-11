import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wardroby/bridge/filer.dart';
import 'package:wardroby/db_files/Clothes_db.dart';
import 'package:wardroby/db_files/db_helper.dart';
import 'package:path/path.dart' as p;

int id;
bool state = false;
class AddClothes extends StatefulWidget {
  AddClothes.update(int _id) {
    id = _id;
    state = true;
  }
  AddClothes() {}
  @override
  _AddClothesState createState() => _AddClothesState();
}
int counter1 = 0;
class _AddClothesState extends State<AddClothes> {
  File image_file;
  TextEditingController controller = TextEditingController();
  String note="";
  String valueText = null;
  List<String> types = [
    "BELT", "BLOUSE", "BONNET", "BOOT", "COAT", "DRESS", "EARINGS", "GLASSES",
    "HANDBAG", "JACKET", "JEANS", "PANTS", "SHIRT", "SHOES", "SHORTS",
    "SKIRT", "SUIT", "SWEATER", "T-SHIRT", "TIE", "TRACKSUIT", "WATCH"
  ];
  var _value_;
  _open_gallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image_file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _open_camera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image_file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String fileFromDocsDir(String filename, String directory) {
    Filer fil = Filer();
    String pathName = p.join(fil.dir.path + "/$directory", filename);

    Directory(fil.dir.path + "/" + "$directory").create(recursive: true);
    image_file.copy(pathName);
    return pathName;
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250,
                  width: 180,
                  child: Image(
                    image: image_file != null
                        ? FileImage(image_file)
                        : AssetImage('assets/blank.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey[400],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () => {_open_gallery()},
                          child: Icon(
                            Icons.image_search,
                            color: Colors.black,
                          ),
                          style: ButtonStyle(alignment: Alignment.center),
                        ),
                        width: 100,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () => {_open_camera()},
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                        width: 100,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: AlignmentDirectional.center,
                  child: DropdownButton(
                    hint: Text(
                      ' choose a type of your clothes',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ), // Not necessary for Option 1
                    value: _value_,
                    onChanged: (newValue) {
                      setState(() {
                        _value_ = newValue;
                        //_value=newValue;
                      });
                    },
                    items: types.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
                  //padding:EdgeInsets.fromLTRB(40,0,40,0) ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.green[200],
                  ),

                  child: TextField(
                      maxLines: 4,
                      onChanged: (value) {note = value;},
                      controller: controller,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        hintText:
                            'Write here something you want to remember about this clothes... ',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    icon: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _delete();
                      counter1 = 0;
                      Navigator.of(context).pop(false);
                    }),
                IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    icon: Icon(
                      Icons.check_circle,
                      size: 50,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      query();
                      String path = fileFromDocsDir("$counter1.png", "photos");
                      int a = counter1;
                      setState(() {
                        _save(path, _value_, note);
                      });
                      Navigator.of(context).pop(true);
                    }),
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query();
  }

  void _save(String _address, String _type, String _note) async {
    Clothes_DB item;
    item = Clothes_DB(
      address: _address,
      type: _type,
      note: _note,
    );
    await DB.insert(Clothes_DB.table, item);
  }

  void _delete() async {
    await DB.deletes(Clothes_DB.table);
  }

  void query() async {
    List<Map<String, dynamic>> sa = await DB.query(Clothes_DB.table);
    setState(() {
      sa.forEach((element) {
        counter1++;
      });
    });
  }
}
