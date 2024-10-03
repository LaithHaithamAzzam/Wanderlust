import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/SerchAPI.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import '../../Provider/Serch_Provider.dart';

Future<void> SerchDialog(BuildContext context) async {
  TextEditingController Daycount = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();

  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) =>
          WillPopScope(
            onWillPop:  () => Future.value(true),
            child: AlertDialog(
              insetPadding: EdgeInsets.all(20.0),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              content:Container(
                width: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height/1.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top : 20.0 , left: 20.0 ,right: 20.0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "Name Trip".tr
                          ),
                        ),
                      ),  Padding(
                        padding: const EdgeInsets.only(top : 10.0 , left: 20.0 ,right: 20.0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: Daycount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Day Count".tr
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0 ,right: 20.0,top:10.0 , bottom:10.0 , ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: price,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Salary Trip On One Person".tr
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                        child: Row(
                          children: [
                            Text("Type".tr + ":    "),
                            Expanded(child: Serchdropdowncutom()),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                        child: Row(
                          children: [
                            Text("Season".tr + ":    "),
                            Expanded(child: SearchSeason_Type()),
                          ],
                        )
                      ),
                    Consumer<SerchProvider>(
  builder: (context, provider, child) {
  return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top:5.0 , left: 20.0 ,right: 20.0),
                            child: MaterialButtonCustoms(                                Textcolor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onpressed: (){
                                  selectestartdatebooking(context);
                                },
                            materialtext:provider.Start == null ? "Start Date".tr : "${provider.Start}" )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top:5.0 , left: 20.0 ,right: 20.0),
                            child: MaterialButtonCustoms(
                                Textcolor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onpressed: (){
                                  selecteenddatebooking(context);
                                }, materialtext: provider.End == null ? "End Date".tr:"${provider.End}",
                            )
                        ),    Padding(
                            padding: const EdgeInsets.only(top:5.0 , left: 20.0 ,right: 20.0 ,bottom: 30.0),
                            child: MaterialButtonCustoms(

                                onpressed: (){
                                  bookingenddate(context);
                                },
                                materialtext: provider.Ebook == null ? "Select End Date Booking".tr : "${provider.Ebook}",
                                Textcolor: Colors.white,
                                color: Theme.of(context).primaryColor,
                            )
                        ),

                      ],
                    );
  },
)
                    ],
                  ),
                ),
              ),
              actions: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          shadowColor: const MaterialStatePropertyAll(Color(0xffffffff)),
                          backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).primaryColor),
                          minimumSize: MaterialStatePropertyAll(
                              Size(MediaQuery.of(context).size.width / 4, 50))),
                      child:  Text('Serch'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await Serchapi(context).SerchTrips(
                            Provider.of<SerchProvider>(context,listen: false).Start,
                            Provider.of<SerchProvider>(context,listen: false).End,
                            Daycount.text.trim().isEmpty ? null : Daycount.text.trim(),
                            Provider.of<SerchProvider>(context,listen: false).type=="None" ? null : Provider.of<SerchProvider>(context,listen: false).type,
                            Provider.of<SerchProvider>(context,listen: false).season == "None" ? null :Provider.of<SerchProvider>(context,listen: false).season,
                            price.text.trim().isEmpty ? null :  price.text.trim(),
                            Provider.of<SerchProvider>(context,listen: false).Ebook,
                            name.text.trim().isEmpty ? null : name.text
                        );

                      },
                    )
                  ],
                )

              ],
            ),
          )
  );
}









class Serchdropdowncutom extends StatefulWidget {
  const Serchdropdowncutom({super.key});

  @override
  State<Serchdropdowncutom> createState() => _dropdowncutomState();
}

class _dropdowncutomState extends State<Serchdropdowncutom> {

