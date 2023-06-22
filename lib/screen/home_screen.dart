import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal;
import 'package:overlay_support/overlay_support.dart';
import 'package:test_flutter_ver1/common_widget/common_widget.dart';
import 'package:test_flutter_ver1/constants/constants.dart';
import 'package:test_flutter_ver1/extensions/extensions.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:random_password_generator/random_password_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;

  double _numberCharPassword = 8;

  final newPassword = TextEditingController();
  Color _color = AppThemes.black;
  String isOk = 'Input your password or generate password';
  final _passwordLength = TextEditingController();
  final password = RandomPasswordGenerator();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Product> productList = [];
    try {
      productList = await Purchases.getProducts(
        [
          'donate_1k',
          'donate_2k',
          'donate_5k',
          'donate_10k',
          'donate_20k',
          'donate_50k',
          'donate_100k',
          'donate_200k',
          'donate_500k',
          'donate_1000k',
          'donate_2000k',
          'donate_5000k',
        ],
        type: PurchaseType.inapp,
        // productCategory: ProductCategory.nonSubscription,
      );
      productList.sort(
        (a, b) {
          return a.price.compareTo(b.price);
        },
      );
      debugPrint('tesss $productList');
    } on PlatformException catch (e) {
      debugPrint(e.stacktrace);
    }

    if (!mounted) return;

    setState(() {
      products = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Random Password Generator',
          style: AppThemes.headline2.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Gap.h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Rules', style: AppThemes.headline3),
              ),
            ),
            Gap.h8,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CheckBoxWidget(
                    name: 'Upper Case',
                    value: _isWithUppercase,
                    onTap: (value) {
                      if (value != null) {
                        setState(() {
                          _isWithUppercase = value;
                        });
                      }
                    },
                  ),
                  CheckBoxWidget(
                    name: 'Letters',
                    value: _isWithLetters,
                    onTap: (value) {
                      if (value != null) {
                        setState(() {
                          _isWithLetters = value;
                        });
                      }
                    },
                  ),
                  CheckBoxWidget(
                    name: 'Symbols',
                    value: _isWithSpecial,
                    onTap: (value) {
                      if (value != null) {
                        setState(() {
                          _isWithSpecial = value;
                        });
                      }
                    },
                  ),
                  Gap.h20,
                  CheckBoxWidget(
                    name: 'Numbers',
                    value: _isWithNumbers,
                    onTap: (value) {
                      if (value != null) {
                        setState(() {
                          _isWithNumbers = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Gap.h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
              child: InputTextField(
                controller: _passwordLength,
                labelText: 'Length Password',
                hintText: 'How long your password?',
                onChanged: (value) {},
                keyboardType: TextInputType.number,
              ),
            ),
            Gap.h20,
            ElevatedButton(
              onPressed: () {
                if (_passwordLength.text.trim().isNotEmpty) {
                  _numberCharPassword =
                      double.tryParse(_passwordLength.text.trim()) ?? 0;
                }
                newPassword.text = password.randomPassword(
                    _isWithLetters,
                    _isWithUppercase,
                    _isWithNumbers,
                    _isWithSpecial,
                    _numberCharPassword);

                debugPrint(newPassword.text);
                checkPassword();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Generate Password',
                style: AppThemes.headline3.white,
              ),
            ),
            Gap.h40,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isOk,
                    style: AppThemes.headline3.copyWith(
                      color: _color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          hintText: 'Result',
                          onChanged: (value) {
                            checkPassword();
                          },
                          controller: newPassword,
                        ),
                      ),
                      Gap.w8,
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: newPassword.text),
                          );
                          toast('Copied to Clipboard');
                        },
                        child: const Icon(
                          Icons.copy_rounded,
                          color: AppThemes.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                modal.showCupertinoModalBottomSheet(
                  context: context,
                  expand: false,
                  enableDrag: true,
                  topRadius: const Radius.circular(20),
                  builder: (context) => Material(
                    child: SafeArea(
                      top: false,
                      child: CupertinoScrollbar(
                        child: ListView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ListTile(
                              title: Text(
                                product.title.replaceAll('(Pass Gen)', ''),
                                style: AppThemes.headline3,
                              ),
                              onTap: () async {
                                try {
                                  await Purchases.purchaseProduct(product.identifier);
                                } on PlatformException catch (e) {
                                  final errorCode =
                                      PurchasesErrorHelper.getErrorCode(e);
                                  if (errorCode ==
                                      PurchasesErrorCode
                                          .purchaseCancelledError) {
                                    Snackbar.show(context,
                                        msg: 'User cancel purchases');
                                    return;
                                  } else if (errorCode ==
                                      PurchasesErrorCode
                                          .purchaseNotAllowedError) {
                                    Snackbar.show(context,
                                        msg: 'Purchases not allowed');
                                  } else if (errorCode ==
                                      PurchasesErrorCode.paymentPendingError) {
                                    Snackbar.show(context,
                                        msg: 'Purchases is pending');
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Donate Me!',
                style: AppThemes.headline3.white,
              ),
            ),
            Gap.h20,
          ],
        ),
      ),
    );
  }

  void checkPassword() {
    if (newPassword.text.isEmpty) {
      _color = AppThemes.black;
      isOk = 'Input your password or generate password';
      setState(() {});
      return;
    }
    double passwordstrength =
        password.checkPassword( newPassword.text);
    if (passwordstrength < 0.3) {
      _color = Colors.red;
      isOk = 'This password is weak!';
    } else if (passwordstrength < 0.7) {
      _color = Colors.blue;
      isOk = 'This password is Good';
    } else {
      _color = Colors.green;
      isOk = 'This passsword is Strong';
    }
    setState(() {});
  }
}
