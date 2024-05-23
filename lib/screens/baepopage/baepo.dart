import 'dart:typed_data';
import 'package:easyback/screens/baepopage/deploy_menu.dart';
import 'package:easyback/screens/baepopage/sangtae.dart';
import 'package:easyback/screens/loading_dialog.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIDeployments.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../api/ApiPage.dart';
import 'Deployment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Baepo extends StatefulWidget {
  const Baepo({Key? key}) : super(key: key);

  @override
  State<Baepo> createState() => _BaepoState();
}

class _BaepoState extends State<Baepo> {
  String? centerText;
  String showFileName = "";
  String userInput = "";
  Color defaultColor = Colors.grey[400]!;

  bool isSpringSelected = false;
  bool isExpressSelected = false;

  bool checkBox1 = false;
  bool checkBox2 = false;

  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = "";

  PlatformFile? selectedFile;
  String? selectedGithubURL;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
    });
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
              DeployMenu(currentPage: CurrentPage.deployServer),
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
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        '1. 배포할 백엔드 서버의 프레임 워크를 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,                ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 550),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isSpringSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  isSpringSelected = value!;
                                  if (isSpringSelected) {
                                    isExpressSelected = false;
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'Java Spring',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isExpressSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  isExpressSelected = value!;
                                  if (isExpressSelected) {
                                    isSpringSelected = false;
                                  }
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'JS Express',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '2. 배포 방식을 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 550),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'zip으로 업로드 하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'github repository URL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 200),
                        ],
                      ),
                      SizedBox(height: 20),
                      uploadContainer(),
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

  Widget uploadContainer() {
    if(checkBox1) {
      return Column(
        children: [
          makeFilePicker(),
          SizedBox(height: 20),
          ElevatedButton( // 배포하기 버튼
            onPressed: () async {
              if(selectedFile != null) {
                if(isSpringSelected) {
                  setState(() {
                    _isLoading = true;
                  });
                  await APIDeployments.deployNewServerZip(selectedFile!, "spring");
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sangtae()),
                  );
                } else if(isExpressSelected) {
                  setState(() {
                    _isLoading = true;
                  });
                  await APIDeployments.deployNewServerZip(selectedFile!, "express");
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sangtae()),
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // 여백 조정
              child: Text(
                "배포하기",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      );
    } else if(checkBox2) {
      return Column(
        children: [
          Container(
            height: 150,
            width: 300,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      userInput = value;
                      selectedGithubURL = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '   GitHub URL...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton( // 배포하기 버튼
            onPressed: () async {
              if(_isLoading == false && selectedGithubURL != null) {
                if(isSpringSelected) {
                  setState(() {
                    _isLoading = true;
                  });
                  await APIDeployments.deployNewServerGithub(selectedGithubURL!, 'spring');
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sangtae()),
                  );
                } else if(isExpressSelected) {
                  setState(() {
                    _isLoading = true;
                  });
                  await APIDeployments.deployNewServerGithub(selectedGithubURL!, 'express');
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sangtae()),
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // 여백 조정
              child: Text(
                "배포하기",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Container makeFilePicker() {
    return Container(
      height: 150,
      width: 300,
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
              if (result != null && result.files.isNotEmpty) {
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  selectedFile = result.files.first;
                  showFileName = "Now File Name: $fileName";
                  textFieldEnabled = false;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  "Find and Upload",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.upload_rounded,
                  color: defaultColor,
                ),
              ],
            ),
          ),
          Text("(*.zip)", style: TextStyle(color: defaultColor)),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              showFileName,
              style: TextStyle(color: defaultColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showFileName = "";
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              onPrimary: Colors.white,
            ),
            child: Text('Cancel Upload'),
          ),
        ],
      ),
    );
  }
}
