import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/gold/setting_page.dart';
import 'collection_page.dart';

class GoldLeftPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoldLeftPageState();
  }
}

class GoldLeftPageState extends State<GoldLeftPage> {
  List<PageInfo> _pageInfo = [];
  PageInfo loginOut =
      PageInfo(CurrentIds.titleSignOut, Icons.power_settings_new, null);
  String _userName;

  @override
  void initState() {
    super.initState();
    _pageInfo.add(PageInfo(
        CurrentIds.titleCollection,
        Icons.collections,
        CollectionPage(
          labelId: CurrentIds.titleCollection,
        )));
    _pageInfo
        .add(PageInfo(CurrentIds.titleSetting, Icons.settings, SettingPage()));
  }

  _showLoginOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(
              '确定退出吗?',
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    IntlUtil.getString(ctx, CurrentIds.cancel),
                    style: TextStyleMacro.titleNor126,
                  )),
              TextButton(
                  onPressed: () {
                    Event.sendAppEvent(context, Constant.type_sys_update);
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  child: Text(
                    IntlUtil.getString(ctx, CurrentIds.confirm),
                    style: TextStyleMacro.titleNor129,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TTLog.d(ScreenUtil().statusBarHeight);
    if (Utils.isLogin()) {
      if (!_pageInfo.contains(loginOut)) {
        _pageInfo.add(loginOut);
        UserModel userModel = SpUtil.getObj(
            BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));
        _userName = userModel.username ?? "";
      }
    } else {
      _userName = "ftsky";
      if (_pageInfo.contains(loginOut)) {
        _pageInfo.remove(loginOut);
      }
    }
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 180,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight, left: 10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 64,
                      height: 64,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                            Utils.getImagePath(ImageStringMacro.userheader),
                          )))),
                  Text(
                    _userName,
                    style: TextStyle(
                        color: ColorsMacro.col_FFF,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Gaps.vGap5,
                  Text(
                    '个人简介',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimens.font_12),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    iconSize: 18,
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {}),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          child: Material(
            color: Colors.green[200],
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  '一切为了技术',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _pageInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  PageInfo pageInfo = _pageInfo[index];
                  return ListTile(
                    leading: Icon(pageInfo.iconData),
                    title: Text(IntlUtil.getString(context, pageInfo.titleId)),
                    onTap: () {
                      if (pageInfo.titleId == CurrentIds.titleSignOut) {
                        _showLoginOutDialog(context);
                      } else if (pageInfo.titleId ==
                          CurrentIds.titleCollection) {
                        RouteManager.pushcustonPage(
                            context,
                            BlocProvider<UserInfoBloc>(
                                child: pageInfo.page, bloc: UserInfoBloc()),
                            pageName: pageInfo.titleId,
                            needLogin: Utils.isNeedLogin(pageInfo.titleId));
                      } else {
                        RouteManager.pushcustonPage(context, pageInfo.page,
                            pageName: pageInfo.titleId,
                            needLogin: Utils.isNeedLogin(pageInfo.titleId));
                      }
                    },
                  );
                }))
      ],
    ));
  }
}

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);
  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}
