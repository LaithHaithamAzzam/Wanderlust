import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Provider/Activitys_Edite_Provider.dart';
import 'package:wanderlust/Provider/Activitys_Provider.dart';
import 'package:wanderlust/Provider/AllTrips_Provider.dart';
import 'package:wanderlust/Provider/Cheeck_edite.dart';
import 'package:wanderlust/Provider/FavProvider.dart';
import 'package:wanderlust/Provider/Imageprovider.dart';
import 'package:wanderlust/Provider/Notifications_Provider.dart';
import 'package:wanderlust/Provider/SelectDateProvider.dart';
import 'package:wanderlust/Provider/Serch_Provider.dart';
import 'package:wanderlust/Provider/Services_Edite_Provider.dart';
import 'package:wanderlust/Provider/Services_Provider.dart';
import 'package:wanderlust/Provider/TypeTrip_Provider.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';
import 'package:wanderlust/Routs.dart';
import 'package:wanderlust/MyTheme.dart';
import 'package:wanderlust/locale/local.dart';
import 'package:wanderlust/locale/local_controller.dart';
import 'Provider/BottomNavBar_Provider.dart';
import 'Provider/Seasons_Provider.dart';
import 'Provider/imageprofile.dart';
import 'Provider/trip_Provider.dart';


SharedPreferences? lang;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  lang = await SharedPreferences.getInstance();
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BottomNavBar_Provider(),),
      ChangeNotifierProvider(create: (context) => SelectDate(),),
      ChangeNotifierProvider(create: (context) => Activitys_Provider(),),
      ChangeNotifierProvider(create: (context) => Services_Provider(),),
      ChangeNotifierProvider(create: (context) => Activitys_Edite_Provider(),),
      ChangeNotifierProvider(create: (context) => Services_Edite_Provider(),),
      ChangeNotifierProvider(create: (context) => CheeckEdite(),),
      ChangeNotifierProvider(create: (context) => Imageprovider(),),
      ChangeNotifierProvider(create: (context) => imageprofile(),),
      ChangeNotifierProvider(create: (context) => WalletProvider(),),
      ChangeNotifierProvider(create: (context) => TypeTrip_Provider(),),
      ChangeNotifierProvider(create: (context) => Seasons_Provider(),),
      ChangeNotifierProvider(create: (context) => AllTrips_Provider(),),
      ChangeNotifierProvider(create: (context) => Trips_Provider(),),
      ChangeNotifierProvider(create: (context) => SerchProvider()..clean(),),
      ChangeNotifierProvider(create: (context) => Fav_provider()..clear(),),
      ChangeNotifierProvider(create: (context) => Notifications_Provider()..clear(),),
    ],
      child: MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  localeController loc = Get.put(localeController(), permanent: true);
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    localeController loc = Get.put(localeController(), permanent: true);
    return GetMaterialApp.router(
      translations: MyLocal(),
      locale: loc.init,
      title: 'Flutter Demo',
      theme: MyCoustoumTheem.MyTheme,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
