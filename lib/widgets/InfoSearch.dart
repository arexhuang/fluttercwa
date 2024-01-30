

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:testcwa/Data/CWAModel.dart';
import 'dart:developer';

class InfoSearch extends StatefulWidget {
  const InfoSearch({super.key,required this.localName,required this.model});

  final String localName ;
  final CWAModel model ;

  @override
  State<InfoSearch> createState() => _InfoSearchState();
}

class _InfoSearchState extends State<InfoSearch> {

  CWAModel get model => widget.model ;

  @override
  void initState() {

    String url = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-686C302B-5392-434F-BEFA-672A6BFA24E3&elementName=Wx&locationName=" ;

    httpget(url+widget.localName, (response,b){
      //解
      if( b == false || response == null ) {
        model.setError("通訊錯誤") ;
        return ;
      }
      try {
        if( response!.data["records"] == null ||
            response!.data["records"]["location"] == null
            // response!.data["records"]["location"]["weatherElement"] == null ||
            // response!.data["records"]["location"]["weatherElement"]["time"] == null
          ) {
          model.setError("資料錯誤") ;
          return ;
        }

        String infoMsg = "" ;
        var lst = response!.data["records"]["location"];

        for( var item in lst ) {
          var elements = item["weatherElement"] ;
          for( var element in elements ){
            var str = getWxCombinString(element["time"]) ;
            infoMsg += str ;
          }
        }
        if( infoMsg.isEmpty) {
          model.setError( "無資料,可能沒有輸入地點" ) ;
          return ;
        }
        model.setOK(infoMsg) ;
      }
      catch(e){
        model.setError( "資料錯誤" ) ;
        return ;
      }
    }) ;

    super.initState();
  }

  String getWxCombinString(List lst) {
    String msg = "" ;
    for( var item in lst) {
      msg += getSubMsg(item) ;
    }
    return msg ;
  }

  String getSubMsg(Map<String,dynamic> map ){
    try {
      if (map == null) return "";
      return map["startTime"] + " ~ " + map["startTime"] + "\n" + map["parameter"]["parameterName"] + "\n";
    }
    catch(e)
    {
      return "" ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("資料尋找中請稍後") ;
  }

  Future<bool> httpget(String url,void Function(Response?,bool ) callback) async
  {
    try {
      // 。
      Dio dio = Dio();

      final response = await dio.get(url);

      if( callback != null )
        callback(response,true) ;
      return true;
    }
    catch(e)
    {
      if( callback != null )
        callback(null,false) ;
      return false ;
    }
  }
}
