import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'tree_item.dart';

bool isSystemInit = true;

class SystemPage extends StatelessWidget {
  const SystemPage({Key key, this.labelId}) : super(key: key);
  final String labelId;
  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);

    if (isSystemInit) {
      isSystemInit = false;
      Future.delayed(Duration(microseconds: 500), () {
        bloc.onRefresh(labelId: labelId);
      });
    }

    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        if (event.loadStaus == 1) {
          _controller.refreshCompleted();
        } else {
          _controller.loadComplete();
        }
      }
    });

    return StreamBuilder(
      stream: bloc.treeStream,
      builder: (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
        return TTRefreshScaffold(
          controller: _controller,
          labelId: labelId,
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          enablePullUp: false,
          onRefresh: ({isReload}) {
            return bloc.onRefresh(labelId: labelId, isReload: isReload);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (context, index) {
            TreeModel model = snapshot.data[index];
            return TreeItem(model);
          },
        );
      },
    );
  }
}
