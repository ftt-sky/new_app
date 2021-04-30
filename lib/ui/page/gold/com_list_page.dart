import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/gold/gold_banner.dart';

class ComListPage extends StatelessWidget {
  final String labelId;
  final int cid;
  const ComListPage({Key key, this.labelId, this.cid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController controller = RefreshController();
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) {
      if (cid == event.cid) {
        controller.loadComplete();
      }
    });

    return StreamBuilder(
        stream: bloc.comListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          RequestStatus loadStatus =
              Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == RequestStatus.loading) {
            bloc.onRefresh(labelId: labelId, cid: cid);
          }
          return TTRefreshScaffold(
            controller: controller,
            labelId: cid.toString(),
            loadStatus: loadStatus,
            onRefresh: ({isReload}) {
              return bloc.onRefresh(labelId: labelId, cid: cid);
            },
            onLoadMore: (up) {
              bloc.onLoadMore(labeId: labelId, cid: cid);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ReposModel model = snapshot.data[index];
              return labelId == CurrentIds.titleReposTree
                  ? ReposItem(model)
                  : ArticleItem(model);
            },
          );
        });
  }
}
