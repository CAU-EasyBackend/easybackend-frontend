import 'package:flutter/material.dart';
import 'mainpage/ApiPage.dart';
import 'mainpage/Deployment.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key});

  @override
  State<loginpage> createState() => _SecondPageState();
}

class _SecondPageState extends State<loginpage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _loggedIn = false;

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
      body: _loggedIn
          ? _buildLoggedInWidget()
          : _buildLoginForm(),
    );
  }

  Widget _buildLoggedInWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You are logged in!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _loggedIn = false;
              });
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(
        'asset/image/github1.png',
        width: 200,
        height: 100,
      ),
       Container(
        width: 300,
        height: 370,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  // 이 부분에서 사용자 인증 및 세션 생성을 수행합니다.
                  if (_usernameController.text == 'admin' &&
                      _passwordController.text == 'password') {
                    setState(() {
                      _loggedIn = true;
                    });
                  } else {
                    // 로그인 실패 처리
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Login Failed'),
                          content: Text('Invalid username or password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text('Login', style: TextStyle(
                    color: Colors.black ,

                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ]
    ),
    );
  }

  void _handleAPIButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
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
}
