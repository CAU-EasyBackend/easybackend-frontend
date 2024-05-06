import 'dart:typed_data'; // Import the dart:typed_data library for Uint8List

import 'package:easyback/baepopage/sangtae.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // file_picker 라이브러리 추가
import '../mainpage/ApiPage.dart';
import '../loginpage.dart';
import '../mainpage/Deployment.dart';

class baepo extends StatefulWidget {
  const baepo({Key? key});

  @override
  State<baepo> createState() => _baepoState();
}

class _baepoState extends State<baepo> {
  Color buttonColor1 = Colors.black; // 기본 색상을 검은색으로 설정
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  String? centerText;
  String showFileName = ""; // 선택된 파일 이름을 표시할 변수
  String userInput = ""; // 사용자 입력을 저장할 변수
  Color defaultColor = Colors.grey[400]!; // 기본 색상 설정

  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true; // 파일 업로드 활성화 여부
  bool textFieldEnabled = true; // 텍스트 필드 활성화 여부

  @override
  void initState() {
    super.initState();
    setState(() {
      buttonColor2 = Colors.white12; // 파일 업로드 버튼 색상 변경
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
                          _handleDeploymentGuideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Text('배포 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            _handleDeploymentGuideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                          },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor2,
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
                            _handlesangtaeButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                          },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white,width: 1),
                          ),
                        ),
                        child: Text('상태관리'),
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

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        '파일 업로드 방식을 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 170), //파일 편집기와 컨테이너2 사이 여백
                          Expanded(
                            child: makeFilePicker(), // 파일 선택기 추가
                          ),
                          SizedBox(width: 30), // 파일 선택기와 취소 버튼 사이 여백

                          SizedBox(width: 100), // 취소 버튼과 텍스트 필드 사이 여백
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  enabled: textFieldEnabled, // 텍스트 필드 활성화 여부 설정
                                  onChanged: (value) {
                                    setState(() {
                                      userInput = value;
                                      fileUploadEnabled = userInput.isEmpty; // 텍스트 필드에 내용이 없을 때 파일 업로드 활성화
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: '   github URL... ', // 사용자에게 안내할 힌트 텍스트
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // 화살표 아이콘을 클릭한 경우 발생할 이벤트 추가
                                    // 예를 들어, 다음 단계로 넘어가는 로직을 추가할 수 있습니다.
                                  },
                                  icon: Icon(Icons.arrow_forward),

                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 200),
                        ],
                      ),
                      SizedBox(height: 40), // 파일 업로드와 워크 플로루 선택 사이 여백
                      Text(
                        '코드 생성을 위한 프레임 워크를 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10), // 텍스트와 체크박스 사이 여백
                      Row(
                        children: [
                          SizedBox(width: 550),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white, // 선택되지 않은 상태일 때 체크박스의 색상 설정
                            ),
                            child: Checkbox(
                              value: checkBox1,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBox1 = value!;
                                  if (checkBox1) checkBox2 = false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // 동글게 만들기 위해 경계를 둥글게 설정
                              ),
                              checkColor: Colors.white, // 체크 표시의 색상 설정
                              fillColor: MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) { // 클릭 시의 상태 체크
                                  return Colors.grey; // 클릭 시의 배경색 설정
                                }
                                return Colors.transparent; // 일반 상태의 배경색 설정
                              }),
                            ),
                          ),
                          Text(
                            'java spring',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20), // 체크박스 사이 간격
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white, // 선택되지 않은 상태일 때 체크박스의 색상 설정
                            ),
                            child: Checkbox(
                              value: checkBox2,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBox2 = value!;
                                  if (checkBox2) checkBox1 = false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // 동글게 만들기 위해 경계를 둥글게 설정
                              ),
                              checkColor: Colors.white, // 체크 표시의 색상 설정
                              fillColor: MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) { // 클릭 시의 상태 체크
                                  return Colors.grey; // 클릭 시의 배경색 설정
                                }
                                return Colors.transparent; // 일반 상태의 배경색 설정
                              }),
                            ),
                          ),
                          Text(
                            'js express',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // 체크박스와 배포하기 버튼 사이 여백
                      ElevatedButton( // 배포하기 버튼
                        onPressed: () {
                          // 배포하기 버튼 클릭 시 수행할 작업 추가
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey, // 배경색을 회색으로 변경
                          onPrimary: Colors.white, // 텍스트 색상을 흰색으로 변경
                        ),
                        child: Text('배포하기'),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // 파일 선택기 위젯
  Container makeFilePicker(){
    return Container(
      height: 170,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['zip'],
              );
              if( result != null && result.files.isNotEmpty ){
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  showFileName = "Now File Name: $fileName";
                  textFieldEnabled = false; // 파일 선택 시 텍스트 필드 비활성화
                });
                /*
              do jobs
              */
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50),
                Text("Find and Upload", style: TextStyle(
                  fontWeight: FontWeight.bold, color: defaultColor, fontSize: 20,),),
                Icon(Icons.upload_rounded, color: defaultColor,),
              ],
            ),
          ),
          Text("(*.zip)", style: TextStyle(color: defaultColor,),),
          const SizedBox(height: 10,),
          Expanded(
            child: Text(
              showFileName,
              style: TextStyle(color: defaultColor,),
              overflow: TextOverflow.ellipsis, // 길이가 넘어갈 경우 생략 부호를 표시합니다.
            ),
          ),
          ElevatedButton( // 취소 버튼 추가
            onPressed: () {
              setState(() {
                showFileName = ""; // 파일 이름 초기화
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey, // 배경색을 defaultColor로 설정
              onPrimary: Colors.white, // 텍스트 색상을 흰색으로 설정
            ),
            child: Text('Cancel Upload'),

            // 버튼 텍스트
          ),
          SizedBox(height: 20), // 캔슬버튼과 컨테이너 사이 여백
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

void _handleDeploymentGuideButton(BuildContext context) {
  // Deployment 페이지로 이동
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Deployment()), // Deployment 페이지로 이동
  );
}

void _handlesangtaeButton(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => sangtae()), // sangtae 페이지로 이동
  );
}
