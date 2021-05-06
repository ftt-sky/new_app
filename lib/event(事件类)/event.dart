import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';

class StatusEvent {
  String labelId;

  RequestStatus status;

  int cid;

  /// 1 下拉刷新  2 上啦加载更多
  int loadStaus;

  int loadNum;

  StatusEvent(this.labelId, this.status, this.loadStaus,
      {this.cid, this.loadNum});
}

enum RequestStatus {
  /// 网络请求成功
  success,

  /// 网络请求失败
  fail,

  /// 网络请求列表是否有更多的数据
  noMore,

  /// 网络加载中
  loading,

  /// 数据不存在
  empty
}

class ComEvent {
  int id;
  Object data;

  ComEvent({
    this.id,
    this.data,
  });
}

class Event {
  static void sendAppComEvent(BuildContext context, ComEvent event) {
    // BlocProvider.of<ApplicationBloc>(context).sendAppComEvent(event);
  }

  static void sendAppEvent(BuildContext context, int id) {
    BlocProvider.of<ApplicationBloc>(context).sendAppEvent(id);
  }
}
