import 'package:flutter/material.dart';
import 'mainpage/ApiPage.dart';
import 'mainpage/Deployment.dart';
import 'loginpage.dart';
import 'package:http/http.dart';


void main() => runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false, // 디버그 라벨 제거
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          leading:Container(),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0), // 이미지를 아래쪽으로 이동시키기 위한 패딩
                child: IconButton(
                  icon: Image.asset(
                    'asset/image/great.png', // 이미지 파일 경로 설정
                    width: 60, // 이미지 너비 설정
                    height: 60, // 이미지 높이 설정
                  ),
                  onPressed: () {
                    _handleImagePressed(context); // 이미지 클릭 시 실행될 함수
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
          backgroundColor: Colors.black,//앱바컬러
          actions: [
            IconButton(
              icon: Icon(Icons.person,color: Colors.white,),
              onPressed: () {
                _handleloginpageButton(context);
                // Login icon pressed
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Let's start Easy Backend !!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _handleloginpageButton(context);
                    // "Let's start easybackend" button pressed
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text(
                      "     Login with github    ->",
                      style: TextStyle(fontSize: 20, color: Colors.black),

                    ),

                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20, // 화면 하단과의 간격
            right: 80, // 화면 오른쪽과의 간격
            child: IconButton(
              icon: Image.asset(
                'asset/image/background.png', // 다른 이미지 파일 경로 설정
                width: 200, // 이미지 너비 설정
                height: 270, // 이미지 높이 설정
              ),
              onPressed: () {
                // 이미지 클릭 시 실행될 함수
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function for handling API button press
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginpage()),
    );
  }

  void _handleImagePressed(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

}