import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Image_Trip_APi.dart';
import 'package:wanderlust/Provider/trip_Provider.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<void> EditeName(BuildContext context , String Name) async {
  TextEditingController name = TextEditingController();
  name.text = Name;
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
                height:  MediaQuery.of(context).size.height/2.5,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.width/2,
                      child:  Center(child: Text(style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),textAlign: TextAlign.center,
                          "Edite Trip Name".tr
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: name,
                      ),
                    )
                  ],
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
                      child:  Text('Save'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        Provider.of<Trips_Provider>(context,listen: false).setName(name.text);
                      context.pop();
                        },
                    )
                  ],
                )

              ],
            ),
          )
  );
}


Future<void> EditeSallary(BuildContext context , String sallary) async {
  TextEditingController salary = TextEditingController();
  salary.text = sallary;
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
                height:  MediaQuery.of(context).size.height/2.5,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.width/2,
                      child:  Center(child: Text(style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),textAlign: TextAlign.center,
                          "Edite salary For One People".tr
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: salary,
                      ),
                    )
                  ],
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
                      child:  Text('Save'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        Provider.of<Trips_Provider>(context,listen: false).setsallry(int.parse(salary.text));
                        context.pop();
                      },
                    )
                  ],
                )

              ],
            ),
          )
  );
}



EditeDate(BuildContext context) {

  DateTime? StartDate;
  DateTime? EndDate;

  List<String> enddate =  Provider.of<Trips_Provider>(context , listen: false).endDate!.split("-");
  EndDate = DateTime(int.parse(enddate[0]),int.parse(enddate[1]),int.parse(enddate[2]));

  List<String> startdate =  Provider.of<Trips_Provider>(context , listen: false).startDate!.split("-");
  StartDate = DateTime(int.parse(startdate[0]),int.parse(startdate[1]),int.parse(startdate[2]));



  showCustomDateRangePicker(
    context,
    dismissible: true,
    minimumDate: StartDate,
    maximumDate: DateTime(DateTime.now().year + 1),
    startDate: StartDate,
    endDate: EndDate,
    backgroundColor: Colors.white,
    primaryColor:Theme.of(context).primaryColor,
    onApplyClick: (start, end) {
      StartDate = DateTime(start.year,start.month,start.day);
      EndDate = DateTime(end.year,end.month,end.day);

      Provider.of<Trips_Provider>(context , listen: false).setDate(
          StartDate!,
          EndDate!
      );

    },
    onCancelClick: () {

    },
  );
}









class Editedropdowncutom extends StatefulWidget {
  const Editedropdowncutom({super.key});

  @override
  State<Editedropdowncutom> createState() => _dropdowncutomState();
}

class _dropdowncutomState extends State<Editedropdowncutom> {

  @override
  Widget build(BuildContext context) {
    String val = Provider.of<Trips_Provider>(context,listen: false).type.toString();
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.transparent),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.white,fontFamily: "CoustomFont"),
      dropdownColor: Theme.of(context).primaryColor,
      value: val,
      // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
          Provider.of<Trips_Provider>(context , listen: false).setType(newValue!);
        });
      },
      isExpanded: true,
      items: <String>[
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



class EditeSeason_Type extends StatefulWidget {
  const EditeSeason_Type({super.key});

  @override
  State<EditeSeason_Type> createState() => _Season_TypeState();
}

class _Season_TypeState extends State<EditeSeason_Type> {

  @override
  Widget build(BuildContext context) {
    String val = Provider.of<Trips_Provider>(context,listen: false).season.toString();
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.transparent),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.white,fontFamily: "CoustomFont"),
      dropdownColor: Theme.of(context).primaryColor,
      value: val,
      // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
          Provider.of<Trips_Provider>(context , listen: false).setSeason(newValue!);
        });
      },
      isExpanded: true,
      items: <String>[
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




Future<void> selectedatebooking(BuildContext context) async {
   bool isedite = false;
  List<String> initval = Provider.of<Trips_Provider>(context, listen: false).bookingEndDate!.split("-");
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: const Color(0xffffffff),
        backgroundColor: Theme.of(context).primaryColor,
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
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                        minimumDate:  DateTime(int.parse(initval[0]),int.parse(initval[1]),int.parse(initval[2])),
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(int.parse(initval[0]),int.parse(initval[1]),int.parse(initval[2])),
                        maximumYear: DateTime.now().year,
                        onDateTimeChanged: (DateTime newDateTime) {
                          isedite = true;
                          Provider.of<Trips_Provider>(context, listen: false)
                              .setEndDateBooking("${newDateTime.year}-${newDateTime.month}-${newDateTime.day}");
                        },
                      ),
                    )),
                TextButton(
                  onPressed: () {
                       if(isedite == true){
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                            String start = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
                      Provider.of<Trips_Provider>(context , listen: false).setEndDateBooking(
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
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}







choisEditedimage(BuildContext context , int tripid , index) async {
  final ImagePicker picker = ImagePicker();
  var image = await picker.pickImage(source: ImageSource.gallery);
  if (image!.path.isNotEmpty) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio7x5,
      ],
      uiSettings: [
        AndroidUiSettings(
            hideBottomControls: true,
            statusBarColor: Color(0xff4C4DDC),
            activeControlsWidgetColor:Color(0xff4C4DDC) ,
            toolbarColor: Color(0xff4C4DDC),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true
        ),
      ],
    );
    await AddPhotoAPIS(context).AddPhotoAPI(tripid, File(croppedFile!.path),true);
  }
}