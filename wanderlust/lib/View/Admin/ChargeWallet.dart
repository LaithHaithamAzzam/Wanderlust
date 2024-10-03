import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanderlust/Controller/ChargeWallet.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';


class ChargeWall extends StatelessWidget {
   ChargeWall({super.key});
   TextEditingController username = TextEditingController();
   TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Charge Account".tr),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ) ,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                  hintText: "UserName".tr,suffixIcon: Icon(Icons.supervised_user_circle_sharp,color: Theme.of(context).primaryColor,)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0 , bottom: 28.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amount,
                  decoration: InputDecoration(

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ) ,
                      enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      ) ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor,style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      hintText: "Amount".tr,suffixIcon: Icon(Icons.monetization_on,color: Theme.of(context).primaryColor,)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width-20,60)),
                  backgroundColor:MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))))
                ),
                  onPressed: ()async{
                        if(username.text.trim().isNotEmpty && amount.text.trim().isNotEmpty){
                       if( double.parse(amount.text) > 0.0){
                         await ChargeWallet(context).chargeWallet(username.text, amount.text);
                         amount.clear();
                         username.clear();
                       }
                       else{
                         showSnackBar(context, "Amount Must be Positive", Colors.redAccent, false);
                          }
                        }else{
                          showSnackBar(context, "Not Allow Null Value", Colors.redAccent, false);
                        }

                  }, child: Text("Charge Account".tr,style: TextStyle(color:Colors.white,)))
            ],
          ),
        ),
      ),
    );
  }
}
