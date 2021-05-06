import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/gold/gold_banner.dart';

class ComListPage extends StatefulWidget {
  final String labelId;
  final int cid;
  ComListPage({Key key, this.labelId, this.cid}) : super(key: key);
  final RefreshController controller = RefreshController();
  @override
  State<StatefulWidget> createState() {
    return ComListPageState();
  }
}

class ComListPageState extends State<ComListPage> {
  @override
  Widget build(BuildContext context) {
    // RefreshController controller = RefreshController();
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) {
      if (widget.cid == event.cid) {
        TTLog.d("我真的想看啊看  你回来这里");
        configEndRefresh(event.loadStaus);
      }
    });
    return StreamBuilder(
        stream: bloc.comListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          RequestStatus loadStatus =
              Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == RequestStatus.loading) {
            bloc.onRefresh(labelId: widget.labelId, cid: widget.cid);
          }
          return TTRefreshScaffold(
            controller: widget.controller,
            labelId: widget.cid.toString(),
            loadStatus: loadStatus,
            onRefresh: ({isReload}) {
              return bloc.onRefresh(labelId: widget.labelId, cid: widget.cid);
            },
            onLoadMore: () {
              TTLog.d('上啦刷新吗');
              bloc.onLoadMore(labeId: widget.labelId, cid: widget.cid);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ReposModel model = snapshot.data[index];
              return widget.labelId == CurrentIds.titleReposTree
                  ? ReposItem(model)
                  : ArticleItem(model);
            },
          );
        });
  }

  /// 结束刷新
  void configEndRefresh(int type) {
    TTLog.d(type);
    if (type == 1) {
      widget.controller.refreshCompleted();
    } else {
      widget.controller.loadComplete();
    }
  }
}
