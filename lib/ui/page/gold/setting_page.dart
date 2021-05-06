import 'package:flutter/material.dart';
import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/blocs_index.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/models(%E5%AE%9E%E4%BD%93%E7%B1%BB)/currentModel.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel =
        SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, CurrentIds.titleSetting)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Row(
              children: [
                Icon(
                  Icons.color_lens,
                  color: ColorsMacro.col_666,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child:
                      Text(IntlUtil.getString(context, CurrentIds.titleTheme)),
                )
              ],
            ),
            children: [
              Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color value = themeColorMap[key];
                  return InkWell(
                    onTap: () {
                      SpUtil.putString(Constant.key_theme_color, key);
                      bloc.sendAppEvent(Constant.type_sys_update);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: 36,
                      height: 36,
                      color: value,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.language,
                  color: ColorsMacro.col_666,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                        IntlUtil.getString(context, CurrentIds.titleLanguage)))
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  languageModel == null
                      ? IntlUtil.getString(context, CurrentIds.languageAuto)
                      : IntlUtil.getString(context, languageModel.titleId,
                          languageCode: 'zh', countryCode: 'CH'),
                  style: TextStyle(fontSize: 14, color: ColorsMacro.col_999),
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
