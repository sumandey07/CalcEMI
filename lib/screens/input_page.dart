import 'package:calcemi/screens/about_page.dart';
import 'package:calcemi/screens/result_page.dart';
import 'package:calcemi/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var principalAmountController = TextEditingController();
  var interestRateController = TextEditingController();
  var processingFeeController = TextEditingController();
  var downPaymentController = TextEditingController();
  var tenureController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final yearPicker = List<String>.generate(31, (i) => i.toString());
  final monthPicker = List<String>.generate(12, (i) => i.toString());
  int _selectedYear = 10;
  int _selectedMonth = 0;

  @override
  void dispose() {
    principalAmountController.dispose();
    interestRateController.dispose();
    processingFeeController.dispose();
    downPaymentController.dispose();
    tenureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.orange,
            expandedHeight: 160,
            actions: [
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: const EdgeInsets.all(20),
                tooltip: "Click to view more options",
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      height: 60.0,
                      value: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Dark Mode"),
                          CupertinoSwitch(
                            activeColor: Colors.red,
                            value: Provider.of<ThemeProvider>(context,
                                    listen: false)
                                .isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme();
                                value = !value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      padding: const EdgeInsets.only(left: 25),
                      height: 60.0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        );
                      },
                      value: 1,
                      child: const Text("About"),
                    ),
                  ];
                },
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Calculate EMI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$'))
                          ],
                          controller: principalAmountController,
                          style: const TextStyle(fontSize: 14),
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Please enter principal amount';
                            } else if (value.isNotEmpty &&
                                double.parse(value) < 1.0) {
                              return 'Principal amount cannot be less than 1';
                            } else if (value.isNotEmpty &&
                                double.parse(value) > 1000000000.0) {
                              return 'Principal amount cannot be greater than 1 billion';
                            }
                            return null;
                          }),
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty &&
                                double.parse(value) < 10.0) {
                              Fluttertoast.showToast(
                                  msg: "Principal amount cannot be less than 1",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                              value = "";
                            }
                          },
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: "Enter Principal Amount",
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Principal Amount *",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: TextFormField(
                          controller: interestRateController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$'))
                          ],
                          validator: ((value) {
                            if (value!.isEmpty || value == "0") {
                              return 'Please enter annual interest rate';
                            } else if (value.isNotEmpty &&
                                double.parse(value) > 50.0) {
                              value = "";
                              return 'Annual Interest Rate cannot be greater than 50%';
                            }
                            return null;
                          }),
                          style: const TextStyle(fontSize: 14),
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: "Enter Annual Rate",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Interest Rate(in %) *",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        width: 360,
                        child: TextFormField(
                          controller: processingFeeController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$'))
                          ],
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Please enter processing fee if any';
                            } else if (value.isNotEmpty &&
                                double.parse(value) > 20.0) {
                              return 'Processing fee cannot be greater 20%';
                            }
                            return null;
                          }),
                          style: const TextStyle(fontSize: 14),
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: "Enter Processing Fee",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Processing Fee(in %) *",
                          ),
                        ),
                      ),
                      Container(
                        width: 360,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: TextFormField(
                          controller: downPaymentController,
                          validator: ((value) {
                            try {
                              if (value!.isEmpty) {
                                return 'Please enter down payment amount if any';
                              } else if (value.isNotEmpty &&
                                  double.parse(value) >=
                                      double.parse(
                                          principalAmountController.text)) {
                                return 'Down payment amount cannot be equal or greater than principal amount';
                              }
                              return null;
                            } catch (e) {
                              return 'Please enter down payment amount if any';
                            }
                          }),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 14),
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*$'))
                          ],
                          decoration: const InputDecoration(
                            hintText: "Enter Down Payment Amount",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Down Payment *",
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      InkWell(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                  ),
                                  Text("Tenure"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    height: 20,
                                    child: Marquee(
                                      text: selectedTenure(),
                                      pauseAfterRound:
                                          const Duration(seconds: 1),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 20.0,
                                      velocity: 80.0,
                                      accelerationDuration:
                                          const Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          const Duration(seconds: 1),
                                      decelerationCurve: Curves.easeOut,
                                    ),
                                  ),
                                  const Icon(CupertinoIcons.chevron_right),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 30),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet<double>(
                            useSafeArea: true,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            constraints: BoxConstraints(
                              maxHeight: 380,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "Loan Tenure",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Years",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30)),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                height: 190,
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  controller:
                                                      FixedExtentScrollController(
                                                          initialItem: 10),
                                                  onSelectedItemChanged:
                                                      (value) => {
                                                    setState(() {
                                                      _selectedYear = value;
                                                    }),
                                                  },
                                                  overAndUnderCenterOpacity:
                                                      0.7,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemExtent: 75,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                    builder: (context, index) {
                                                      return ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 38),
                                                        dense: false,
                                                        title: Text(
                                                            yearPicker[index],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 22,
                                                            )),
                                                      );
                                                    },
                                                    childCount:
                                                        yearPicker.length,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20)),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Months",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30)),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                height: 190,
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  onSelectedItemChanged:
                                                      (value) => {
                                                    setState(() {
                                                      _selectedMonth = value;
                                                    })
                                                  },
                                                  overAndUnderCenterOpacity:
                                                      0.7,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemExtent: 75,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                    builder: (context, index) {
                                                      return ListTile(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 38),
                                                        dense: false,
                                                        title: Text(
                                                            selectionColor:
                                                                Colors
                                                                    .blue[600],
                                                            monthPicker[index],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 22,
                                                            )),
                                                      );
                                                    },
                                                    childCount:
                                                        monthPicker.length,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MaterialButton(
                                            color: Colors.grey[200],
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50.0,
                                                vertical: 12.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          MaterialButton(
                                            textColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 70.0,
                                                vertical: 12.0),
                                            onPressed: () {
                                              if (_selectedYear == 0 &&
                                                  _selectedMonth == 0) {
                                                _selectedYear = 10;
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please select loan tenure",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                                              } else {
                                                Navigator.pop(
                                                    context,
                                                    ((_selectedYear * 12) +
                                                            _selectedMonth)
                                                        .toDouble());
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            color: Colors.blue,
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 0),
                        child: Divider(
                          indent: 30,
                          endIndent: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 90, 0, 50),
                        child: MaterialButton(
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.orange[700],
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                    principalAmount: principalAmountController
                                        .text
                                        .toString(),
                                    interestRate:
                                        interestRateController.text.toString(),
                                    processingFee:
                                        processingFeeController.text.toString(),
                                    downPayment:
                                        downPaymentController.text.toString(),
                                    tenure:
                                        ((_selectedYear * 12) + _selectedMonth)
                                            .toString(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text("Calculate"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String selectedTenure() {
    if (_selectedYear == 0 && _selectedMonth == 0) {
      return "10 years and 0 month";
    } else if ((_selectedYear == 0 || _selectedYear == 1) &&
        (_selectedMonth == 0 || _selectedMonth == 1)) {
      return "$_selectedYear year and $_selectedMonth month";
    } else if (_selectedYear > 1 &&
        (_selectedMonth == 0 || _selectedMonth == 1)) {
      return "$_selectedYear years and $_selectedMonth month";
    } else if ((_selectedYear == 0 || _selectedYear == 1) &&
        _selectedMonth > 1) {
      return "$_selectedYear year and $_selectedMonth months";
    } else {
      return "$_selectedYear years and $_selectedMonth months";
    }
  }
}
