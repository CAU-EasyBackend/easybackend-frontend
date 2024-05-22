import 'package:easyback/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'baepo.dart';
import 'sangtae.dart';

class Deployment extends StatefulWidget {
  const Deployment({Key? key});

  @override
  State<Deployment> createState() => _DeploymentState();
}

class _DeploymentState extends State<Deployment> {
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
                  color: Colors.black, // 배경색을 검정으로 설정
                  borderRadius: BorderRadius.circular(10), // 테두리의 모서리를 둥글게 설정
                  border: Border.all(
                      color: Colors.white, width: 2), // 테두리를 흰색으로 설정
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
                          setState(() {
                            buttonColor1 = Colors.white12; // 버튼 색상 변경
                            buttonColor2 = Colors.black; // 다른 버튼 색상 원래대로 설정
                            buttonColor3 = Colors.black;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            // 직각 테두리로 설정
                          ),
                        ),
                        child: Text(
                          '배포 가이드',
                          textAlign: TextAlign.center, // 텍스트 가운데 정렬
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handlebaepoButton(context);
                          setState(() {
                            buttonColor1 = Colors.black;
                            buttonColor2 = Colors.white12;
                            buttonColor3 = Colors.black;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('파일 업로드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handlesangtaeButton(context);
                          setState(() {
                            buttonColor1 = Colors.black;
                            buttonColor2 = Colors.black;
                            buttonColor3 = Colors.white12;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('상태관리'),
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
                        child: Text('배포란 ?'),
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
                        child: Text('서비스 이용 시 주의사항'),
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
                                style: TextStyle(fontSize: 26,
                                    fontWeight: FontWeight.w100, color: Colors.white),
                                textAlign: TextAlign.center, // 텍스트 가운데 정렬
                              ),

                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  _handlebaepoButton(context);
                                  setState(() {
                                    buttonColor1 = Colors.black;
                                    buttonColor2 = Colors.white12;
                                    buttonColor3 = Colors.black;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),

                                  ),
                                ),child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // 좀 더 적절한 값으로 조정하세요
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // 필요한 만큼의 공간만 차지하도록 설정
                                    children: [
                                      Text(
                                        "배포 바로가기 !!     ",
                                        style: TextStyle(fontSize: 18, color: Colors.black),
                                      ),
                                      Icon(Icons.arrow_forward), // 아이콘
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

  void _handlesangtaeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Sangtae()),
    );
  }

  void _handlebaepoButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>Baepo()),
    );
  }
}
