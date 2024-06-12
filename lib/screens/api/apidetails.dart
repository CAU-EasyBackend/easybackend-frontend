import 'dart:convert';

import 'package:easyback/models/APISpec.dart';
import 'package:easyback/models/OpenAPISpec.dart';
import 'package:easyback/screens/api/ProjectListView.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIOpenAPISpec.dart';
import 'package:easyback/services/APIProjects.dart';
import 'package:flutter/material.dart';
import 'ApiPage.dart';
import 'apicode.dart';

class apidetails extends StatefulWidget {
  apidetails({Key? key}) : super(key: key);

  @override
  State<apidetails> createState() => _apidetailsState();
}

class _apidetailsState extends State<apidetails> {
  // final controller = Webview;
  // final WebviewController _webviewController = WebviewController();
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  Color buttonColor4 = Colors.black;
  Color buttonColor5 = Colors.black;
  Color buttonColor6 = Colors.black;
  Color buttonColor7 = Colors.black;
  Color buttonColor8 = Colors.black;
  String? centerText;
  String showFileName = ""; // 선택된 파일 이름을 표시할 변수
  String userInput = ""; // 사용자 입력을 저장할 변수
  Color defaultColor = Colors.grey[400]!; // 기본 색상 설정

  bool showSwaggerUI = false;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = ""; // 파일 내용을 저장할 변수 추가

  List<APISpec> projects = [];
  APISpec? selectedProject;
  OpenAPISpec? openAPISpec;

  String? selectedEndpoint;
  String? selectedMethod;
  Operation? selectedOperation;

  bool _isModify = false;

  TextEditingController _urlController = TextEditingController();

  bool _isEditingParameter = false;
  List<TextEditingController> _parameterController = [];

  bool _isEditingRequestBody = false;
  TextEditingController _requestBodyController = TextEditingController();
  RequestBody? _instanceRequestBody;

  Map<String, bool> _isEditingResponse = {};
  Map<String, TextEditingController> _responseController = {};
  Map<String, String> _memorizedOriginalResponse = {};

  @override
  void initState() {
    super.initState();
    _getProjects();

    setState(() {
      buttonColor2 = Colors.white38;
    });
  }

