import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:new_app/data(网络数据层)/data_index.dart';
import 'package:new_app/res(%E8%B5%84%E6%BA%90%E6%96%87%E4%BB%B6)/strings.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_common.dart';
import 'package:new_app/current_index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:new_app/utils(%E5%B7%A5%E5%85%B7%E7%B1%BB)/tt_customwidget.dart';

Widget configBanner(BuildContext context, List<BannerModel> list) {
  TTLog.d(list);
  return SliverToBoxAdapter(
    child: buildBannerWidget(context, list),
  );
}

Widget buildBannerWidget(BuildContext context, List<BannerModel> list) {
  final double w = SizeMacro().screenWidth;
  final double h = SizeMacro().screenWidth / 16 * 7;
  if (ObjectUtil.isEmpty(list)) {
    return Container(height: 0.0);
  }

  return Container(
    width: w,
    height: h,
    padding: EdgeInsets.only(top: 10),
    child: Swiper(
      itemCount: list.length,
      autoplay: true,
      viewportFraction: 0.9,
      scale: 0.95,
      pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.white.withOpacity(0.5),
            activeColor: Colors.white,
          ),
          margin: EdgeInsets.all(SizeMacro().setWidth(10))),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            RouteManager.pushWeb(context,
                title: list[index].title, url: list[index].url);
          },
          child: conFigNetWorkImage(
              list[index].imagePath, w, h, BorderRadius.circular(10)),
        );
      },
    ),
  );
}

/// 创建文章通用布局
Widget buildRepoTitleWidget(
    BuildContext context, ReposModel model, String labelId) {
  return Expanded(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        model.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyleMacro.titleBloD163,
      ),
      Gaps.vGap10,
      Expanded(
          flex: 1,
          child: Text(
            model.desc,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyleMacro.titleNor146,
          )),
      Gaps.vGap5,
      Row(
        children: [
          LikeBtn(
            labelId: labelId,
            id: model.originId ?? model.id,
            isLike: model.collect,
          ),
          Gaps.hGap10,
          Text(
            model.author,
            style: TextStyleMacro.titleNor126,
          ),
          Gaps.hGap10,
          Text(
            Utils.getTimeLine(context, model.publishTime),
            style: TextStyleMacro.titleNor126,
          )
        ],
      )
    ],
  ));
}

class ReposItem extends StatelessWidget {
  const ReposItem(this.model, {this.labelId, Key key, this.isHome})
      : super(key: key);
  final ReposModel model;
  final bool isHome;
  final String labelId;

  @override
  Widget build(BuildContext context) {
    return createBody(context);
  }

  Widget createBody(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteManager.pushWeb(context,
            title: model.title, url: model.link, isHome: isHome);
      },
      child: Container(
        height: 160,
        color: Colors.red,
        padding: EdgeInsets.only(left: 15, top: 10, right: 15),
        child: createItems(context),
      ),
    );
  }

  Widget createItems(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorsMacro.col_FFF, ColorsMacro.col_F6F]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: ColorsMacro.col_EEE,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        child: Row(
          children: [
            buildRepoTitleWidget(context, model, labelId),
            Container(
              width: 72,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: ColorsMacro.col_333,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
              child: conFigNetWorkImage(model.envelopePic, 72, 128,
                  BorderRadius.all(Radius.circular(4.0))),
            )
          ],
        ));
  }
}

class HeaderItem extends StatelessWidget {
  const HeaderItem(
      {this.margin,
      this.titleColor,
      this.leftIcon,
      this.titleId: CurrentIds.titleRepos,
      this.title,
      this.extraId: CurrentIds.more,
      this.extra,
      this.rightIcon,
      this.onTap,
      Key key})
      : super(key: key);

  final EdgeInsetsGeometry margin;
  final Color titleColor;
  final IconData leftIcon;
  final String titleId;
  final String title;
  final String extraId;
  final String extra;
  final IconData rightIcon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: margin ?? EdgeInsets.only(top: 0.0),
      child: ListTile(
        onTap: onTap,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              leftIcon ?? Icons.whatshot,
              color: titleColor ?? Colors.blueAccent,
            ),
            Gaps.hGap10,
            Expanded(
                child: Text(
              title ?? IntlUtil.getString(context, titleId),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: titleColor ?? Colors.blueAccent,
                  fontSize: Utils.getTitleFontSize(
                      title ?? IntlUtil.getString(context, titleId))),
            ))
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              extra ?? IntlUtil.getString(context, extraId),
              style: TextStyleMacro.titleNor146,
            ),
            Icon(
              rightIcon ?? Icons.keyboard_arrow_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.33, color: ColorsMacro.col_666))),
    );
  }
}

class ArticleItem extends StatelessWidget {
  const ArticleItem(this.model, {Key key, this.labelId, this.isHome})
      : super(key: key);
  final ReposModel model;
  final String labelId;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 10),
        child: Row(
          children: [
            new Expanded(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  model.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleMacro.titleBloD163,
                ),
                Gaps.vGap10,
                new Text(
                  model.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleMacro.titleNor146,
                ),
                Gaps.vGap5,
                Row(
                  children: [
                    LikeBtn(
                      labelId: labelId,
                      id: model.originId ?? model.id,
                      isLike: model.collect,
                    ),
                    Gaps.hGap10,
                    Text(
                      model.author,
                      style: TextStyleMacro.titleNor126,
                    ),
                    Gaps.hGap10,
                    Text(
                      Utils.getTimeLine(context, model.publishTime),
                      style: TextStyleMacro.titleNor126,
                    )
                  ],
                )
              ],
            )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 12),
              child: CircleAvatar(
                radius: 28,
                backgroundColor:
                    Utils.getCircleAvatarBg(model.superChapterName ?? "公共号"),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    model.superChapterName ?? "文章",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.33, color: ColorsMacro.col_E5E)),
      ),
    );
  }
}
