import 'package:calcemi/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/sumandey07/CalcEMI');

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.primary,
                floating: true,
                pinned: true,
                snap: true,
                centerTitle: true,
                title: const Text('About')),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 70, 0, 40),
                          child: SizedBox(
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                        const Text(
                          'CalcEMI',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                          ),
                        ),
                        const Text("Version: 0.1.0"),
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              "CalcEMI is a simple EMI calculator app with a basic calculator. It is a free app.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Text("Developed by Suman Dey"),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text("If you like it then give it a star on "),
                        ),
                        MaterialButton(
                          onPressed: _launchURL,
                          child: Provider.of<ThemeProvider>(context, listen: false)
                                  .isDarkMode?Image.asset(
                            'assets/images/github-dark.png',
                            fit: BoxFit.contain,
                            width: 140,
                            height: 140,
                          ):Image.asset(
                            'assets/images/github-light.png',
                            fit: BoxFit.contain,
                            width: 140,
                            height: 140,
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
      ),
    );
  }
}

Future<void> _launchURL() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
