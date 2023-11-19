import 'package:calcemi/screens/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var answer = '';
  Offset offset = Offset.zero;

  final List<String> buttons = [
    'AC',
    '%',
    '/',
    'x',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    'DEL',
    '+/-',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CupertinoNavigationBar(
              leading: IconButton(
                iconSize: 23,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back, color: Colors.black),
              ),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              middle: const Text('Calculator'),
              trailing: IconButton(
                iconSize: 23,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()));
                },
                icon: const Icon(CupertinoIcons.ellipsis_vertical,
                    color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 100, 20, 0),
                    alignment: Alignment.centerRight,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 250),
                      offset: offset,
                      curve: Curves.easeInOut,
                      child: Text(
                        userInput,
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: AnimatedSlide(
                      offset: offset,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: MediaQuery.of(context).size.height * 0.001,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: GridView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      child: Text(
                        'AC',
                        style: TextStyle(
                          color: Colors.orange[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return MaterialButton(
                      onPressed: percentPressed,
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.percent,
                        size: 25,
                      ),
                    );
                  } else if (index == 2) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.divide,
                        size: 25,
                      ),
                    );
                  } else if (index == 3) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.multiply,
                        size: 25,
                      ),
                    );
                  } else if (index == 7) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.minus,
                        size: 25,
                      ),
                    );
                  } else if (index == 11) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.add,
                        size: 25,
                      ),
                    );
                  } else if (index == 15) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        Icons.backspace_outlined,
                        size: 25,
                      ),
                    );
                  } else if (index == 16) {
                    return MaterialButton(
                      onPressed: () {
                        try {
                          if (double.parse(userInput) > 0) {
                            setState(() {
                              userInput = '-$userInput';
                            });
                          } else {
                            setState(() {
                              userInput = userInput.substring(1);
                            });
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Icon(
                        color: Colors.orange[600],
                        CupertinoIcons.plus_slash_minus,
                        size: 25,
                      ),
                    );
                  } else if (index == 18) {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                          if (userInput[userInput.length - 1] == '.') {
                            userInput += '.0';
                          }
                        });
                      },
                      child: Text(
                        '.',
                        style: TextStyle(
                          color: Colors.orange[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (index == 19) {
                    return Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.orange[600],
                        shape: BoxShape.circle,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        child: const Text(
                          '=',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return MaterialButton(
                      onPressed: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      child: Text(
                        buttons[index],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void percentPressed() {
    String finaluserinput = "";
    for (int i = userInput.length - 1; i >= 0; i--) {
      if (isOperator(userInput[i])) {
        break;
      }
      finaluserinput += userInput[i];
    }
    userInput = finaluserinput.split('').reversed.join('');
    setState(() {
      try {
        double d = double.parse(userInput);
        d /= 100.0;
        userInput = d.toStringAsPrecision(d.toString().length);
        answer = userInput;
      } catch (e) {
        userInput += '-NaN';
      }
    });
  }

  void replace(String x) {
    setState(() {
      userInput = userInput.substring(0, userInput.length - 1);
      userInput += x;
    });
  }

  bool isOperator(String x) {
    if (x == '/' || x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    setState(() {
      offset = Offset(offset.dx, -1.5);
    });
    try {
      Parser p = Parser();
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = 'Error';
    }
  }
}
