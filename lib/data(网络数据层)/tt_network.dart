import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'base_resp.dart';

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  BaseOptions options;
}

class TTNetWorkingManager {
  /// 单利
  static final TTNetWorkingManager _manager = TTNetWorkingManager._init();

  static Dio _dio;

  String _statusKey = "status";

  String _codeKey = "errorCode";

  String _msgKey = "errorMsg";

  String _dataKey = "data";

  BaseOptions _options = getDefOptions();

  static bool _isDebug = true;

  /// 获取对象
  static TTNetWorkingManager getInstance() {
    return _manager;
  }

  /// 获取对象
  factory TTNetWorkingManager() {
    return _manager;
  }

  /// 初始化
  TTNetWorkingManager._init() {
    _dio = Dio(_options);
  }

  /// 设置cookie
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers = headers;
  }

  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _options = config.options ?? getDefOptions();
  }

  /*
 * 获取网路请求
 * method 请求方法
 * path   请求地址
 * data   参数
 * option
 * <BaseResp> <status,code,data,msg>
 * */
  Future<BaseResp<T>> request<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    BaseRespR respR =
        await requestR(method, path, data: data, cancelToken: cancelToken);
    if (respR.response.statusCode == HttpStatus.ok ||
        respR.response.statusCode == HttpStatus.created) {
      try {
        return BaseResp(respR.status, respR.code, respR.msg, respR.data);
      } catch (e) {
        return new Future.error(new DioError(
          response: respR.response,
          type: DioErrorType.response,
          requestOptions: null,
        ));
      }
    }
    return new Future.error(new DioError(
      response: respR.response,
      type: DioErrorType.response,
      requestOptions: null,
    ));
  }

  /*
 * 获取网路请求
 * method 请求方法
 * path   请求地址
 * data   参数
 * option
 * <BaseResp> <status,code,data,msg,response>
 * */
  Future<BaseRespR<T>> requestR<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(
      path,
      data: data,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );

    _printHttpLog(response);
    String status;
    int code;
    String msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];
          code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          msg = _dataMap[_msgKey];
          _data = _dataMap[_dataMap];
        }
        print(code);
        return BaseRespR(status, code, msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          type: DioErrorType.response,
          requestOptions: null,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      type: DioErrorType.response,
      requestOptions: null,
    ));
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.requestOptions));
      _printDataStr("reqdata ", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get RequestOptions Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  /// 验证是否存在
  Options _checkOptions(method, Options options) {
    if (options == null) {
      options = Options();
    }
    options.method = method;
    return options;
  }

  /// 设置默认配置
  static BaseOptions getDefOptions() {
    BaseOptions options =
        BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
      HttpHeaders.userAgentHeader: "dio",
      'api': '1.0.0',
    });
    return options;
  }
}
