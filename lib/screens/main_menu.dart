import 'package:easyback/screens/api/ApiPage.dart';
import 'package:easyback/screens/baepopage/Deployment.dart';
import 'package:flutter/material.dart';

import '../services/APIAuths.dart';

class MainMenu extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(),
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0),
            child: IconButton(
              icon: Image.asset(
                'asset/image/great.png',
                width: 60,
                height: 60,
              ),
              onPressed: () {
                _handleImagePressed(context);
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: TextButton(
              onPressed: () {
                _handleAPIButton(context);
              },
              child: Text(
                'API',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 16,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  _handleDeploymentButton(context);
                },
                child: Text(
                  'Deployment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () async {
            APIAuths.getLogin();
            _handleloginpageButton(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);

  void _handleImagePressed(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _handleAPIButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleDeploymentButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()),
    );
  }

  void _handleloginpageButton(BuildContext context) {
  }
}
