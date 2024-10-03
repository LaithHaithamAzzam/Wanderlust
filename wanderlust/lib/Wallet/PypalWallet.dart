import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PypalWallet extends StatelessWidget {
  const PypalWallet({super.key});

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Paypal Payment"),
      ),
  body: Padding(
    padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0 , right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/pp_h_rgb_logo_tn.jpg",width: _w /3,),
                Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    Text("150.000 SP"),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                child:Container(
                  color: Colors.black,
                  width: _w-20,
                  height: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Text("Send to"),
          ),
          Text("Winderlust Application Wallet \n 124 Syria - Damascus , BS3 1DG"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                child:Container(
                  color: Colors.black,
                  width: _w-20,
                  height: 1,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Pay With \n Laith Haitham Azzam"),
          ),
          Text("Debite/Credit Card : MasterCard \n xxxx-xxxx-xxxx-1111"),
          Padding(
            padding: const EdgeInsets.only(top: 18.0 , bottom:  18.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 8.0 , bottom: 15.0 , top: 15.0),
                    child: SvgPicture.asset("assets/images/card.svg", width: 40,),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(hintText: "XXXX-XXXX-XXXX-1111"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(onPressed: (){}, child: Text("Confirm" , style: TextStyle(color: Colors.white),) , style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
            minimumSize: MaterialStatePropertyAll(Size(_w , 60)),
            shape: MaterialStatePropertyAll(LinearBorder()),

          ),),
          Container(
              padding: EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cancel and return to UGMONK."),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Policies Teams"),
                      Row(
                        children: [
                          Icon(Icons.copyright_outlined),
                          Text("1999 - 2016"),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("Privacy Feedback"),
                Text("Secure Page"),
              ],
            ),
          )
        ],
      ),
    ),
  ),
    );
  }
}
