import 'package:easyback/models/Instance.dart';
import 'package:easyback/models/Server.dart';
import 'package:easyback/screens/baepopage/deploy_menu.dart';
import 'package:easyback/screens/baepopage/server_update_popup.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIDeployInfos.dart';
import 'package:flutter/material.dart';
import 'Deployment.dart';
import 'baepo.dart';
import 'update.dart';

bool serverOn = true;
bool isUpdated = false;

class Sangtae extends StatefulWidget {
  const Sangtae({Key? key}) : super(key: key);

  @override
  State<Sangtae> createState() => _SangtaeState();
}

class _SangtaeState extends State<Sangtae> {
  List<Instance> deployInfoList = [];

  Instance? selectedInstance;
  Server? selectedServer;

  @override
  void initState() {
    super.initState();
    _fetchDeployInfos();
  }

  Future<void> _fetchDeployInfos() async {
    try {
       List<Instance> infos = await APIDeployInfos.getDeployInfos();
      //List<Instance> infos = await APIDeployInfos.testGetDeployInfos();
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
              SizedBox(width: 20),
              DeployMenu(currentPage: CurrentPage.statusManagement),
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
              Column(
                children: [
                  Container(
                    width: 900,
                    height: 195,
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
                            child: selectedInstance != null
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '인스턴스 정보',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '인스턴스 이름 : ${selectedInstance?.instanceName ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'IP : ${selectedInstance?.IP ?? ''}',
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
                                        setState(() {
                                          serverOn = true;
                                        });
                                      },
                                      child: Text(
                                        '인스턴스 on',
                                        style: TextStyle(
                                          color: serverOn
                                              ? Colors.green
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: serverOn
                                                ? Colors.green
                                                : Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          serverOn = false;
                                        });
                                      },
                                      child: Text(
                                        '인스턴스 off',
                                        style: TextStyle(
                                          color: !serverOn
                                              ? Colors.red
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: !serverOn
                                                ? Colors.red
                                                : Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () {
                                        _showLogConfirmationDialog(context);
                                      },
                                      child: Text(
                                        '로그 확인',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Row(
                                      children: [
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            if(selectedInstance!=null) {
                                              _showDeleteConfirmationDialog(context);
                                            }
                                          },
                                          label: Text(
                                            '인스턴스 삭제',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          icon: Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.white),
                                          style: TextButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : SizedBox.shrink(),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 900,
                    height: 290,
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
                            child: selectedServer != null
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '서버 정보',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '프로젝트 이름 : ${selectedServer?.serverName ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '버전 : ${selectedServer?.runningVersion ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Port : ${selectedServer?.port ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          serverOn = true;
                                        });
                                      },
                                      child: Text(
                                        '서버 on',
                                        style: TextStyle(
                                          color: serverOn
                                              ? Colors.green
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: serverOn
                                                ? Colors.green
                                                : Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          serverOn = false;
                                        });
                                      },
                                      child: Text(
                                        '서버 off',
                                        style: TextStyle(
                                          color: !serverOn
                                              ? Colors.red
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: !serverOn
                                                ? Colors.red
                                                : Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ServerUpdatePopup(instance: selectedInstance!, server: selectedServer!);
                                          },
                                        );
                                      },
                                      child: Text(
                                        '서버 업데이트',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 2
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () {
                                      },
                                      child: Text(
                                        '버전 관리',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 2),
                                      ),
                                    ),
                                    SizedBox(width: 50),
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
                                          icon: Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.white),
                                          style: TextButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : SizedBox.shrink(),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),

              ],
      )
            );
  }

  void _handleUpdateButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => update()),
    );
  }

  void _handlePopup(Instance instance, Server? server) {
    setState(() {
      selectedInstance = instance;
      selectedServer = server;
    });
  }

  Future<void> _showLogConfirmationDialog(BuildContext context) async {

    final logData=await APIDeployInfos.fetchLogData(selectedInstance!.instanceId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          title: Text(
            '로그',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Container(
            width: 550,
            height: 300, // Adjust the height as needed
            child: Scrollbar(
              child: SingleChildScrollView( //스크롤 가능
                child: Text(
                 logData,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.white, width: 2.0),
        ),
        title: Text(
          '인스턴스 삭제 확인',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '정말로 인스턴스를 삭제하시겠습니까?',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('취소', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('삭제', style: TextStyle(color: Colors.red)),
            onPressed: () async {
              if (selectedInstance != null) {
                
                await APIDeployInfos.deleteInstance(selectedInstance!.instanceId);
                Navigator.of(context).pop();
                setState(() {
                  deployInfoList.remove(selectedInstance);
                  selectedInstance = null;
                  selectedServer = null;
                });
              }
            },
          ),
        ],
      );
    },
  );
}
}



class MyListView extends StatelessWidget {
  final List<Instance> deployInfoList;
  final Function(Instance, Server?) handlePopup;

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
          onExpansionChanged: (expanded) {
            handlePopup(instance, null);
          },
          children: instance.servers.map((server) {
            return ListTile(
              title: Text(
                server.serverName,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onTap: () {
                handlePopup(instance, server);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
