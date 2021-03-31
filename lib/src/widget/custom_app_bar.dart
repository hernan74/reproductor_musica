import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 30.0,
            ),
            Spacer(),
            FaIcon(
              FontAwesomeIcons.commentAlt,
              size: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            FaIcon(
              FontAwesomeIcons.headphonesAlt,
              size: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            FaIcon(
              FontAwesomeIcons.externalLinkSquareAlt,
              size: 35.0,
            ),
          ],
        ),
      ),
    );
  }
}
