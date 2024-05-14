import 'package:flutter/material.dart';
import '../loginpage.dart';
import '../mainpage/ApiPage.dart';
import '../mainpage/Deployment.dart';
import 'baepo.dart';
import 'update.dart';


bool serverOn = false;
bool serverOff = false;
bool isUpdated = false;


class sangtae extends StatefulWidget {
  const sangtae({Key? key}) : super(key: key);

  @override
  State<sangtae> createState() => _sangtaeState();
}

class _sangtaeState extends State<sangtae> {
  Color buttonColor1 = Colors.black; // 배포 가이드 버튼의 색상
  Color buttonColor2 = Colors.black; // 파일 업로드 버튼의 색상
  Color buttonColor3 = Colors.white12; // 상태관리 버튼의 색상

  bool listView1Expanded = false;
  bool listView2Expanded = false;
  bool listView3Expanded = false;

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
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), // 테두리를 흰색으로 설정
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
                          _handleDeploymentGuideButton(
                              context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
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
                          _handlebaepoGuideButton(
                              context); // 파일 업로드 버튼 클릭 시 이동하는 함수 호출
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
                               // 파일 업로드 버튼 클릭 시 이동하는 함수 호출
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20), // 리스트뷰 오른쪽에 여백 추가
                  child: Row(
                    children: [
                      Expanded(
                        child: Container( //두번째 컨테이너
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: SizedBox(
                            height: 500,
                            child: MyListView(handlePopup: _handlePopup), // Pass the handlePopup function
                          ),
                        ),

                      ),

                      SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              Container(    // 제일 오른쪽 컨테이너
                width: 900,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black, // 배경색을 검정으로 설정
                  borderRadius: BorderRadius.circular(10), // 테두리의 모서리를 둥글게 설정
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), // 테두리를 흰색으로 설정
                ),


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 70),
                            Text(
                              '현재 서버 : ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 70),
                            Text(
                              '서버 상태',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 50),
                                TextButton(
                                  onPressed: () {
                                    // 버튼 동작 추가
                                  },
                                  child: Text(
                                    '작동중',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: Colors.grey, width: 2), // 테두리 색상과 너비 설정
                                  ),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    // 버튼 동작 추가
                                  },
                                  child: Text(
                                    '정지 상태',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: Colors.grey, width: 2), // 테두리 색상과 너비 설정
                                  ),
                                ),
                                SizedBox(width: 50),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      serverOn = true;
                                      serverOff = false;
                                    });
                                    // 서버 On에 대한 작업 수행
                                  },
                                  child: Text(
                                    '서버 on',
                                    style: TextStyle(
                                      color: serverOn ? Colors.green : Colors.white, // 활성화된 경우 초록색, 비활성화된 경우 흰색
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: serverOn ? Colors.green : Colors.grey, width: 2),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      serverOn = false;
                                      serverOff = true;
                                    });
                                    // 서버 Off에 대한 작업 수행
                                  },
                                  child: Text(
                                    '서버 off',
                                    style: TextStyle(
                                      color: serverOff ? Colors.red : Colors.white, // 활성화된 경우 빨간색, 비활성화된 경우 흰색
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: serverOff ? Colors.red : Colors.grey, width: 2),
                                  ),
                                ),
                                SizedBox(width: 50),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isUpdated = true; // 업데이트 버튼을 눌렀을 때 isUpdated 변수를 true로 설정
                                    });
                                    _handleupdateButton(context);
                                    // 업데이트 버튼에 대한 작업 수행
                                  },
                                  child: Text(
                                    '업데이트',
                                    style: TextStyle(
                                      color: isUpdated ? Colors.yellow : Colors.white, // 업데이트 여부에 따라 텍스트 색상 변경
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: isUpdated ? Colors.yellow : Colors.grey, width: 2), // 업데이트 여부에 따라 테두리 색상 변경
                                  ),
                                ),

                                Row(
                                  children: [
                                    SizedBox(width: 50),
                                    TextButton.icon(
                                      onPressed: () {
                                        // 버튼 동작 추가
                               },

                                      label: Text(
                                        '서버 삭제',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      icon: Icon(Icons.delete_forever_outlined, color: Colors.white),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(color: Colors.grey, width: 2),
                                      ),
                                    ),
                                  ],
                                ),

                              ]
                    ),
                            SizedBox(height: 10),
                            Text(
                              '로그', // 추가된 텍스트
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),


              )

            ],
          ),
        ],
      ),
    );
  }

  void _handleAPIButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleupdateButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => update()), // Navigate to UpdatePage
    );
  }


  void _handleDeploymentButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()),
    );
  }

  void _handleLoginPageButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginpage()),
    );
  }

  void _handleImagePressed(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _handlePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 팝업창 모서리를 덜 둥글게 설정
          ),
          backgroundColor: Colors.grey[200], // 팝업창 배경색을 회색으로 설정
          title: Text(
            '현재 서버의 상태:',
            style: TextStyle(
              color: Colors.black, // 텍스트 색상을 검정색으로 설정
              fontSize: 15, // 텍스트 크기를 16로 설정
              fontWeight: FontWeight.normal, // 텍스트를 굵게 설정
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child:Text(
                '확인',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleDeploymentGuideButton(BuildContext context) {
    // Deployment 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()), // Deployment 페이지로 이동
    );
  }

  void _handlebaepoGuideButton(BuildContext context) {
    // Deployment 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => baepo()), // Deployment 페이지로 이동
    );
  }
}

class MyListView extends StatelessWidget {
  final Function(BuildContext) handlePopup;

  MyListView({required this.handlePopup});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, // 리스트뷰가 필요한 공간만 차지하도록 설정
      children: [
        _buildExpansionTile(context, '인스턴스', [
          '리인스턴스 1 - 서버목록 1',
          '리스트뷰 1 - 아이템 2',
          '리스트뷰 1 - 아이템 3',
          '리스트뷰 1 - 아이템 4',
        ]),
        _buildExpansionTile(context, '리스트뷰 2', [
          '리스트뷰 2 - 아이템 1',
          '리스트뷰 2 - 아이템 2',
        ]),
        _buildExpansionTile(context, '리스트뷰 3', [
          '리스트뷰 3 - 아이템 1',
          '리스트뷰 3 - 아이템 2',
        ]),
      ],
    );
  }

  ExpansionTile _buildExpansionTile(BuildContext context, String title, List<String> items) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 16), // 화살표를 텍스트 왼쪽에 배치
      children: items.map((item) {
        return ListTile(
          title: Text(
            item,
            style: TextStyle(color: Colors.white, fontSize: 12), // 텍스트 크기 조정
          ),
          onTap: () {
            // handlePopup(context); // 리스트뷰 아이템 클릭 시 팝업 열기,일단 보류
          },
        );
      }).toList(),
    );
  }
}
