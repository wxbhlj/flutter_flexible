import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes/routeName.dart';
import '../../utils/index.dart';
import 'components/DyFormInput.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  /// 登录验证
  loginCaptcha() {
    if (userController.text.length > 6 && pwdController.text.length > 6) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.appHomePage,
        (router) {
          return false;
        },
      );
      return;
    }
    toastTips('验证失败，帐号或密码错误');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 260.h),
              child: Column(
                children: [
                  userInput(),
                  bottomBtn(),
                ],
              ),
            ),
            closeIcon(),
            registered(),
          ],
        ),
      ),
    );
  }

  /// 关闭icon组件
  Widget closeIcon() {
    return Positioned(
      top: 10.w,
      left: 15.w,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.close,
          size: 52.sp,
        ),
      ),
    );
  }

  /// 注册组件
  Widget registered() {
    return Positioned(
      top: 10.w,
      right: 20.w,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Text(
          '注册',
          style: TextStyle(fontSize: 36.sp),
        ),
      ),
    );
  }

  /// 帐号密码
  Widget userInput() {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 0, 35, 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, 1),
            offset: Offset(0, 10),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          DyInput(
            controller: userController,
            hintText: '请输入手机号',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // 0-9之间
              LengthLimitingTextInputFormatter(11),
            ],
            isNext: true,
          ),
          DyInput(
            controller: pwdController,
            hintText: '请输入密码',
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]')),
              LengthLimitingTextInputFormatter(8),
            ],
            isInputPwd: true,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget bottomBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loginBtn(),
      ],
    );
  }

  /// 登录按钮
  Widget loginBtn() {
    return InkWell(
      onTap: loginCaptcha,
      child: Container(
        alignment: Alignment.center,
        height: 100.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 158, 251, 1),
            Color.fromRGBO(143, 158, 251, .6),
          ]),
        ),
        child: Text(
          '登入',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 40.sp,
            letterSpacing: 12,
          ),
        ),
      ),
    );
  }
}
