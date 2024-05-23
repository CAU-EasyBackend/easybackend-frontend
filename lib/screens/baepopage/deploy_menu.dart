import 'package:easyback/screens/baepopage/Deployment.dart';
import 'package:easyback/screens/baepopage/baepo.dart';
import 'package:easyback/screens/baepopage/sangtae.dart';
import 'package:flutter/material.dart';

enum CurrentPage {
  deploymentGuide,
  deployServer,
  statusManagement,
}

class DeployMenu extends StatelessWidget {
  final CurrentPage currentPage;
  Color defaultButtonColor = Colors.black;
  Color selectedButtonColor = Colors.white12;

  DeployMenu({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildButton(context, '배포 가이드', _handleDeploymentGuideButton,
              isSelected: currentPage == CurrentPage.deploymentGuide
          ),
          SizedBox(height: 0),
          _buildButton(context, '서버 배포', _handleFileUploadButton,
              isSelected: currentPage == CurrentPage.deployServer
          ),
          SizedBox(height: 0),
          _buildButton(context, '배포 상태 관리', _handleSangtaeButton,
              isSelected: currentPage == CurrentPage.statusManagement
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function(BuildContext) onPressed, {bool isSelected = false}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isSelected ? selectedButtonColor : defaultButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(text),
      ),
    );
  }

  void _handleDeploymentGuideButton(BuildContext context) {
    if(currentPage != CurrentPage.deploymentGuide) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Deployment()),
      );
    }
  }

  void _handleFileUploadButton(BuildContext context) {
    if(currentPage != CurrentPage.deployServer) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Baepo()),
      );
    }
  }

  void _handleSangtaeButton(BuildContext context) {
    if(currentPage != CurrentPage.statusManagement) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sangtae()),
      );
    }
  }
}
