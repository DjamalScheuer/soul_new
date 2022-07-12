import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(context, '12', 'Likes', Icons.thumb_up, Color(0xff81c784)),
      buildDivider(),
      buildButton(context, '340', 'Swipes', Icons.image, Color(0xffe57373)),
      buildDivider(),
      buildButton(context, '20', 'Friends', Icons.group, Color(0xff64b5f6)),
      buildDivider(),
      buildButton(context, '30', 'Followers', Icons.star, Color(0xffffb74d)),
    ],
  );
  Widget buildDivider() => Container(
    height: 35,
    width: 0,
    child: VerticalDivider(thickness: 2, color: Color(0xffa4a4a4)),
  );

  Widget buildButton(BuildContext context, String value, String text, IconData icon, Color iconColor) =>
      MaterialButton(
        // color: Color(0xfff6f3ff),
        padding: EdgeInsets.symmetric(vertical: 0),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: iconColor),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //SizedBox(height: 2),
          ],
        ),
      );
}