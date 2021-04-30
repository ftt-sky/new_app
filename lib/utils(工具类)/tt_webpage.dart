import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:new_app/current_index.dart';
import 'tt_customwidget.dart';

class TTWebViewPlugin extends StatefulWidget {
  final String title;
  final String url;

  TTWebViewPlugin({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TTWebViewPluginState();
  }
}

class TTWebViewPluginState extends State<TTWebViewPlugin> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  double linProgress = 0.0;

  /*生命周期*/

  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onProgressChanged.listen((event) {
      setState(() {
        linProgress = event;
      });
    });
  }

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: seTitle(),
      url: widget.url,
      mediaPlaybackRequiresUserGesture: false,
      withZoom: false,
      withLocalStorage: true,
      hidden: true,
    );
  }

  /*触发方法*/

  /*构建视图*/

  Widget seTitle() {
    return AppBar(
      brightness: Brightness.light,
      title: Text(
        widget.title,
        style: TextStyleMacro.titleBloD163,
      ),
      elevation: 1,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: ColorsMacro.col_FFF,
      centerTitle: true,
      bottom: PreferredSize(
          child: TTProgressBar(progress: linProgress),
          preferredSize: Size.fromHeight(0.1)),
    );
  }
}
