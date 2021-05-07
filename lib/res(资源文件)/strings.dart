class CurrentIds {
  static const String titleHome = 'title_home';
  static const String titleRepos = 'title_repos';
  static const String titleEvents = 'title_events';
  static const String titleSystem = 'title_system';

  static const String titleBookmarks = 'title_bookmarks';
  static const String titleCollection = 'title_collection';
  static const String titleSetting = 'title_setting';
  static const String titleAbout = 'title_about';
  static const String titleShare = 'title_share';
  static const String titleSignOut = 'title_signout';
  static const String titleLanguage = 'title_language';
  static const String titleTheme = 'title_theme';
  static const String titleAuthor = 'title_author';
  static const String titleOther = 'title_other';

  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageTW = 'language_tw';
  static const String languageHK = 'language_hk';
  static const String languageEN = 'language_en';

  static const String save = 'save';
  static const String more = 'more';

  static const String recRepos = 'rec_repos';
  static const String recWxArticle = 'rec_wxarticle';

  static const String titleReposTree = 'title_repos_tree';
  static const String titleWxArticleTree = 'title_wxarticle_tree';
  static const String titleSystemTree = 'title_system_tree';

  static const String user_name = 'user_name';
  static const String user_pwd = 'user_pwd';
  static const String user_re_pwd = 'user_re_pwd';
  static const String user_login = 'user_login';
  static const String user_register = 'user_register';
  static const String user_forget_pwd = 'user_forget_pwd';
  static const String user_new_user_hint = 'user_new_user_hint';

  static const String confirm = 'confirm';
  static const String cancel = 'cancel';

  static const String jump_count = 'jump_count';
}

