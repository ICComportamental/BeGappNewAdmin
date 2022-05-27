import 'dart:io';
import 'package:flutter/material.dart';

class Connection {
  static checkConnection(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        // Navigator.pop(context);
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      // Navigator.pop(context);
      // noConnection(context);
      return false;
    }
  }

  // static loading(context){
  //   showDialog(
  //     context: context,
  //     barrierDismissible:  false,
  //      builder: (BuildContext context) {
  //         return new WillPopScope(
  //             onWillPop: () async => false,
  //             child: SimpleDialog(
  //                 // backgroundColor: Colors.black54,
  //                 children: <Widget>[
  //                   Center(
  //                     child: Column(children: [
  //                       CircularProgressIndicator(),
  //                       // SizedBox(height: 10,),
  //                       // Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
  //                     ]),
  //                   )
  //                 ]));
  //      });

  // }
  // static loadingConnection(context){
  //   showDialog(
  //     context: context,
  //     barrierDismissible:  false,
  //      builder: (BuildContext context) {
  //         return new WillPopScope(
  //             onWillPop: () async => false,
  //             child: SimpleDialog(
  //                 // backgroundColor: Colors.black54,
  //                 children: <Widget>[
  //                   FutureBuilder(
  //                     future: checkConnection(context) ,
  //                     builder: (BuildContext context, AsyncSnapshot snapshot){
  //                       List snap = snapshot.data;
  //                       if(snapshot.connectionState == ConnectionState.waiting){
  //                         return Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       }
  //                       if(snapshot.hasError){
  //                         return Center(
  //                           child: AlertDialog(
  //                               content: Text(AppLocalizations.of(context).translate('invalidLogin'),style: TextStyle(fontSize:MediaQuery.of(context).size.height/30),),
  //                               actions: [
  //                                 FlatButton(
  //                                   onPressed: (){
  //                                   Navigator.of(context).pop();
  //                                   },
  //                                   child: Text(AppLocalizations.of(context).translate('ok'),style: TextStyle(fontSize: MediaQuery.of(context).size.height/30),)),

  //                               ],
  //                             )
  //                           );
  //                       }
  //                       Navigator.of(context).pop();
  //                       return
  //                       Center(

  //                       );
  //                     },
  //                   ),
  //                 ]));
  //      });

  // }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(key: key,
                  // backgroundColor: Colors.black,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        // SizedBox(height: 10,),
                        // Text("Please Wait...",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}
