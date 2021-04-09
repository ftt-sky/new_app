


class TTObjectUtil {


  /*
  判断字符串为null
  return YES str为null 或者为0
  */
  static bool isEmptyString(String str ) {
    return str == null || str.isEmpty;
  }

  /*
  * 判断数组为null 或者 个数为0
  * */
  static bool isEmptyList(List list) {
    return list == null || list.isEmpty;
  }

  /*
  * 判断字典是否为 null
  * */
  static bool isEmptyMap(Map map) {
    return map == null || map.isEmpty;
  }

   /*
   * 判断 object 是否是null
   * */
  static bool isEmpty(Object object) {
    if(object == null) return true;
    if(object is String && object.isEmpty) {
      return true;
    }else if (object is List && object.isEmpty) {
      return true;
    }else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }
  /*
  * 判断object 不为 null
  * */
  static bool isNotEmpty(Object object) {
    return !isEmpty(object);
  }

  /*
  * 获取object 的长度
  * */
  static int getLength(Object value) {
    if (value == null) return 0;
    if (value is String) {
      return value.length;
    }else if (value is List) {
      return value.length;
    }else if (value is Map) {
      return value.length;
    }else {
      return 0;
    }
  }




}
