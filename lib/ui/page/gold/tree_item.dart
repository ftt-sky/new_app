import 'package:flutter/material.dart';
import 'package:new_app/current_index.dart';

class TreeItem extends StatelessWidget {
  const TreeItem(this.model, {Key key}) : super(key: key);
  final TreeModel model;

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = model.children.map<Widget>((TreeModel _model) {
      return Chip(
        label: Text(
          _model.name,
          style: TextStyle(fontSize: 14.0),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        key: ValueKey<String>(_model.name),
        backgroundColor: Utils.getChipBgColor(_model.name),
      );
    }).toList();

    return InkWell(
      onTap: () {
        RouteManager.pushTabPage(context,
            labelId: CurrentIds.titleSystemTree,
            title: model.name,
            treeModel: model);
      },
      child: _ChipsTile(
        label: model.name,
        children: chips,
      ),
    );
  }
}

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      Text(
        label,
        style: TextStyleMacro.titleBloD163,
      ),
      Gaps.vGap10,
    ];
    cardChildren.add(Wrap(
        children: children.map((Widget chip) {
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: chip,
      );
    }).toList()));

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 0.33, color: ColorsMacro.col_E5E))),
    );
  }
}
