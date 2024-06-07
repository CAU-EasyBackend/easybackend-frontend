import 'package:easyback/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'ApiPage.dart';
import 'apicode.dart';

class apidetails extends StatefulWidget {
  apidetails({Key? key}) : super(key: key);

  @override
  State<apidetails> createState() => _apidetailsState();
}

class _apidetailsState extends State<apidetails> {
  // final controller = Webview;
  // final WebviewController _webviewController = WebviewController();
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  Color buttonColor4 = Colors.black;
  Color buttonColor5 = Colors.black;
  Color buttonColor6 = Colors.black;
  Color buttonColor7 = Colors.black;
  Color buttonColor8 = Colors.black;
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
      buttonColor2 = Colors.white38;
    });
  }

  // Future<void> _initializeWebView() async {
  //   try {
  //     await _webviewController.initialize();
  //     await _webviewController.loadUrl(
  //         'https://your-backend-url/swagger-ui.html');
  //
  //     _webviewController.url.listen((url) {
  //       print('Navigated to: $url');
  //     });
  //
  //     _webviewController.containsFullScreenElementChanged.listen((flag) {
  //       print('Contains full screen element: $flag');
  //     });
  //
  //     if (!mounted) return;
  //     setState(() {});
  //   } catch (e) {
  //     print('Error initializing WebView: $e');
  //   }
  // }

  void _handleButtonPress(int buttonIndex) {
    setState(() {
      buttonColor1 = Colors.white38;
      buttonColor2 = buttonIndex == 2 ? Colors.white38 : Colors.black;
      buttonColor3 = buttonIndex == 3 ? Colors.white38 : Colors.black;
      buttonColor4 = buttonIndex == 4 ? Colors.white38 : Colors.black;
      buttonColor5 = buttonIndex == 5 ? Colors.white38 : Colors.black;
      buttonColor6 = buttonIndex == 6 ? Colors.white38 : Colors.black;
      buttonColor7 = buttonIndex == 7 ? Colors.white38 : Colors.black;
      buttonColor8 = buttonIndex == 8 ? Colors.white38 : Colors.black;
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
            children: [
              SizedBox(width: 20),
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
                          _handleapiguideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
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
                            showSwaggerUI = true; // Swagger UI를 보여줄 상태를 true로 설정합니다.
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
                          _handleapicodeButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
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
              SizedBox(width: 20),


              Container(
                  width: 200, // 첫 번째 컨테이너의 너비를 설정
                  height: 500,//컨테이너 3
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: 200, // 버튼의 너비를 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                         //클릭시 이벤트 추가
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Text('하이'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {

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
                        child: Text('하이루'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: 200, // 버튼의 너비를 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor6,
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
              SizedBox(width: 20),

              Expanded(
                child:
                Container(//컨테이너 3
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }

  void _handleapiguideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleapicodeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apicode()), // Deployment 페이지로 이동
    );
  }
}
