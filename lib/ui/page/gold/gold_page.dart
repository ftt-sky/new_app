import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';
import 'com_list_page.dart';

class TabPage extends StatefulWidget {
  const TabPage(
      {Key key, this.labelId, this.title, this.titleId, this.treeModel})
      : super(key: key);
  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;
  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }
}

class TabPageState extends State<TabPage> {
  List<BlocProvider<ComListBloc>> _children = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TabBloc bloc = BlocProvider.of<TabBloc>(context);
    bloc.bindSystemData(widget.treeModel);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title ?? ""),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.tabTreeStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          if (snapshot.data == null) {
            bloc.getData(labelId: widget.labelId);
            return ProgressView();
          }
          _children = snapshot.data
              .map((TreeModel model) {
                return BlocProvider<ComListBloc>(
                  child: ComListPage(
                    labelId: widget.labelId,
                    cid: model.id,
                  ),
                  bloc: ComListBloc(),
                );
              })
              .cast<BlocProvider<ComListBloc>>()
              .toList();
          return new DefaultTabController(
              length: snapshot.data == null ? 0 : snapshot.data.length,
              child: new Column(children: <Widget>[
                new Material(
                  color: Theme.of(context).primaryColor,
                  //elevation: 4.0,
                  child: new SizedBox(
                    height: 48.0,
                    width: double.infinity,
                    child: new TabBar(
                      isScrollable: true,
                      //labelPadding: EdgeInsets.all(12.0),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: snapshot.data
                          ?.map((TreeModel model) => new Tab(text: model.name))
                          ?.toList(),
                    ),
                  ),
                ),
                new Expanded(child: new TabBarView(children: _children))
              ]));
        },
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0, length = _children.length; i < length; i++) {
      _children[i].bloc.dispose();
    }
    super.dispose();
  }
}
