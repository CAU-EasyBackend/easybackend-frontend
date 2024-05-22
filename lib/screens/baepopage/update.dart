import 'dart:typed_data'; // Import the dart:typed_data library for Uint8List
import 'package:easyback/screens/baepopage/sangtae.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // file_picker 라이브러리 추가
import '../mainpage/ApiPage.dart';
import '../mainpage/Deployment.dart';
import 'package:http/http.dart' as http; // http 패키지 추가
import 'dart:convert'; // JSON 디코딩을 위한 패키지 추가


class update extends StatefulWidget {
  const update({Key? key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  Color buttonColor1 = Colors.black; // 기본 색상을 검은색으로 설정
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  String? centerText;
  String showFileName = ""; // 선택된 파일 이름을 표시할 변수
  String userInput = ""; // 사용자 입력을 저장할 변수
  Color defaultColor = Colors.grey[400]!; // 기본 색상 설정

  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = ""; // 파일 내용을 저장할 변수 추가

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
                        '업데이트 할 파일을 업로드해주세요.',
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
                                    getFileFromGitHub(userInput);
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

                      SizedBox(height: 20), // 체크박스와 배포하기 버튼 사이 여백

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // 업데이트 버튼 클릭 시 동작
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // 여백 조정
                              child: Text(
                                "업데이트하기",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
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
                getFileFromGitHub(userInput);
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

  void getFileFromGitHub(String url) async {
    try {
      var response = await http.get(Uri.parse(url)); // GitHub URL에서 파일 가져오기
      if (response.statusCode == 200) {
        // 요청이 성공하면 파일 내용을 가져와서 변수에 저장
        setState(() {
          fileContent = response.body; // 파일 내용 저장
        });
      } else {
        // 요청이 실패한 경우 오류 메시지 표시
        setState(() {
          fileContent = "Failed to fetch file: ${response.statusCode}";
        });
      }
    } catch (e) {
      // 네트워크 오류 등의 예외 발생 시 오류 메시지 표시
      setState(() {
        fileContent = "Error: $e";
      });
    }
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
    MaterialPageRoute(builder: (context) => Sangtae()), // sangtae 페이지로 이동
  );
}
