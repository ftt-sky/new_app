import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/page_index.dart';

bool isEventsInit = true;

class EventsPage extends StatelessWidget {
  const EventsPage({Key key, this.labelId}) : super(key: key);
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

    if (isEventsInit) {
      isEventsInit = false;
      Future.delayed(Duration(microseconds: 500), () {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
        stream: bloc.eventsStream,
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
              bloc.onLoadMore(labeId: labelId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, index) {
              ReposModel model = snapshot.data[index];
              return ArticleItem(model);
            },
          );
        });
  }
}
