import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/Seasons_Provider.dart';
import 'package:wanderlust/Provider/TypeTrip_Provider.dart';


class dropdowncutom extends StatefulWidget {
  const dropdowncutom({super.key});

  @override
  State<dropdowncutom> createState() => _dropdowncutomState();
}

class _dropdowncutomState extends State<dropdowncutom> {
  String val = "Beaches";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.white),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.black),
       value: val,
       // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
          Provider.of<TypeTrip_Provider>(context , listen: false).SetValue(newValue!);
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



class Season_Type extends StatefulWidget {
  const Season_Type({super.key});

  @override
  State<Season_Type> createState() => _Season_TypeState();
}

class _Season_TypeState extends State<Season_Type> {
  String val = "Winter";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      autofocus: false,
      underline: const Text(
        '',
        style: TextStyle(color: Colors.white),
      ),
      borderRadius: BorderRadius.circular(10),
      iconEnabledColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.black),
      value: val,
      // Provider.of<SelectionDropDownList>(context , listen: false).item,
      onChanged: (newValue) {
        setState(() {
          val = newValue.toString();
           Provider.of<Seasons_Provider>(context , listen: false).SetValue(newValue!);
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