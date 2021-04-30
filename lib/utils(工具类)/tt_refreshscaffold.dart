import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:new_app/event(事件类)/event.dart';
import 'tt_customwidget.dart';

typedef OnLoadMore(bool up);
typedef OnRefreshCallback = Future<void> Function({bool isReload});

class TTRefreshScaffold extends StatefulWidget {
  const TTRefreshScaffold(
      {Key key,
      this.labelId,
      this.loadStatus,
      @required this.controller,
      this.enablePullDown: true,
      this.enablePullUp: true,
      this.onLoadMore,
      this.onRefresh,
      this.child,
      this.itemBuilder,
      this.itemCount});

  final String labelId;

  /// 滚动视图
  final RefreshController controller;

  /// 加载状态
  final RequestStatus loadStatus;

  /// 打开下啦刷新
  final bool enablePullDown;

  /// 打开上啦刷新
  final bool enablePullUp;

  /// 刷新回调
  final OnRefreshCallback onRefresh;
  final OnLoadMore onLoadMore;

  /// 子视图
  final Widget child;

  /// 列表
  final IndexedWidgetBuilder itemBuilder;

  /// 列表个数
  final int itemCount;

  @override
  State<StatefulWidget> createState() {
    return TTTrefreshScaffoldState();
  }
}

class TTTrefreshScaffoldState extends State<TTRefreshScaffold> {
  bool showToTopBtn = false;

  /*生命周期*/

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          conFigRefresher(),
        ],
      ),
      floatingActionButton: conFigFloatActionButton(),
    );
  }

  /*私有方法*/

  /// 创建刷新
  Widget conFigRefresher() {
    return SmartRefresher(
      controller: widget.controller,
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      header: WaterDropMaterialHeader(),
      child: widget.child ??
          ListView.builder(
              itemBuilder: widget.itemBuilder, itemCount: widget.itemCount),
      onRefresh: widget.onRefresh,
      onLoading: widget.onRefresh,
    );
  }

  /// 创建置顶按钮
  Widget conFigFloatActionButton() {
    if (showToTopBtn) {
      return FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.keyboard_arrow_up),
      );
    } else {
      return null;
    }
  }
}
