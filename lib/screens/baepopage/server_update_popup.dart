import 'package:easyback/models/Instance.dart';
import 'package:easyback/models/Server.dart';
import 'package:easyback/services/APIDeployments.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ServerUpdatePopup extends StatefulWidget {
  final Instance instance;
  final Server server;

  const ServerUpdatePopup({Key? key, required this.instance, required this.server}) : super(key: key);

  @override
  _ServerUpdatePopupState createState() => _ServerUpdatePopupState();
}

class _ServerUpdatePopupState extends State<ServerUpdatePopup> {
  bool isSpringSelected = false;
  bool isExpressSelected = false;
  bool checkBox1 = false;
  bool checkBox2 = false;
  PlatformFile? selectedFile;
  String? selectedGithubURL;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('서버 업데이트'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('1. 업데이트 할 백엔드 서버의 프레임워크를 선택해주세요.'),
            Row(
              children: [
                Checkbox(
                  value: isSpringSelected,
                  onChanged: (value) {
                    setState(() {
                      isSpringSelected = value!;
                      isExpressSelected = !value;
                    });
                  },
                ),
                Text('Java Spring'),
                SizedBox(width: 20),
                Checkbox(
                  value: isExpressSelected,
                  onChanged: (value) {
                    setState(() {
                      isExpressSelected = value!;
                      isSpringSelected = !value;
                    });
                  },
                ),
                Text('JS Express'),
              ],
            ),
            SizedBox(height: 20),
            Text('2. 배포 방식을 선택해주세요.'),
            Row(
              children: [
                Checkbox(
                  value: checkBox1,
                  onChanged: (value) {
                    setState(() {
                      checkBox1 = value!;
                      checkBox2 = !value;
                    });
                  },
                ),
                Text('zip으로 업로드 하기'),
                SizedBox(width: 20),
                Checkbox(
                  value: checkBox2,
                  onChanged: (value) {
                    setState(() {
                      checkBox2 = value!;
                      checkBox1 = !value;
                    });
                  },
                ),
                Text('github repository URL'),
              ],
            ),
            SizedBox(height: 20),
            if (checkBox1)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['zip'],
                      );
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          selectedFile = result.files.first;
                        });
                      }
                    },
                    child: Text('파일 선택'),
                  ),
                  if (selectedFile != null)
                    Text('선택된 파일: ${selectedFile!.name}'),
                ],
              ),
            if (checkBox2)
              Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        selectedGithubURL = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'GitHub URL을 입력하세요.',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: _isLoading ? CircularProgressIndicator() : Text('업데이트'),
          onPressed: _isLoading ? null : _updateServer,
        ),
      ],
    );
  }

  void _updateServer() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (checkBox1 && selectedFile != null) {
        // zip 파일을 이용한 업데이트 로직
        String frameworkType = isSpringSelected ? 'spring' : 'express';
        await APIDeployments.updateServerZip(
            widget.instance.instanceId, selectedFile!, frameworkType);
      } else if (checkBox2 && selectedGithubURL != null) {
        // GitHub URL을 이용한 업데이트 로직
        String frameworkType = isSpringSelected ? 'spring' : 'express';
        await APIDeployments.updateServerGithub(
            widget.instance.instanceId, selectedGithubURL!, frameworkType);
      }

      // 업데이트 성공 시 처리할 로직 추가
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('서버가 업데이트되었습니다.')),
      );
    } catch (e) {
      // 업데이트 실패 시 처리할 로직 추가
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('서버 업데이트에 실패했습니다.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}