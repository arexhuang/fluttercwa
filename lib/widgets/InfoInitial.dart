

import 'package:flutter/cupertino.dart';

class InfoInitial extends StatelessWidget {
  const InfoInitial({super.key});

  @override
  Widget build(BuildContext context) {

    return const Text("請於上方都市欄位輸入想要查詢的名稱,確認後按下尋找\n都市名稱建議如下,打錯會查詢不到:\n"
        "宜蘭縣,花蓮縣,臺東縣,澎湖縣,金門縣\n"
        "連江縣,臺北市,新北市,桃園市,臺中市\n"
        "臺南市,高雄市,基隆市,新竹縣,新竹市\n"
        "苗栗縣,彰化縣,南投縣,雲林縣,嘉義縣,\n"
        "嘉義市,屏東縣") ;
  }
}
