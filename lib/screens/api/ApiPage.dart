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
                          setState(() {
                            centerText = 'api란\n \n다른 소프트웨어 애플리케이션과 통신하여\n 데이터를 주고받고 기능을 공유할 수 있도록 도와주는 도구나 기능입니다. ';
                          });
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
                          setState(() {
                            centerText = 'API 명세서는\n\n 소프트웨어 개발자나 이용자에게 제공되는 문서로,\n 특정 API의 기능, 사용 방법, 엔드포인트 및 매개변수\n 등에 대한 세부 정보를 제공합니다.';
                          });
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
                          setState(() {
                            centerText = 'JSON은\n \n데이터를 표현하고 교환하기 위한 경량의 형식으로,\n 텍스트로 이루어진 키-값 쌍이나 배열로 구성됩니다.\n 주로 웹 애플리케이션과 서버 간 데이터 통신에 사용되며,\n 읽고 쓰기 쉽고 기계가 파싱하기 쉽도록 설계되어 있습니다.';
                          });
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
                          setState(() {
                            centerText = 'HTTP는\n\n하이퍼텍스트 전송 프로토콜로, 클라이언트와 서버 간에\n 데이터를 주고받는 데 사용됩니다.\n 주로 웹 브라우저와 웹 서버 간에 \nHTML 페이지, 이미지, 동영상 등의 리소스를 전송하는 데 쓰입니다.\n 요청과 응답은 헤더와 본문으로 구성되며,\n 헤더에는 요청 또는 응답에 대한 메타데이터가 포함됩니다.';
                          });
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
                          setState(() {
                            centerText = '백엔드란 \n\n백엔드는 웹 애플리케이션이나 모바일 앱의 뒷단을 담당하는 부분으로,\n 데이터베이스 관리, 서버 측 로직 실행, 인증 및 보안, API 엔드포인트 제공,\n 성능 최적화 등의 역할을 합니다.';
                          });
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
