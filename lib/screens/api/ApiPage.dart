import 'package:easyback/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'apicode.dart';
import 'apidetails.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Color buttonColor1 = Colors.white12;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  Color buttonColor4 = Colors.black;
  Color buttonColor5 = Colors.black;
  Color buttonColor6 = Colors.black;
  Color buttonColor7 = Colors.black;
  Color buttonColor8 = Colors.black;
  String? centerText;

  @override
  void initState() {
    super.initState();
    setState(() {
      buttonColor1 = Colors.white12;
    });
  }

  void _handleButtonPress(int buttonIndex) {
    setState(() {
      buttonColor1 = Colors.white12;
      buttonColor2 = buttonIndex == 2 ? Colors.white12 : Colors.black;
      buttonColor3 = buttonIndex == 3 ? Colors.white12 : Colors.black;
      buttonColor4 = buttonIndex == 4 ? Colors.white12 : Colors.black;
      buttonColor5 = buttonIndex == 5 ? Colors.white12 : Colors.black;
      buttonColor6 = buttonIndex == 6 ? Colors.white12 : Colors.black;
      buttonColor7 = buttonIndex == 7 ? Colors.white12 : Colors.black;
      buttonColor8 = buttonIndex == 8 ? Colors.white12 : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MainMenu(),
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
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
                          _handleButtonPress(1);
                          setState(() {
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'API 가이드',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleApiDetailsButton(context);
                          _handleButtonPress(2);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor2,
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
                          _handleApiCodeButton(context);
                          _handleButtonPress(3);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('코드생성'),
                      ),
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress(4);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('API란 ?'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress(5);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('API 명세서란?'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress(6);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('JSON 이란?'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress(7);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('HTTP란?'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleButtonPress(8);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('백엔드란?'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (centerText != null) // centerText가 null이 아닐 때만 텍스트와 버튼 출력
                          Column(
                            children: [
                              Text(
                                centerText!,
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                                textAlign: TextAlign.center, // 텍스트 가운데 정렬
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  _handleApiDetailsButton(context);
                                  _handleButtonPress(2);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "API명세 바로가기 !!     ",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
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

  void _handleApiCodeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apicode()),
    );
  }

  void _handleApiDetailsButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apidetails()),
    );
  }
}
