import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/page_index.dart';

bool isReposInit = true;

class ReposPage extends StatelessWidget {
  const ReposPage({Key key, this.labelId}) : super(key: key);
  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        if (event.loadStaus == 1) {
          _controller.refreshCompleted();
        } else {
          _controller.loadComplete();
        }
      }
    });

    if (isReposInit) {
      isReposInit = false;
      Future.delayed(Duration(microseconds: 500), () {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return StreamBuilder(
      stream: bloc.recReposStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
        return TTRefreshScaffold(
          controller: _controller,
          labelId: labelId,
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          onRefresh: ({isReload}) {
            return bloc.onRefresh(labelId: labelId, isReload: isReload);
          },
          onLoadMore: () {
            TTLog.d(bloc);
            TTLog.d(labelId);
            bloc.onLoadMore(labeId: labelId);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (context, index) {
            ReposModel model = snapshot.data[index];
            return ReposItem(model);
          },
        );
      },
    );
  }
}
