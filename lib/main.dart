import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:new_app/blocs(bloc%E7%9B%B8%E5%85%B3)/bloc_provider.dart';
import 'package:new_app/current_index.dart';
import 'package:new_app/data(%E7%BD%91%E7%BB%9C%E6%95%B0%E6%8D%AE%E5%B1%82)/data_index.dart';
import 'package:new_app/ui/page/page_index.dart';
import 'package:new_app/ui/rootpage/splash_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'res(资源文件)/res_index.dart';
import 'models(实体类)/currentModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Global.init(() {
    runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider(child: MyApp(), bloc: MainBloc()),
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = ColorsMacro.col_666;

  @override
  void initState() {
    super.initState();
    setInitDir(initAppDocDir: true);
    setLocalizedSimpleValues(localizedSimpleValues);
    init();
  }

  init() {
    _init();
    _initListener();
    loadLocale();
  }

  _init() {
    BaseOptions baseOptions = TTNetWorkingManager.getDefOptions();
    baseOptions.baseUrl = Constant.setverAddress;
    HttpConfig config = HttpConfig(options: baseOptions);
    TTNetWorkingManager().setConfig(config);
  }

  loadLocale() {
    setState(() {
      LanguageModel model =
          SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));

      if (model != null) {
        _locale = Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
    });
  }

  _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((event) {
      loadLocale();
    });
  }

  Widget createMaterpp() {
    return MaterialApp(
        routes: {
          StringSMacro.GoldStr: (ctx) => GoldPage(),
        },
        locale: _locale,
        localizationsDelegates: [
          CustomLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],

        /// 设置支持本地化语言集合
        supportedLocales: CustomLocalizations.supportedLocales,
        title: "APP",
        debugShowCheckedModeBanner: true,
        color: Colors.black,
        theme: ThemeData(
            accentColor: Colors.white,
            accentTextTheme:
                TextTheme(bodyText1: TextStyle(color: Colors.amber))),
        home: GoldPage());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => createMaterpp(),
      designSize: Size(360, 690),
    );
  }
}
