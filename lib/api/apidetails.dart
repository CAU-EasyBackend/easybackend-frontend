import 'dart:async';
import 'package:webview_windows/webview_windows.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '../mainpage/ApiPage.dart';
import '../loginpage.dart';
import '../mainpage/Deployment.dart';
import 'apicode.dart';

class apidetails extends StatefulWidget {
   apidetails({Key? key});

  @override
  State<apidetails> createState() => _apidetailsState();
}

class _apidetailsState extends State<apidetails> {
  final controller = Webview;
  final WebviewController _webviewController = WebviewController();
  Color buttonColor1 = Colors.black; // 기본 색상을 검은색으로 설정
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  String? centerText;
  String showFileName = ""; // 선택된 파일 이름을 표시할 변수
  String userInput = ""; // 사용자 입력을 저장할 변수
  Color defaultColor = Colors.grey[400]!; // 기본 색상 설정

  bool showSwaggerUI = false;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = ""; // 파일 내용을 저장할 변수 추가

  @override
  void initState() {
    super.initState();

    // Initialize the WebView controller if using webview_flutter
    // No specific initialization required for webview_flutter

    setState(() {
      buttonColor2 = Colors.white12;
    });
  }

  Future<void> _initializeWebView() async {
    try {
      await _webviewController.initialize();
      await _webviewController.loadUrl(
          'https://your-backend-url/swagger-ui.html');

      _webviewController.url.listen((url) {
        print('Navigated to: $url');
      });

      _webviewController.containsFullScreenElementChanged.listen((flag) {
        print('Contains full screen element: $flag');
      });

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print('Error initializing WebView: $e');
    }
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
                          _handleapiguideButton(
                              context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Text('API 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showSwaggerUI =
                            true; // Swagger UI를 보여줄 상태를 true로 설정합니다.
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
                        child: Text('API 명세'),

                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapicodeButton(
                              context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
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
                    SizedBox(height: 100),
                  ],
                ),
              ),
              SizedBox(width: 20), //컨테이너 1,2사이 간격
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
                   // child: showSwaggerUI ?
                  //  WebView(
                   //   initialUrl: 'https://your-backend-url/swagger-ui.html',
                    //  javascriptMode: JavascriptMode.unrestricted,
                   // ) ://
                   // Center(
                    //  child: Text(
                      //  'Select an option to display the content.',
                    //    style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
             //   ),
          //    ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSwaggerButton2(BuildContext context) {
    setState(() { // 상태를 변경해서 위젯을 업데이트합니다.
      showSwaggerUI = true; // seeSwaggerUI를 true로 바꿔서 WebView를 표시하도록 합니다.
    });
  }
}

void _handleDeploymentButton(BuildContext context) {
    // Deployment 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()), // Deployment 페이지로 이동
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
      MaterialPageRoute(builder: (context) => ApiPage()),
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


void _handleapicodeButton(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => apicode()), // Deployment 페이지로 이동
  );
}
