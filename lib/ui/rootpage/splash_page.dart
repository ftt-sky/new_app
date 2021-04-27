import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/models(实体类)/currentModel.dart';
import 'package:new_app/data(网络数据层)/repository/current_repository.dart';

class SlashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SlashPageState();
  }
}

class SlashPageState extends State<SlashPage> {
  /// 属性

  /// 本地引导页图片字符串数组
  List _guideList = [];

  /// 引导页视图数组
  List _bannerList = [];

  /// 倒计时
  TimerUtil _timerUtil;

  // 区分当前引导页 状态
  int _status = 0;

  /// 倒计时
  int _count = 3;

  /// 广告模型
  SplashAdModel _spAdModel;

  /// 生命周期
  ///
  ///

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          initSplashBg(),
          initGuidePage(),
          initAdWidget(),
          initCountDown()
        ],
      ),
    );
  }

  /// 协议回调
  ///
  ///

  /// 网络请求
  ///
  ///

  /// 获取广告信息
  loadAdinfo() {
    _spAdModel = SpUtil.getObj(
        StringSMacro.SplashAdModel, (v) => SplashAdModel.fromJson(v));

    if (_spAdModel != null) {
      setState(() {});
    }

    CurrentRepository().getSplashAdInfo().then((model) {
      if (_spAdModel == null || (_spAdModel.imgUrl != model.imgUrl)) {
        SpUtil.putObject(StringSMacro.SplashAdModel, model);
        setState(() {
          _spAdModel = model;
        });
      } else {
        SpUtil.putObject(StringSMacro.SplashAdModel, null);
      }
    });
  }

  /// 界面跳转
  ///
  ///

  /// 触发方法
  ///
  ///

  _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  _initBannerData() {
    for (var i = 0, length = _guideList.length; i < _guideList.length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: [
            InkWell(
              onTap: goMian(),
              child: Image.asset(
                _guideList[i],
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  /// 触发创建广告页
  _initSplash() {
    if (_spAdModel == null) {
      goMian();
    } else {
      _doCountDown();
    }
  }

  /// 广告倒计时
  _doCountDown() {
    setState(() {
      _status = 1;
    });

    _timerUtil = TimerUtil(mTotalTime: 4 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (tick == 0) {
        goMian();
      }
    });
    _timerUtil.startCountDown();
  }

  goMian() {
    SpUtil.putBool(StringSMacro.SoilStr, false);
    RouteManager.goMain(context);
  }

  /// 公开方法
  ///
  ///

  /// 私有方法
  ///
  ///

  /// 初始化 判断
  _init() {
    loadAdinfo();
    Future.delayed(Duration(microseconds: 500), () {
      if (SpUtil.getBool(StringSMacro.SplashAdModel, defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        ObjectUtil.isNotEmpty(_guideList);
        SpUtil.putBool(StringSMacro.SplashAdModel, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  /// 创建引导页默认背景图
  Widget initSplashBg() {
    return Offstage(offstage: !(_status == 0), child: initNormallaunchImage());
  }

  /// 创建默认背景图
  Widget initNormallaunchImage() {
    return Image.asset(
      ImageStringMacro.LaunchimageStr,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  /// 创建引导页轮播图
  Widget initGuidePage() {
    return Offstage(
      offstage: !(_status == 2),
      child: ObjectUtil.isEmpty(_bannerList)
          ? Container()
          : Swiper(
              itemCount: _bannerList.length,
              autoplay: false,
              loop: false,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white.withOpacity(0.5),
                      activeColor: Colors.white),
                  margin: EdgeInsets.only(bottom: 100)),
              itemBuilder: (BuildContext context, int index) {
                return _bannerList[index];
              },
            ),
    );
  }

  /// 创建广告页
  Widget initAdWidget() {
    if (_spAdModel == null) {
      return Container(
        height: 0.0,
      );
    }

    return Offstage(
      offstage: !(_status == 1),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: _spAdModel.imgUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => initNormallaunchImage(),
            errorWidget: (context, url, error) => initNormallaunchImage(),
          ),
        ),
      ),
    );
  }

  /// 创建倒计时展示page
  Widget initCountDown() {
    return Offstage(
      offstage: !(_status == 1),
      child: Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 44, right: 20),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Text(
              '$_count',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: ColorsMacro.col_333,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(width: 0.33, color: ColorsMacro.col_E5E)),
          ),
        ),
      ),
    );
  }
}
