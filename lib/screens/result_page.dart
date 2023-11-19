import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calcemi/screens/about_page.dart';
import 'package:pie_chart/pie_chart.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(
      {super.key,
      this.principalAmount,
      this.interestRate,
      this.processingFee,
      this.downPayment,
      this.tenure});

  final String? principalAmount;
  final String? interestRate;
  final String? processingFee;
  final String? downPayment;
  final String? tenure;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late double emi;
  @override
  Widget build(BuildContext context) {
    double actualPrincipalAmount = double.parse(widget.principalAmount!) -
        double.parse(widget.downPayment!);
    double totalPayment =
        double.parse(calculateEMI()) * double.parse(widget.tenure!);
    double totalInterest = totalPayment - actualPrincipalAmount;
    double processingFee = double.parse(widget.processingFee!) /
        100 *
        double.parse(widget.principalAmount!);
    Map<String, double> dataMap = {
      "Principal Amount": double.parse(widget.principalAmount!),
      "Total Payment": totalPayment,
      "Processing Fee": processingFee,
      "Total Interest Payable": totalInterest,
      "Down Payment": double.parse(widget.downPayment!),
    };
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                centerTitle: true,
                title: const Text('Details'),
                actions: [
                  IconButton(
                    iconSize: 23,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()));
                    },
                    icon: const Icon(CupertinoIcons.ellipsis_vertical),
                  ),
                ]),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 60)),
                      const Text('EMI',
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        calculateTenure(),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      Text(
                        calculateEMI(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      const Text(
                        'Total Payment',
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        totalPayment.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      const Text(
                        'Total Interest Payable',
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        totalInterest.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      const Text(
                        'Processing Fee',
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        processingFee.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 80)),
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 50,
                        chartRadius: MediaQuery.of(context).size.width / 1.5,
                        colorList: const [
                          Colors.red,
                          Colors.green,
                          Colors.blue,
                          Colors.yellow,
                          Colors.purple,
                        ],
                        initialAngleInDegree: 0,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: true,
                          decimalPlaces: 2,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(35, 70, 35, 0),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Note: The above values are approximate and may vary from the actual values.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 25)),
                      const Text(
                        "Note: Down Payment is not included in EMI",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 80)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String calculateEMI() {
    double principalAmount = double.parse(widget.principalAmount!);
    double interestRate = double.parse(widget.interestRate!);
    double processingFee = double.parse(widget.processingFee!);
    double downPayment = double.parse(widget.downPayment!);
    double tenure = double.parse(widget.tenure!);

    principalAmount = principalAmount - downPayment;
    interestRate = interestRate / 12 / 100;
    processingFee = processingFee / 100;

    emi = (principalAmount * interestRate) *
        (pow(1 + interestRate, tenure) / (pow(1 + interestRate, tenure) - 1));

    return emi.toStringAsFixed(2);
  }

  String calculateTenure() {
    double tenure = double.parse(widget.tenure!);
    double years = tenure / 12;
    double months = tenure % 12;
    if ((years == 0 || years == 1) && (months == 0 || months == 1)) {
      return '${years.toStringAsFixed(0)} year ${months.toStringAsFixed(0)} month';
    } else if ((years == 0 || years == 1) && months > 1) {
      return '${years.toStringAsFixed(0)} year ${months.toStringAsFixed(0)} months';
    } else if (years > 1 && (months == 0 || months == 1)) {
      return '${years.toStringAsFixed(0)} years ${months.toStringAsFixed(0)} month';
    } else {
      return '${years.toStringAsFixed(0)} years ${months.toStringAsFixed(0)} months';
    }
  }
}
