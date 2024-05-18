import 'package:flutter/material.dart';
import '../loginpage.dart';
import '../mainpage/ApiPage.dart';
import '../mainpage/Deployment.dart';
import '../services/APIDeployInfos.dart';
import 'baepo.dart';
import 'update.dart';
import '../models/Instance.dart'; // Instance 모델 임포트

bool serverOn = false;
bool serverOff = false;
bool isUpdated = false;
List<Instance> deployInfoList = []; // 배포 정보를 저장할 리스트 추가

class sangtae extends StatefulWidget {
  const sangtae({Key? key}) : super(key: key);

  @override
  State<sangtae> createState() => _sangtaeState();
}

class _sangtaeState extends State<sangtae> {
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.white12;

  bool listView1Expanded = false;
  bool listView2Expanded = false;
  bool listView3Expanded = false;

  @override
  void initState() {
    super.initState();
    _fetchDeployInfos(); // 배포 정보 가져오기
    setState(() {
      buttonColor1 = Colors.black;
      buttonColor2 = Colors.black;
      buttonColor3 = Colors.white12;
    });
  }

  void _fetchDeployInfos() async {
    try {
      List<Instance> infos = await APIDeployInfos.getDeployInfos();
      setState(() {
        deployInfoList = infos;
      });
    } catch (e) {
      print('Failed to fetch deploy infos: $e');
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleDeploymentGuideButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('배포 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handlebaepoGuideButton(context);
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
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Some action
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
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
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
                            child: MyListView(handlePopup: _handlePopup),
                          ),
                        ),
                      ),
                      SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              Container(
                width: 900,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
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
                                    // Some action
                                  },
                                  child: Text(
                                    '작동중',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: Colors.grey, width: 2),
                                  ),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    // Some action
                                  },
                                  child: Text(
                                    '정지 상태',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: Colors.grey, width: 2),
                                  ),
                                ),
                                SizedBox(width: 50),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      serverOn = true;
                                      serverOff = false;
                                    });
                                  },
                                  child: Text(
                                    '서버 on',
                                    style: TextStyle(
                                      color: serverOn ? Colors.green : Colors.white,
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
                                  },
                                  child: Text(
                                    '서버 off',
                                    style: TextStyle(
                                      color: serverOff ? Colors.red : Colors.white,
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
                                      isUpdated = true;
                                    });
                                    _handleupdateButton(context);
                                  },
                                  child: Text(
                                    '업데이트',
                                    style: TextStyle(
                                      color: isUpdated ? Colors.yellow : Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    side: BorderSide(color: isUpdated ? Colors.yellow : Colors.grey, width: 2),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 50),
                                    TextButton.icon(
                                      onPressed: () {
                                        // Some action
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
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '로그',
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
              ),
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
      MaterialPageRoute(builder: (context) => update()),
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
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.grey[200],
          title: Text(
            '현재 서버의 상태:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()),
    );
  }

  void _handlebaepoGuideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Baepo()),
    );
  }
}

class MyListView extends StatelessWidget {
  final Function(BuildContext) handlePopup;

  MyListView({required this.handlePopup});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      children: items.map((item) {
        return ListTile(
          title: Text(
            item,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          onTap: () {
            // handlePopup(context);
          },
        );
      }).toList(),
    );
  }
}
