import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/bloc_provider.dart';
import 'package:new_app/data(网络数据层)/data_index.dart';
import 'package:rxdart/rxdart.dart';
import 'package:new_app/current_index.dart';
import 'dart:collection';

class TabBloc implements BlocBase {
  BehaviorSubject<List<TreeModel>> _tabTree =
      BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _tabTreeSink => _tabTree.sink;

  Stream<List<TreeModel>> get tabTreeStream => _tabTree.stream;

  List<TreeModel> treeList;
  GoldResitory goldResitory = GoldResitory();

  @override
  Future getData({data, String labelId, int page}) {
    switch (labelId) {
      case CurrentIds.titleReposTree:
        return getProjectTree(labelId);
        break;
      case CurrentIds.titleWxArticleTree:
        return getWxArticleTree(labelId);
        break;
      case CurrentIds.titleSystemTree:
        return getSystemTree(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({data, String labeId, int cid}) {
    return null;
  }

  @override
  Future onRefresh({data, String labelId, int cid}) {
    return getData(labelId: labelId);
  }

  bindSystemData(TreeModel model) {
    if (model == null) {
      return;
    }
    treeList = model.children;
  }

  Future getProjectTree(String labelId) {
    return goldResitory.getProjectTree().then((list) {
      TTLog.d(list.length);
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }

  Future getWxArticleTree(String labelId) {
    return goldResitory.getWxArticleChapters().then((list) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }

  Future getSystemTree(String labelId) {
    return Future.delayed(new Duration(milliseconds: 500)).then((_) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    });
  }

  Future getTree(String labelId) {
    return goldResitory.getProjectTree().then((value) {
      if (treeList == null) {
        treeList = [];
      }
      treeList.clear();
      treeList.addAll(value);
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    }).catchError((_) {});
  }

  @override
  void dispose() {
    _tabTree.close();
  }
}
