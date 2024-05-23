import 'package:easyback/screens/baepopage/deploy_menu.dart';
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
  String? centerText;

  @override
  void initState() {
    super.initState();
    setState(() {
      centerText = '배포란 무엇인가?\n룰루랄ㄹ라라ㅏ라 에베베ㅔ\n에베베';
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
              DeployMenu(currentPage: CurrentPage.deploymentGuide),
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

  void _handlebaepoButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>Baepo()),
    );
  }
}
