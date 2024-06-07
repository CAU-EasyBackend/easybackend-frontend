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
  Color buttonColor1 = Colors.white38;
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
      buttonColor1 = Colors.white38;
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로로 동일한 간격으로 배치
            children: [
              SizedBox(width: 20),
              DeployMenu(currentPage: CurrentPage.deploymentGuide),
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
                            centerText = '배포란 \n\n개발된 소프트웨어나 애플리케이션을\n 사용자에게 제공하는 것을 의미합니다.';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('배포란 ?'),
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
                            centerText = '주의사항은 \n\n샤랄라 샤랄라.';
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
                        child: Text('서비스 이용 시 주의사항'),
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
                        if (centerText != null)
                          Column(
                            children: [
                              Text(
                                centerText!,
                                style: TextStyle(fontSize: 26,
                                    fontWeight: FontWeight.w100, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),

                            ],
                          ),
                      ],
                    ),
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

  void _handlebaepoButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>Baepo()),
    );
  }
}
