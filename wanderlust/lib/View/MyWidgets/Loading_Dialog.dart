import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

loding(BuildContext context , CancelToken canseltoken )  {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context
        ){
      return WillPopScope(

        onWillPop:  () {
          canseltoken.cancel();
          return Future(() => false);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          alignment: Alignment.center,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)
                ),
                child: CircularProgressIndicator(strokeCap: StrokeCap.round, color: Colors.white,strokeWidth: 8,)

            ),
          ),
        ),
      );

    },
  );
}