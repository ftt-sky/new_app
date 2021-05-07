import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_common.dart';

Color getRandomWhiteColor(Random random) {
  /// 透明度
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class UserLoginPage extends StatefulWidget {
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
  double _maxRadius = 50.0;
  // 设置最大的角度
  double _maxThte = 2 * pi;

  double _tfbottom = 88;

  // 来个动画控制器

  AnimationController _animationController;

  AnimationController _fadeAnimationController;

  // 初始化函数中创建气泡
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
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

    //创建动画控制器
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // 执行刷新监听
    //_animationController.addListener(() {
    //   setState(() {});
    // });

    _fadeAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
    // 执行刷新监听
    _fadeAnimationController.forward();

    _fadeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat();
      }
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          _tfbottom = 88;
        } else {
          _tfbottom = 180;
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

        buildBottomColumn()
      ]),
    );
  }

  /// 背景颜色
  buildBackgoround() {
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

  buildBobbleWidget(BuildContext context) {
    // 画板
    return CustomPaint(
      //
      size: MediaQuery.of(context).size,
      // 画布
      painter: CustomMyPainter(list: _list, random: _random),
    );
  }

  // 高斯模糊
  buildBlurWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(color: Colors.white.withOpacity(0.1)),
    );
  }

  // 创建标题
  buildTopTextWidget() {
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
  buildBottomColumn() {
    return Positioned(
        bottom: _tfbottom,
        left: 40,
        right: 40,
        child: FadeTransition(
            opacity: _fadeAnimationController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFiledWidget(
                  obscureText: false,
                  labelText: '账号',
                  prefixIconData: Icons.phone_android_outlined,
                ),
                Gaps.vGap10,
                TextFiledWidget(
                  obscureText: true,
                  labelText: '密码',
                  prefixIconData: Icons.lock_outline,
                  suffixIconData: Icons.visibility,
                ),
                Gaps.vGap10,
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '忘记密码',
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                      textAlign: TextAlign.end,
                    )),
                Gaps.vGap20,
                Container(
                  height: 44,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '登录',
                    ),
                  ),
                ),
                Gaps.vGap10,
                Container(
                  height: 44,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '注册',
                    ),
                  ),
                )
              ],
            )));
  }

  void phonechange(String value) {}
}

// ignore: must_be_immutable
class TextFiledWidget extends StatelessWidget {
  Function(String value) onChanged;

  Function() onTap;

  /// 是否隐藏文本
  bool obscureText;

  /// 提示文本
  String labelText;

  ///
  IconData prefixIconData;
  IconData suffixIconData;
  TextFiledWidget(
      {this.onChanged,
      this.onTap,
      this.obscureText,
      this.labelText,
      this.prefixIconData,
      this.suffixIconData});

  @override
  Widget build(BuildContext context) {
    return TextField(
      // 实时输入回调
      onChanged: onChanged,

      onEditingComplete: () {},

      /// 点击输入框回调
      onTap: onTap,

      /// 是否隐藏文本 用于密码
      obscureText: obscureText,

      style: TextStyle(
        color: Colors.blue,
        fontSize: 14.0,
      ),
      // 输入框可用时的边框变化
      decoration: InputDecoration(
          // 填充一下
          filled: true,
          // 提示文本
          labelText: labelText,
          // 去掉默认的下划线
          // 输入前的边线
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // 输入中的边线
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          // 输入框前的图标
          prefixIcon: Icon(
            prefixIconData,
            size: 18,
            color: Colors.blue,
          ),
          // 输入文本后的图标
          suffixIcon: Icon(
            suffixIconData,
            size: 18,
            color: Colors.blue,
          )),
    );
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
