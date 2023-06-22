import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:test_flutter_ver1/constants/constants.dart';
import 'package:test_flutter_ver1/screen/home_screen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  await _configureSDK();
  runApp(const PassGenApp());
}

Future<void> _configureSDK() async {
  await Purchases.setDebugLogsEnabled(true);

    await Purchases.setup(apiKey);
  // PurchasesConfiguration configuration = PurchasesConfiguration(apiKey);
  // await Purchases.configure(configuration);
}

class PassGenApp extends StatefulWidget {
  const PassGenApp({key});

  @override
  State<PassGenApp> createState() => _PassGenAppState();
}

class _PassGenAppState extends State<PassGenApp> {
  // CustomerInfo? _customerInfo;

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   final customerInfo = await Purchases.getCustomerInfo();
  //   final payment = await Purchases.canMakePayments();

  //   if (payment) {
  //     debugPrint('Can make payment $payment');
  //   } else {
  //     debugPrint('Can\'t make payment');
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _customerInfo = customerInfo;
  //   });
  //   debugPrint(_customerInfo?.entitlements.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pass Gen',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFEFEFE),
          primarySwatch: AppThemes.primarySwatch,
        ),
        home: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
