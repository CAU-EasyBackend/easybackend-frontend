import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIAuths.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainMenu(),
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
                    APIAuths.getLogin();
                    //_handleloginpageButton(context);
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
}
