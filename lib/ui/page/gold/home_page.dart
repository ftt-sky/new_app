import 'package:flutter/material.dart';
import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/bloc_provider.dart';
import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/main_bloc.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/data_index.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/protocol/gold_model.dart';
import 'package:new_app/res(%E8%B5%84%E6%BA%90%E6%96%87%E4%BB%B6)/strings.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_common.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_refreshscaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'gold_banner.dart';

bool isHomeInit = true;

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController(initialRefresh: false);
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      _controller.refreshCompleted();
    });

    if (isHomeInit) {
      isHomeInit = false;
      Future.delayed(Duration(microseconds: 500), () {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
        stream: bloc.bannerStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
          TTLog.d(snapshot);
          RequestStatus loadStatus =
              Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          return TTRefreshScaffold(
              controller: _controller,
              labelId: labelId,
              loadStatus: loadStatus,
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: ({isReload}) {
                return bloc.onRefresh(labelId: labelId);
              },
              child: ListView(
                children: [
                  buildBannerWidget(context, snapshot.data),
                  SizedBox(
                      height: 10, child: Container(color: ColorsMacro.col_F7F)),
                  StreamBuilder(
                      stream: bloc.recReposStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ReposModel>> snapshot) {
                        return createRepos(context, snapshot.data, 1);
                      }),
                  StreamBuilder(
                      stream: bloc.recWxArticleStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ReposModel>> snapshot) {
                        return createRepos(context, snapshot.data, 2);
                      }),
                ],
              ));
        });
  }

  /// 创建推荐文章
  Widget createRepos(BuildContext context, List<ReposModel> list, int type) {
    if (ObjectUtil.isEmpty(list) || list.length == 0) {
      return Container(
        color: Colors.red,
        height: 0,
      );
    }
    TTLog.d(list);
    List<Widget> _children = list.map((model) {
      return type == 1
          ? ReposItem(
              model,
              isHome: true,
            )
          : ArticleItem(model, isHome: true);
    }).toList();
    TTLog.d(_children.length);
    List<Widget> children = [];
    children.add(HeaderItem(
      margin: EdgeInsets.only(left: 0),
      title: type == 1 ? "推荐文章" : "公共号文章",
      leftIcon: Icons.book,
      titleId: CurrentIds.recRepos,
      onTap: () {
        RouteManager.pushTabPage(context,
            labelId: type == 1
                ? CurrentIds.titleReposTree
                : CurrentIds.titleWxArticleTree,
            titleId: type == 1
                ? CurrentIds.titleReposTree
                : CurrentIds.titleWxArticleTree,
            title: type == 1 ? "推荐文章" : "公共号文章");
      },
    ));
    children.addAll(_children);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
