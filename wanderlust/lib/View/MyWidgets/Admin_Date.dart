
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/SelectDateProvider.dart';

Selectdate(BuildContext context) {
  DateTime? startDate;
  DateTime? endDate;
  showCustomDateRangePicker(
    context,
    dismissible: true,
    minimumDate: DateTime.now(),
    maximumDate: DateTime(DateTime.now().year + 10),
    endDate: Provider.of<SelectDate>(context , listen: false).enddate,
    startDate: Provider.of<SelectDate>(context , listen: false).stardate,
    backgroundColor: Colors.white,
    primaryColor:Theme.of(context).primaryColor,
    onApplyClick: (start, end) {
      startDate = DateTime(start.year,start.month,start.day);
      endDate = DateTime(end.year,end.month,end.day);
      Provider.of<SelectDate>(context , listen: false).SetDate(startDate!, endDate!);

    },
    onCancelClick: () {

    },
  );
}
