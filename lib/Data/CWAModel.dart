


import 'package:flutter/widgets.dart';

enum InfoStatus {
  ///初始頁面
  initial,
  ///讀取中
  processing,
  ///錯誤
  error,
  ///正確
  ok,
}

class CWAModel extends ChangeNotifier {
  InfoStatus _status = InfoStatus.initial ;

  InfoStatus get status => _status ;
  String errMsg = "" ;
  String WxMsg = "" ;

  void setStatus(InfoStatus s) {
    _status = s ;
    notifyListeners(); // 通知訂閱CartModel的子組件資料已變更，需重繪
  }

  void setProcessing(String localName) {
    localName = localName ;
    setStatus(InfoStatus.processing);
  }

  void setError(String msg) {
    errMsg = msg ;
    setStatus(InfoStatus.error);
  }

  void setOK(String msg) {
    WxMsg = msg ;
    setStatus(InfoStatus.ok);
  }
}