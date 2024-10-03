import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Provider/imageprofile.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'Api.dart' as apis;

class EditePhotoAPIS{
  BuildContext context;
  EditePhotoAPIS(this.context);
  EditePhotoAPI(File? imagess)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = await prefs.getString('Token');
    try {

      FormData  formdata = FormData.fromMap({
        "photo": await MultipartFile.fromFile(imagess!.path,),
      });
      var Res = await Dio().post("${apis.Server_Url}${apis.EditPhoto}",
          options: Options(
              headers: {
                'accept': 'application/json',
                'authorization': 'Bearer $Token',
              }
          ),

          data: formdata
      );

      if(Res.statusCode == 200){

         Provider.of<imageprofile>(context,listen: false).setImage(Res.data['photopath']);
        showSnackBar(context, "Edite successfully".tr, Colors.green, false);
        await prefs.setString("Token", "${Res.data['new token']}");
        await prefs.setString("photo", "${Res.data['photopath']}");

      }
    }catch (e){
    }

  }
}