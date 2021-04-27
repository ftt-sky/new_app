class CurrentIds {
  static const String titleHome = 'title_home';
  static const String titleRepos = 'title_repos';
  static const String titleEvents = 'title_events';
  static const String titleSystem = 'title_system';

  static const String save = 'save';
  static const String more = 'more';

  static const String recRepos = 'rec_repos';
  static const String recWxArticle = 'rec_wxarticle';
}

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {CurrentIds.titleHome: "home", CurrentIds.titleSystem: 'System'}
  },
  'zh': {
    'CN': {CurrentIds.titleHome: '首页', CurrentIds.titleSystem: '体系'},
    'HK': {CurrentIds.titleHome: '主頁', CurrentIds.titleSystem: '體系'}
  }
};

// 简单多语言资源.
Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    CurrentIds.titleHome: 'Home',
  },
  'zh_CN': {
    CurrentIds.titleHome: '主页',
  },
};