  Future<void> _getProjects() async {
    final List<APISpec> projects = await APIProjects.getProjectList();
    setState(() {
      this.projects = projects;
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

  Future<void> _handleSaveAPI() async {
    if(openAPISpec != null) {
      await APIProjects.saveProject(selectedProject!.projectName, openAPISpec!);
      setState(() {
        _isModify = false;
      });
    }
  }

  void _handlePlusButton() {
    print("Plus button pressed");

    print("test");
    print(openAPISpec!.toJson().toString());

    String prettyJson = JsonEncoder.withIndent('  ').convert(openAPISpec!.toJson());
    print(prettyJson);
  }

  void _handleDeleteButton() {
    print("Delete button pressed");
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
            children: [
              SizedBox(width: 20),
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
                          _handleapiguideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
                          ),
                        ),
                        child: Text('API 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          //await APIOpenAPISpec.getAPIObject('664fe646f67ab0617034fd56');
                          setState(() {
                            showSwaggerUI = true; // Swagger UI를 보여줄 상태를 true로 설정합니다.
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('API 명세'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapicodeButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('코드생성'),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                  width: 200, // 첫 번째 컨테이너의 너비를 설정
                  height: 500,//컨테이너 3
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    SizedBox(
                      height: 400,
                      width: 200,
                      child: ProjectListView(
                        projects: projects,
                        handleProjectTap: _handleProjectTap,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.black, // 컨테이너 색상 설정
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: _handlePlusButton,
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: _handleDeleteButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.center, // 왼쪽 정렬
                  children: [
                    SizedBox(height: 10),
                    const Text(
                      'Server URL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: _urlController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      enabled: openAPISpec != null,
                      onChanged: (text) {
                        setState(() {
                          openAPISpec!.servers[0].url = text;
                          _isModify = true;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'API List',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 300,
                      width: 200,
                      child: selectedProject != null
                          ? ListView(
                        children: openAPISpec!.paths.entries.map((entry) {
                          String path = entry.key;
                          Path pathObject = entry.value;
                          return ExpansionTile(
                            title: Text(
                              path,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            children: pathObject.operations.entries.map((opEntry) {
                              String method = opEntry.key;
                              Operation operation = opEntry.value;
                              return ListTile(
                                title: Text(
                                  method,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedEndpoint = path;
                                    selectedMethod = method;
                                    selectedOperation = operation;
                                    _initAPIControllers();
                                  });
                                },
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ) : Container(),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.black, // 컨테이너 색상 설정
                          child: Column(
                            children: [
                              _isModify
                              ? const Text(
                                '수정 중',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              )
                              : const Text(
                                '저장 됨',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.save, color: Colors.white),
                                    onPressed: _handleSaveAPI,
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.white),
                                    onPressed: _handlePlusButton,
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white),
                                    onPressed: _handleDeleteButton,
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
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 500,
                      width: 850,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: selectedOperation != null
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'URL: ${openAPISpec!.servers[0].url}$selectedEndpoint',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Method: $selectedMethod',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ExpansionTile(
                                title: Row(
                                  children: [
                                    const Text(
                                      'Parameters',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _isEditingParameter
                                        ? _buildParameterSaveButton()
                                        : _buildParameterEditButton(),
                                  ],
                                ),
                                children: [
                                  selectedOperation!.parameters != null
                                  ? SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: selectedOperation!.parameters!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Row(
                                              children: [
                                                const Text(
                                                  'Name:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: TextField(
                                                    controller: _parameterController[index],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                    enabled: _isEditingParameter,
                                                    onChanged: (text) {
                                                      setState(() {
                                                        selectedOperation!.parameters![index].name = text;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Type: ${selectedOperation!.parameters![index].schema.type}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text(
                                                  'In:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                DropdownButton(
                                                  value: selectedOperation!.parameters![index].in_,
                                                  onChanged: _isEditingParameter ? (String? newValue) {
                                                    setState(() {
                                                      selectedOperation!.parameters![index].in_ = newValue!;
                                                    });
                                                  } : null,
                                                  dropdownColor: Colors.black,
                                                  items: ['query', 'header', 'path', 'cookie'].map((inType) {
                                                    return DropdownMenuItem(
                                                      value: inType,
                                                      child: Text(
                                                        inType,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text(
                                                  'Required:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Checkbox(
                                                  value: selectedOperation!.parameters![index].required,
                                                  onChanged: _isEditingParameter ? (bool? newValue) {
                                                    setState(() {
                                                      selectedOperation!.parameters![index].required = newValue!;
                                                    });
                                                  } : null,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    ),
                                  ) : const Text(
                                    'No Parameters',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                title: Row(
                                  children: [
                                    const Text(
                                      'Request Body',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _isEditingRequestBody
                                      ? _buildRequestBodySaveCancelButton()
                                      : _buildRequestBodyEditButton(),
                                  ],
                                ),
                                children: [
                                  _instanceRequestBody != null
                                  ? TextField(
                                    controller: _requestBodyController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    maxLines: null,
                                    enabled: _isEditingRequestBody,
                                  )
                                  : const Text(
                                    'No Request Body',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                title: Row(
                                  children: [
                                    const Text(
                                      'Responses',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _buildResponseAddButton(),
                                  ],
                                ),
                                children: selectedOperation!.responses.entries.map((entry) {
                                  String code = entry.key;
                                  Response response = entry.value;
                                  return ExpansionTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          'Code: $code',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          response.content.entries.first.key,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        _isEditingResponse[code]!
                                            ? _buildResponseSaveCancelButton(code)
                                            : _buildResponseEditButton(code),
                                      ],
                                    ),
                                    children: [
                                      TextField(
                                        controller: _responseController[code],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        maxLines: null,
                                        enabled: _isEditingResponse[code]!,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ) : Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
    ]
    ),
    );
  }

  void _startEditingParameter() {
    setState(() {
      _isEditingParameter = true;
      _isModify = true;
    });
  }

  void _addParameter() {
    Parameter parameter = Parameter.fromJson({
      'name': 'newParameter',
      'in': 'query',
      'required': false,
      'schema': {
        'type': 'string',
      },
    });
    setState(() {
      selectedOperation!.parameters!.add(parameter);
      _parameterController.add(TextEditingController(text: parameter.name));
      _isModify = true;
    });
  }

  void _saveEditingParameter() {
    setState(() {
      _isEditingParameter = false;
    });
  }

  void _startEditingRequestBody() {
    setState(() {
      if(_instanceRequestBody == null) {
        _instanceRequestBody = RequestBody.createRequestBodyByExample('{}');
        Example? example = _instanceRequestBody!.content.entries.first.value.example;
        String prettyJson = example != null ? JsonEncoder.withIndent('  ').convert(example) : '';
        _requestBodyController.text = prettyJson;
      }
      _isEditingRequestBody = true;
    });
  }

  void _saveEditingRequestBody() {
    if(_requestBodyController.text == '') {
      setState(() {
        selectedOperation!.requestBody = null;
        _instanceRequestBody = null;
        _isEditingRequestBody = false;
        _isModify = true;
      });
    } else {
      try {
        setState(() {
          _instanceRequestBody = RequestBody.createRequestBodyByExample(_requestBodyController.text);
          selectedOperation!.requestBody = _instanceRequestBody;
          _isEditingRequestBody = false;
          _isModify = true;
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid JSON Format'),
              content: Text('The JSON format you entered is invalid. Please correct it and try again.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _cancelEditingRequestBody() {
    setState(() {
      _instanceRequestBody = selectedOperation!.requestBody;
      _requestBodyController.text = _instanceRequestBody != null ? JsonEncoder.withIndent('  ').convert(_instanceRequestBody!.content.entries.first.value.example) : '';
      _isEditingRequestBody = false;
    });
  }

  Future<String?> _showInputDialog(BuildContext context) async {
    final TextEditingController textEditingController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Status Code'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: "Type Status Code"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // 다이얼로그 닫기, null 반환
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, textEditingController.text); // 입력된 문자열 반환
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addResponse() async {
    String? inputCode = await _showInputDialog(context);
    if(inputCode == null) {
      return;
    }

    if(selectedOperation!.responses.containsKey(inputCode)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Response Code Already Exists'),
            content: Text('The response code you entered already exists. Please enter a different response code.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    Response response = Response.createResponseByExample('{}');
    setState(() {
      selectedOperation!.responses[inputCode] = response;
      _responseController[inputCode] = TextEditingController();
      _responseController[inputCode]!.text = JsonEncoder.withIndent('  ').convert(response.content.entries.first.value.example);
      _isEditingResponse[inputCode] = false;
      _memorizedOriginalResponse[inputCode] = _responseController[inputCode]!.text;
      _isModify = true;
    });
  }

  void _startEditingResponse(String code) {
    setState(() {
      _isEditingResponse[code] = true;
    });
  }

  void _deleteResponse(String code) {
    setState(() {
      selectedOperation!.responses.remove(code);
      _responseController[code]!.dispose();
      _responseController.remove(code);
      _isEditingResponse.remove(code);
      _memorizedOriginalResponse.remove(code);
      _isModify = true;
    });
  }

  void _saveEditingResponse(String code) {
    try {
      setState(() {
        selectedOperation!.responses[code] = Response.createResponseByExample(_responseController[code]!.text);
        _memorizedOriginalResponse[code] = _responseController[code]!.text;
        _isEditingResponse[code] = false;
        _isModify = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid JSON Format'),
            content: Text('The JSON format you entered is invalid. Please correct it and try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _cancelEditingResponse(String code) {
    setState(() {
      _responseController[code]!.text = _memorizedOriginalResponse[code]!;
      _isEditingResponse[code] = false;
    });
  }

  Widget _buildParameterEditButton() {
    return Row(
      children: [
        TextButton(
          onPressed: () => _startEditingParameter(),
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => _addParameter(),
          child: Text(
            'Add',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildParameterSaveButton() {
    return TextButton(
      onPressed: () => _saveEditingParameter(),
      child: Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextButton.styleFrom(
        side: BorderSide(
            color: Colors.grey,
            width: 2
        ),
      ),
    );
  }

  Widget _buildRequestBodyEditButton() {
    return TextButton(
      onPressed: () => _startEditingRequestBody(),
      child: Text(
        'Edit',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextButton.styleFrom(
        side: BorderSide(
            color: Colors.grey,
            width: 2),
      ),
    );
  }

  Widget _buildRequestBodySaveCancelButton() {
    return Row(
      children: [
        TextButton(
          onPressed: () => _saveEditingRequestBody(),
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => _cancelEditingRequestBody(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponseAddButton() {
    return TextButton(
      onPressed: () async => await _addResponse(),
      child: const Text(
        'Add',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextButton.styleFrom(
        side: BorderSide(
            color: Colors.grey,
            width: 2),
      ),
    );
  }

  Widget _buildResponseEditButton(String code) {
    return Row(
      children: [
        TextButton(
          onPressed: () => _startEditingResponse(code),
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => _deleteResponse(code),
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildResponseSaveCancelButton(String code) {
    return Row(
      children: [
        TextButton(
          onPressed: () => _saveEditingResponse(code),
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2
            ),
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => _cancelEditingResponse(code),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            side: BorderSide(
                color: Colors.grey,
                width: 2
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleProjectTap(APISpec? project) async {
    final OpenAPISpec openAPISpec = await APIOpenAPISpec.getAPIObject(project!.projectId);
    setState(() {
      selectedProject = project;
      this.openAPISpec = openAPISpec;
      _urlController.text = openAPISpec.servers[0].url;
      selectedOperation = null;
      _isModify = false;
    });
  }

  void _initAPIControllers() {
    for(var controller in _parameterController) {
      controller.dispose();
    }
    _parameterController = [];
    for(var parameter in selectedOperation!.parameters!) {
      _parameterController.add(TextEditingController(text: parameter.name));
    }

    _instanceRequestBody = selectedOperation!.requestBody;
    if(_instanceRequestBody != null) {
      Example? example = _instanceRequestBody!.content.entries.first.value.example;
      String prettyJson = example != null ? JsonEncoder.withIndent('  ').convert(example) : '';
      _requestBodyController.text = prettyJson;
    } else {
      _requestBodyController.text = '';
    }
    _isEditingRequestBody = false;

    for(var controller in _responseController.values) {
      controller.dispose();
    }
    _responseController = {};
    if(selectedOperation != null) {
      for(var entry in selectedOperation!.responses.entries) {
        Example? example = entry.value.content.entries.first.value.example;
        String prettyJson = example != null ? JsonEncoder.withIndent('  ').convert(example) : '';

        _responseController[entry.key] = TextEditingController();
        _responseController[entry.key]!.text = prettyJson;
      }
    }

    _isEditingResponse = {};
    for(var key in _responseController.keys) {
      _isEditingResponse[key] = false;
    }
    _memorizedOriginalResponse = {};
  }

  void _handleapiguideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleapicodeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apicode()), // Deployment 페이지로 이동
    );
  }
}
