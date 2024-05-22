import 'package:easyback/models/Instance.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIDeployInfos.dart';
import 'package:flutter/material.dart';
import 'Deployment.dart';
import 'baepo.dart';
import 'update.dart';

bool serverOn = false;
bool serverOff = false;
bool isUpdated = false;
List<Instance> deployInfoList = [];

class Sangtae extends StatefulWidget {
  const Sangtae({Key? key}) : super(key: key);

  @override
  State<Sangtae> createState() => _SangtaeState();
}

class _SangtaeState extends State<Sangtae> {
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.white12;

  List<Instance> deployInfoList = [];

  @override
  void initState() {
    super.initState();
    print("test1");
    _fetchDeployInfos();
  }

  Future<void> _fetchDeployInfos() async {
    try {
      List<Instance> infos = await APIDeployInfos.testGetDeployInfos();
      print("test2");
      print(infos.length);
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
      appBar: MainMenu(),
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
                          _handleBaepoGuideButton(context);
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
                            child: MyListView(
                              deployInfoList: deployInfoList,
                              handlePopup: _handlePopup,
                            ),
                          ),
                        ),
                      ),
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
                                    _handleUpdateButton(context);
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

  // 나머지 코드는 동일합니다.

  void _handleUpdateButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => update()),
    );
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
              child: Text(
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

  void _handleBaepoGuideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Baepo()),
    );
  }
}

class MyListView extends StatelessWidget {
  final Function(BuildContext) handlePopup;
  final List<Instance> deployInfoList;

  MyListView({
    required this.deployInfoList,
    required this.handlePopup,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: deployInfoList.length,
      itemBuilder: (context, index) {
        final instance = deployInfoList[index];
        return ExpansionTile(
          title: Row(
            children: [
              Icon(
                Icons.arrow_right,
                color: Colors.white,
              ),
              Text(
                instance.instanceName,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          children: instance.servers.map((server) {
            return ListTile(
              title: Text(
                server.serverName,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onTap: () {
                handlePopup(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