  @override
  Widget build(BuildContext context) {
    String val = Provider.of<SerchProvider>(context , listen: false).type;
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.transparent),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.black,fontFamily: "CoustomFont"),
      dropdownColor: Colors.white,
      value: val,
      // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
          Provider.of<SerchProvider>(context , listen: false).settype(val);
        });
      },
      isExpanded: true,
      items: <String>[
        'None',
        'Beaches',
        'Cities',
        'Desert',
        'Lakes',
        'Mountains',
        'Tourist Attractions',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.tr),
        );
      }).toList(),
    );
  }
}



class SearchSeason_Type extends StatefulWidget {
  const SearchSeason_Type({super.key});

  @override
  State<SearchSeason_Type> createState() => _Season_TypeState();
}

class _Season_TypeState extends State<SearchSeason_Type> {

  @override
  Widget build(BuildContext context) {
    String val = Provider.of<SerchProvider>(context , listen: false).season;
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.transparent),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style:  TextStyle(color: Colors.black ,fontFamily: "CoustomFont"),
      dropdownColor: Colors.white,
      value: val,
      // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
          Provider.of<SerchProvider>(context , listen: false).setseason(val);
        });
      },
      isExpanded: true,
      items: <String>[
        'None',
        'Autumn',
        'Winter',
        'Spring',
        'Summer',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.tr),
        );
      }).toList(),
    );
  }
}



Future<void> selectestartdatebooking(BuildContext context) async {
bool isedite = false;
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: const Color(0xffffffff),
        backgroundColor: Theme.of(context).primaryColor,
        insetPadding: EdgeInsets.all(20.0),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        title:  Text(
          'Select Start Date Trip',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[

              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        primaryColor: Color(0xffffffff),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      maximumDate: DateTime(DateTime.now().year+2),
                      minimumDate:  DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime:  DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        isedite = true;
                        Provider.of<SerchProvider>(context , listen: false).setStart(
                            newDateTime.toString().replaceAll("00:00:00.000", "")
                        );
                       },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0 , left: 30 , right: 30),
                child: TextButton(
                  onPressed: () {
                       if(isedite == true){
                      Navigator.of(context).pop();
                    }
                    else{
                         Navigator.of(context).pop();
                         String start = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                         Provider.of<SerchProvider>(context , listen: false).setStart(start);
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Color(0xffffffff))),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Color(0xff3b4e52)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> selecteenddatebooking(BuildContext context) async {
bool isedite = false;
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20.0),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        shadowColor: const Color(0xffffffff),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        title: const Text(
          'Select End Date Trip',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[

              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        primaryColor: Color(0xffffffff),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      maximumDate: DateTime(DateTime.now().year+2),
                      minimumDate:  DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime:  DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        isedite = true;
                        Provider.of<SerchProvider>(context , listen: false).setEnd(
                            newDateTime.toString().replaceAll("00:00:00.000", "")
                        );
                       },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0 , left: 30 , right: 30),
                child: TextButton(
                  onPressed: () {
                       if(isedite == true){
                      Navigator.of(context).pop();
                    }
                    else{
                         Navigator.of(context).pop();
                         String start = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                         Provider.of<SerchProvider>(context , listen: false).setEbook(
                             start
                      );
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Color(0xffffffff))),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Color(0xff3b4e52)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> bookingenddate(BuildContext context) async {
  bool isedite = false;
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: const Color(0xffffffff),
        backgroundColor: Theme.of(context).primaryColor,
        insetPadding: EdgeInsets.all(20.0),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        title:  Text(
          'Select End Date Booking'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[

              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        primaryColor: Color(0xffffffff),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      maximumDate: DateTime(DateTime.now().year+2),
                      minimumDate:  DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime:  DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        isedite = true;
                        Provider.of<SerchProvider>(context , listen: false).setEbook(
                            newDateTime.toString().replaceAll("00:00:00.000", "")
                        );
                       },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0 , left: 30 , right: 30),
                child: TextButton(
                  onPressed: () {
                    if(isedite == true){
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                            String start = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                      Provider.of<SerchProvider>(context , listen: false).setEbook(
                             start
                      );
                    }

                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Color(0xffffffff))),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Color(0xff3b4e52)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