// 简单多语言资源.
Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    CurrentIds.titleHome: 'Home',
    CurrentIds.titleRepos: 'Repos',
    CurrentIds.titleEvents: 'Events',
    CurrentIds.titleSystem: 'System',
    CurrentIds.titleBookmarks: 'Bookmarks',
    CurrentIds.titleSetting: 'Setting',
    CurrentIds.titleAbout: 'About',
    CurrentIds.titleShare: 'Share',
    CurrentIds.titleSignOut: 'Sign Out',
    CurrentIds.titleLanguage: 'Language',
    CurrentIds.languageAuto: 'Auto',
  },
  'zh': {
    CurrentIds.titleHome: '主页',
    CurrentIds.titleRepos: '项目',
    CurrentIds.titleEvents: '动态',
    CurrentIds.titleSystem: '体系',
    CurrentIds.titleBookmarks: '书签',
    CurrentIds.titleSetting: '设置',
    CurrentIds.titleAbout: '关于',
    CurrentIds.titleShare: '分享',
    CurrentIds.titleSignOut: '注销',
    CurrentIds.titleLanguage: '多语言',
    CurrentIds.languageAuto: '跟随系统',
  },
};

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {
      CurrentIds.titleHome: 'Home',
      CurrentIds.titleRepos: 'Repos',
      CurrentIds.titleEvents: 'Events',
      CurrentIds.titleSystem: 'System',
      CurrentIds.titleBookmarks: 'Bookmarks',
      CurrentIds.titleCollection: 'Collection',
      CurrentIds.titleSetting: 'Setting',
      CurrentIds.titleAbout: 'About',
      CurrentIds.titleShare: 'Share',
      CurrentIds.titleSignOut: 'Sign Out',
      CurrentIds.titleLanguage: 'Language',
      CurrentIds.languageAuto: 'Auto',
      CurrentIds.save: 'Save',
      CurrentIds.more: 'More',
      CurrentIds.recRepos: 'Reco Repos',
      CurrentIds.recWxArticle: 'Reco WxArticle',
      CurrentIds.titleReposTree: 'Repos Tree',
      CurrentIds.titleWxArticleTree: 'Wx Article',
      CurrentIds.titleTheme: 'Theme',
      CurrentIds.user_name: 'user name',
      CurrentIds.user_pwd: 'password',
      CurrentIds.user_re_pwd: 'confirm password',
      CurrentIds.user_login: 'Login',
      CurrentIds.user_register: 'Register',
      CurrentIds.user_forget_pwd: 'Forget the password?',
      CurrentIds.user_new_user_hint: 'New users? ',
      CurrentIds.confirm: 'Confirm',
      CurrentIds.cancel: 'Cancel',
      CurrentIds.jump_count: 'Jump %\$0\$s',
    }
  },
  'zh': {
    'CN': {
      CurrentIds.titleHome: '主页',
      CurrentIds.titleRepos: '项目',
      CurrentIds.titleEvents: '动态',
      CurrentIds.titleSystem: '体系',
      CurrentIds.titleBookmarks: '书签',
      CurrentIds.titleCollection: '收藏',
      CurrentIds.titleSetting: '设置',
      CurrentIds.titleAbout: '关于',
      CurrentIds.titleShare: '分享',
      CurrentIds.titleSignOut: '注销',
      CurrentIds.titleLanguage: '多语言',
      CurrentIds.languageAuto: '跟随系统',
      CurrentIds.languageZH: '简体中文',
      CurrentIds.languageTW: '繁體中文（台灣）',
      CurrentIds.languageHK: '繁體中文（香港）',
      CurrentIds.languageEN: 'English',
      CurrentIds.save: '保存',
      CurrentIds.more: '更多',
      CurrentIds.recRepos: '推荐项目',
      CurrentIds.recWxArticle: '推荐公众号',
      CurrentIds.titleReposTree: '项目分类',
      CurrentIds.titleWxArticleTree: '公众号',
      CurrentIds.titleTheme: '主题',
      CurrentIds.user_name: '用户名',
      CurrentIds.user_pwd: '密码',
      CurrentIds.user_re_pwd: '确认密码',
      CurrentIds.user_login: '登录',
      CurrentIds.user_register: '注册',
      CurrentIds.user_forget_pwd: '忘记密码？',
      CurrentIds.user_new_user_hint: '新用户？',
      CurrentIds.confirm: '确认',
      CurrentIds.cancel: '取消',
      CurrentIds.jump_count: '跳过 %\$0\$s',
    },
    'HK': {
      CurrentIds.titleHome: '主頁',
      CurrentIds.titleRepos: '項目',
      CurrentIds.titleEvents: '動態',
      CurrentIds.titleSystem: '體系',
      CurrentIds.titleBookmarks: '書簽',
      CurrentIds.titleCollection: '收藏',
      CurrentIds.titleSetting: '設置',
      CurrentIds.titleAbout: '關於',
      CurrentIds.titleShare: '分享',
      CurrentIds.titleSignOut: '註銷',
      CurrentIds.titleLanguage: '語言',
      CurrentIds.languageAuto: '與系統同步',
      CurrentIds.save: '儲存',
      CurrentIds.more: '更多',
      CurrentIds.recRepos: '推荐项目',
      CurrentIds.recWxArticle: '推荐公众号',
      CurrentIds.titleReposTree: '项目分类',
      CurrentIds.titleWxArticleTree: '公众号',
      CurrentIds.titleTheme: '主題',
      CurrentIds.user_name: '用户名',
      CurrentIds.user_pwd: '密码',
      CurrentIds.user_re_pwd: '确认密码',
      CurrentIds.user_login: '登录',
      CurrentIds.user_register: '注册',
      CurrentIds.user_forget_pwd: '忘记密码？',
      CurrentIds.user_new_user_hint: '新用户？',
      CurrentIds.confirm: '确认',
      CurrentIds.cancel: '取消',
      CurrentIds.jump_count: '跳过 %\$0\$s',
    },
    'TW': {
      CurrentIds.titleHome: '主頁',
      CurrentIds.titleRepos: '項目',
      CurrentIds.titleEvents: '動態',
      CurrentIds.titleSystem: '體系',
      CurrentIds.titleBookmarks: '書簽',
      CurrentIds.titleCollection: '收藏',
      CurrentIds.titleSetting: '設置',
      CurrentIds.titleAbout: '關於',
      CurrentIds.titleShare: '分享',
      CurrentIds.titleSignOut: '註銷',
      CurrentIds.titleLanguage: '語言',
      CurrentIds.languageAuto: '與系統同步',
      CurrentIds.save: '儲存',
      CurrentIds.more: '更多',
      CurrentIds.recRepos: '推荐项目',
      CurrentIds.recWxArticle: '推荐公众号',
      CurrentIds.titleReposTree: '项目分类',
      CurrentIds.titleWxArticleTree: '公众号',
      CurrentIds.titleTheme: '主題',
      CurrentIds.user_name: '用户名',
      CurrentIds.user_pwd: '密码',
      CurrentIds.user_re_pwd: '确认密码',
      CurrentIds.user_login: '登录',
      CurrentIds.user_register: '注册',
      CurrentIds.user_forget_pwd: '忘记密码？',
      CurrentIds.user_new_user_hint: '新用户？',
      CurrentIds.confirm: '确认',
      CurrentIds.cancel: '取消',
      CurrentIds.jump_count: '跳过 %\$0\$s',
    }
  }
};
