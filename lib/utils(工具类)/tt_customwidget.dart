import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/event(事件类)/event.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_common.dart';
import 'tt_common.dart';

/// 加载网络图片
Widget conFigNetWorkImage(
    String url, double width, double height, BorderRadius borderRadius) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder: (context, url) {
        return ProgressView();
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
      fadeOutDuration: const Duration(seconds: 1),
      fadeInDuration: const Duration(seconds: 1),
    ),
  );
}

/// 圆形进度条
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

/// 直线进度条
class TTProgressBar extends StatefulWidget {
  double progress;
  TTProgressBar({this.progress, Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TTProgressBarState();
  }
}

class TTProgressBarState extends State<TTProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: proGressBar(widget.progress, context));
  }

  Widget proGressBar(double progress, BuildContext context) {
    if (progress == 1.0) {
      return Container(height: 0);
    } else {
      return Container(
        child: LinearProgressIndicator(
            backgroundColor: ColorsMacro.col_CDA,
            value: progress == 1.0 ? 0 : progress,
            valueColor: ColorTween(begin: Colors.orange, end: Colors.red)
                .animate(_animationController)),
        height: 2,
      );
    }
  }
}

/// 请求失败界面
class TTNetWorkFailV extends StatelessWidget {
  final RequestStatus status;
  final GestureTapCallback onTap;
  const TTNetWorkFailV(this.status, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case RequestStatus.fail:
        break;
      default:
    }
  }

  Widget configFailV() {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Utils.getImagePath(ImageStringMacro.hotsStr),
                width: 100,
                height: 100,
              ),
              Gaps.vGap10,
              Text(
                '网络出问题了~ 请您查看网络设置',
                style: TextStyleMacro.titleNor163,
              ),
              Gaps.vGap5,
              Text(
                '点击屏幕,重新刷新',
                style: TextStyleMacro.titleNor163,
              )
            ],
          ),
        ),
      ),
    );
  }
}

///喜欢按钮
class LikeBtn extends StatelessWidget {
  const LikeBtn({Key key, this.labelId, this.id, this.isLike});
  final String labelId;
  final int id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Icon(
        Icons.favorite,
        color: (isLike == true) ? Colors.redAccent : ColorsMacro.col_999,
      ),
    );
  }
}

// 创建输入框
// ignore: must_be_immutable
class TextFiledWidget extends StatefulWidget {
  Function(String value) onChanged;

  Function() onTap;

  VoidCallback onEditingComplete;

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
      this.suffixIconData,
      this.onEditingComplete});

  @override
  State<StatefulWidget> createState() {
    return TextFiledWidgetState();
  }
}

class TextFiledWidgetState extends State<TextFiledWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // 实时输入回调
      onChanged: widget.onChanged,
      // 点击确定按钮回调
      onEditingComplete: () {
        SystemChannels.textInput.invokeMethod("TextInput.hide");
      },

      /// 点击输入框回调
      onTap: widget.onTap,

      /// 是否隐藏文本 用于密码
      obscureText: widget.obscureText,

      style: TextStyle(
        color: Colors.blue,
        fontSize: 14.0,
      ),
      // 输入框可用时的边框变化
      decoration: InputDecoration(
          // 填充一下
          filled: true,
          // 提示文本
          labelText: widget.labelText,
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
            widget.prefixIconData,
            size: 18,
            color: Colors.blue,
          ),
          // 输入文本后的图标
          suffixIcon: IconButton(
              icon: Icon(
                widget.suffixIconData,
                size: 18,
                color: Colors.blue,
              ),
              onPressed: () {
                widget.obscureText = !widget.obscureText;
                setState(() {});
              })),
    );
  }
}
