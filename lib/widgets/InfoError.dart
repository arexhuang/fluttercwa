

import 'package:flutter/cupertino.dart';

import '../Data/CWAModel.dart';

class InfoError extends StatelessWidget {
  const InfoError({super.key,required this.model});

  final CWAModel model ;

  @override
  Widget build(BuildContext context) {
    return Text(model.errMsg) ;
  }
}
