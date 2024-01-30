

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testcwa/Data/CWAModel.dart';
import 'package:testcwa/widgets/InfoError.dart';
import 'package:testcwa/widgets/InfoSearch.dart';
import 'package:testcwa/widgets/InfoSuccess.dart';

import 'widgets/InfoInitial.dart';

class HomeProviderPage extends StatefulWidget {
  const HomeProviderPage({super.key, required this.title});

  final String title;

  @override
  State<HomeProviderPage> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProviderPage> {

  String localName = "" ;

  @override
  Widget build(BuildContext context) {

    var border = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFF434343)),
      borderRadius: BorderRadius.circular(16),);

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ChangeNotifierProvider(
        create: (context) => CWAModel(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 6 , 0, 0)),
            Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 0 , 10, 0)),
                Expanded(
                  // width: 200,
                  child: Container(
                    height: 48,
                    child : TextField(
                        onChanged: (text) {
                          localName = text ;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                        focusedBorder: border,
                        enabledBorder: border,
                        // labelText: "用户名",
                        hintText: "請輸入城市名稱",
                        // prefixIcon: Icon(Icons.person)
                    )),
                  )
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0)),
                Consumer<CWAModel>(
                  builder: (context, model , child) {
                    if( model.status == InfoStatus.processing) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,foregroundColor: Colors.white),
                        child: Text("確認"),
                        onPressed: () {
                        },
                      );
                    }
                    else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,foregroundColor: Colors.white),
                        child: Text("確認"),
                        onPressed: () {
                          if( localName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("請輸入城市"),
                            ));
                            return ;
                          }
                          model.setStatus(InfoStatus.processing) ;
                        },
                      );
                    }
                  }),
                Padding(padding: EdgeInsets.fromLTRB(0, 0 , 10, 0)),
              ]
             ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10 , 0, 0)),
            Expanded(
              child: SingleChildScrollView(
                child : Consumer<CWAModel>(
                  builder: (context, model , child) {
                    switch(model.status)
                    {
                      case InfoStatus.ok :
                        return InfoSuccess(model: model);

                      case InfoStatus.error :
                        return InfoError(model: model);

                      case InfoStatus.processing :
                        return InfoSearch(localName:localName,model: model,);

                      default :
                        break ;
                    }
                    return InfoInitial();
                  },
                )
              ),
            ),
          ],
        ),),
    );

  }
}