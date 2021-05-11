
import 'dart:io';

import 'package:flutter/material.dart';

import 'clothes_info.dart';

class ClothesCard extends StatelessWidget {
  const ClothesCard(
      {Key key, @required this.image, @required this.id, @required this.note})
      : super(key: key);
  final String image, note;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          highlightColor: Colors.blue,
          onLongPress: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Clothes_info(id, image, note),
            ),
          ).then((value) => null),
          child: Stack(children: [
            Container(
              color: Colors.white,
              child: Image.file(File(image)),
            ),
          ]),
        ),
      ),
    );
  }
}
