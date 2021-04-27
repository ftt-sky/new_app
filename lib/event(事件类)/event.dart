class StatusEvent {
  String labelId;

  RequestStatus status;

  int cid;

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
  loading
}
