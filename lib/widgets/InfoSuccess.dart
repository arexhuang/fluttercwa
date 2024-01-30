

import 'package:flutter/cupertino.dart';

import '../Data/CWAModel.dart';

class InfoSuccess extends StatelessWidget {
  const InfoSuccess({super.key,required this.model});

  final CWAModel model ;

  @override
  Widget build(BuildContext context) {

    return Text(model.WxMsg) ;
  }
}
