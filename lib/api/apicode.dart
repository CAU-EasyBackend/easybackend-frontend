import 'dart:typed_data'; // Import the dart:typed_data library for Uint8List
import 'package:easyback/baepopage/sangtae.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // file_picker 라이브러리 추가
import '../mainpage/ApiPage.dart';
import '../loginpage.dart';
import '../mainpage/Deployment.dart';
import 'package:http/http.dart' as http; // http 패키지 추가
import 'dart:convert';

import 'apidetails.dart'; // JSON 디코딩을 위한 패키지 추가


class apicode extends StatefulWidget {
  const apicode({Key? key});

  @override
  State<apicode> createState() => _apicodeState();
}

class _apicodeState extends State<apicode> {
  Color buttonColor1 = Colors.black; // 기본 색상을 검은색으로 설정
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.white12;

  @override
  void initState() {
    super.initState();
    setState(() {
      buttonColor1 = Colors.black; // 배포 가이드 버튼 색상 변경
      buttonColor2 = Colors.black; // 파일 업로드 버튼 색상 변경
      buttonColor3 = Colors.white12; // 상태관리 버튼 색상 변경
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
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
              onPressed: () {
                _handleLoginPageButton(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로로 동일한 간격으로 배치
            children: [
              Container(
                width: 200, // 첫 번째 컨테이너의 너비를 설정
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black, // 배경색을 검정으로 설정
                  borderRadius: BorderRadius.circular(10), // 테두리의 모서리를 둥글게 설정
                  border: Border.all(color: Colors.white, width: 2), // 테두리를 흰색으로 설정
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapipageButton(context);  // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Text('API 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapiguideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('API 명세'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapicodeButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white,width: 1),
                          ),
                        ),
                        child: Text('코드생성'),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              SizedBox(width: 20),//컨테이너 1,2사이 간격
              Expanded(
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // API 버튼 처리
  void _handleAPIButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleapiguideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apidetails()),
    );
  }

  // Deployment 버튼 처리
  void _handleDeploymentButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()),
    );
  }

  // 로그인 페이지 버튼 처리
  void _handleLoginPageButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginpage()),
    );
  }

  // 이미지 버튼 처리
  void _handleImagePressed(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}


void  _handleapipageButton(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ApiPage()), // sangtae 페이지로 이동
  );
}

void _handleapicodeButton(BuildContext context) { // _handleapicodeButton 메서드 추가
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => apicode()), // 적절한 페이지로 이동
  );
}
