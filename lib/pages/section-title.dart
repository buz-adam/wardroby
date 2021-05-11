import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key, 
   @required this.text, 
   @required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                            child: Text(
                    'see more',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onTap: press,
                ),
              ],
            ),
          ),
    );
  }
}