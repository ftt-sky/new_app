import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/data_index.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_common.dart';

Color getRandomWhiteColor(Random random) {
  /// 透明度
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

// ignore: must_be_immutable
class UserLoginPage extends StatefulWidget {
  // 1 登录 2注册 3 忘记密码
  int type = 1;
  UserLoginPage({this.type, Key key}) : super(key: key);
  @override
  createState() {
    return UserLoginPageState();
  }
}

class UserLoginPageState extends State<UserLoginPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // 创建一个集合用来保存气泡
  List<BobbleBean> _list = [];

  // 随机数
  Random _random = Random(DateTime.now().microsecondsSinceEpoch);
  // 运动速度控制
  double _maxSpeed = 2.0;
  // 设置最大的半径
  double _maxRadius = 100.0;
  // 设置最大的角度
  double _maxThte = 2 * pi;

  double _tfbottom = 88;
  // 用户名
  String _name;

  /// 密码
  String _password;
  // 确认密码
  String _repassword;
  // 来个动画控制器

  AnimationController _animationController;

  AnimationController _fadeAnimationController;

  UserInfoRepository userInfoRepository = UserInfoRepository();
  UserModel userModel =
      SpUtil.getObj(BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));

  // 初始化函数中创建气泡
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 20; i++) {
      BobbleBean bean = BobbleBean();
      // 获取随机透明度白色
      bean.color = getRandomWhiteColor(_random);

      bean.postion = Offset(-1, -1);
      // 随机速度
      bean.speed = _random.nextDouble() * _maxSpeed;
      // 随机半径
      bean.radius = _random.nextDouble() * _maxRadius;
      // 随机角度
      bean.theta = _random.nextDouble() * _maxThte;

      _list.add(bean);
    }

    // //创建动画控制器
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1000));
    // // 执行刷新监听
    // _animationController.addListener(() {
    //   setState(() {});
    // });

    // _fadeAnimationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1800));
    // // 执行刷新监听
    // _fadeAnimationController.forward();

    // _fadeAnimationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _animationController.repeat();
    //   }
    // });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        double bottom = MediaQuery.of(context).viewInsets.bottom;
        if (bottom == 0) {
          _tfbottom = 88;
        } else {
          _tfbottom = bottom;
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fadeAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        /// 背景颜色
        buildBackgoround(),

        /// 气泡
        buildBobbleWidget(context),
        // 高斯模糊

        buildBlurWidget(),

        // 顶部的文本
        buildTopTextWidget(),

        // 输入区域

        buildBottomColumn(),
        // 创建返回按钮
        buildBackBtn()
      ]),
    );
  }

  Widget buildBackBtn() {
    return Positioned(
        left: 10, top: ScreenUtil().statusBarHeight, child: BackButton());
  }

  /// 背景颜色
  Widget buildBackgoround() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightBlueAccent.withOpacity(0.3),
            Colors.lightBlue.withOpacity(0.3),
            Colors.blue.withOpacity(0.3)
          ])),
    );
  }

  Widget buildBobbleWidget(BuildContext context) {
    // 画板
    return CustomPaint(
      //
      size: MediaQuery.of(context).size,
      // 画布
      painter: CustomMyPainter(list: _list, random: _random),
    );
  }

  // 高斯模糊
  Widget buildBlurWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(color: Colors.white.withOpacity(0.1)),
    );
  }

  // 创建标题
  Widget buildTopTextWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: 150,
        child: Text(
          'TT Sky',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 44, color: Colors.deepPurple),
        ));
  }

  // 创建输入内容
  Widget buildBottomColumn() {
    return Positioned(
        bottom: _tfbottom,
        left: 40,
        right: 40,
        // child: FadeTransition(
        //     opacity: _fadeAnimationController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFiledWidget(
              obscureText: false,
              labelText: '账号',
              prefixIconData: Icons.phone_android_outlined,
              onChanged: (value) {
                TTLog.d('账号 $value');
                _name = value;
              },
            ),
            Gaps.vGap10,
            TextFiledWidget(
              obscureText: true,
              labelText: '密码',
              prefixIconData: Icons.lock_outline,
              suffixIconData: Icons.visibility,
              onChanged: (value) {
                TTLog.d('密码$value');
                _password = value;
              },
            ),
            Gaps.vGap10,
            widget.type != 1
                ? TextFiledWidget(
                    obscureText: true,
                    labelText: '确认密码',
                    prefixIconData: Icons.lock_outline,
                    suffixIconData: Icons.visibility,
                    onChanged: (value) {
                      TTLog.d('密码$value');
                      _repassword = value;
                    },
                  )
                : Container(),
            Gaps.vGap10,
            widget.type == 1
                ? Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '忘记密码',
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                      textAlign: TextAlign.end,
                    ))
                : Container(),
            Gaps.vGap20,
            widget.type == 1
                ? Container(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ontapLogin();
                      },
                      child: Text(
                        '登录',
                      ),
                    ),
                  )
                : Container(),
            Gaps.vGap10,
            Container(
              height: 44,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ontapRegisterPage();
                },
                child: Text(
                  widget.type == 3 ? '登录' : '注册',
                ),
              ),
            )
          ],
        ));
    //);
  }

  // 点击登录
  ontapLogin() {
    configinfoisEmpty();

    LoginReq req = LoginReq(_name, _password);
    userInfoRepository
        .login(req)
        .then((UserModel model) {})
        .catchError((error) {
      Utils.showSnackbar(context, error.toString());
    });
  }

  configinfoisEmpty() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    if (ObjectUtil.isEmpty(_name)) {
      Utils.showSnackbar(context, '请输入用户名~');
      return;
    }
    if (ObjectUtil.isEmpty(_password)) {
      Utils.showSnackbar(context, '请输入密码~');
      return;
    }

    if (widget.type != 1) {
      if (ObjectUtil.isEmpty(_repassword)) {
        Utils.showSnackbar(context, '请输入确认密码~');
        return;
      }
    }
  }

  // 点击注册
  ontapRegisterPage() {
    if (widget.type == 1) {
      RouteManager.pushcustonPage(context, UserLoginPage(type: 2));
    } else if (widget.type == 2) {
      configinfoisEmpty();
      userRegister();
    } else {}
  }

  /// 注册网络请求
  userRegister() {
    RegisterReq req = RegisterReq(_name, _password, _repassword);
    userInfoRepository.register(req).then((UserModel model) {
      gotoMainPage('注册成功~');
    });
  }

  // 注册 登录 成功 跳转到首页
  gotoMainPage(String msg) {
    Utils.showSnackbar(context, msg);
    Future.delayed(Duration(microseconds: 500), () {
      Event.sendAppEvent(context, Constant.type_refresh_all);
      RouteManager.goMain(context);
    });
  }
}

class CustomMyPainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;

  CustomMyPainter({this.list, this.random});

  Paint _paint = Paint()..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
    // 在绘制前重新计算每个点的位置
    list.forEach((element) {
      // 根据点的速度 与 角度 来计算每次的偏移后的新的坐标中心
      Offset newCenterOffset = calculateXY(element.speed, element.theta);
      double dx = newCenterOffset.dx + element.postion.dx;
      double dy = newCenterOffset.dy + element.postion.dy;

      // 完全计算边界
      if (dx < 0 || dx > size.width) {
        dx = random.nextDouble() * size.width;
      }

      if (dy < 0 || dy > size.height) {
        dy = random.nextDouble() * size.height;
      }

      element.postion = Offset(dx, dy);

      // 绘制

      list.forEach((element) {
        // 修改画笔的颜色
        _paint.color = element.color;
        // 绘制圆
        canvas.drawCircle(element.postion, element.radius, _paint);
      });
    });
  }

  // 刷新 控制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 返回false 不刷新
    return true;
  }

  Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }
}

/// 定义气泡
class BobbleBean {
  /// 位置
  Offset postion;

  /// 颜色
  Color color;

  // 运动的速度
  double speed;

  // 半径
  double radius;
  // 角度
  double theta;
}
