import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/ui/page/page_index.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key key, this.labelId}) : super(key: key);
  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    UserInfoBloc bloc = BlocProvider.of<UserInfoBloc>(context);
    MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    mainBloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        if (event.loadStaus == 1) {
          _controller.refreshCompleted();
        } else {
          _controller.loadComplete();
        }
      }
    });

    bloc.setHomeEventSink(mainBloc.homeEventSink);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(IntlUtil.getString(context, labelId)),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.collectListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          RequestStatus loadStatus =
              Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == RequestStatus.loading) {
            bloc.onRefresh(labelId: labelId);
          }

          return TTRefreshScaffold(
            controller: _controller,
            labelId: labelId,
            onRefresh: ({isReload}) {
              return bloc.onRefresh(labelId: labelId, isReload: isReload);
            },
            onLoadMore: () {
              bloc.onLoadMore(labelId: labelId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, index) {
              ReposModel model = snapshot.data[index];
              return ObjectUtil.isEmpty(model.envelopePic)
                  ? ArticleItem(model, labelId: labelId)
                  : ReposItem(model, labelId: labelId);
            },
          );
        },
      ),
    );
  }
}
