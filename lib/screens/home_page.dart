import 'package:calcemi/screens/calculator.dart';
import 'package:calcemi/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calcemi/screens/about_page.dart';
import 'package:provider/provider.dart';
import 'package:calcemi/screens/input_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        key: scaffoldKey,
        shadowColor: Colors.blueGrey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'CalcEMI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(CupertinoIcons.home),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
              leading: const Icon(CupertinoIcons.info_circle_fill),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                title: const Text('Change Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.amber[200],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
              centerTitle: true,
              title: Text(
                'CalcEMI',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            collapsedHeight: 100,
            floating: true,
            snap: true,
            expandedHeight: 200,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
                  child: MaterialButton(
                    height: 60,
                    textColor: Colors.white,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InputPage()),
                      );
                    },
                    child: const Text("Open EMI Calculator"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  child: MaterialButton(
                    height: 60,
                    textColor: Colors.white,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Calculator()),
                      );
                    },
                    child: const Text("Open Calculator"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            activeIcon: const Icon(Icons.home_rounded),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: 'About',
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
        onTap: (valueKey) {
          if (valueKey == 0) {
            return;
          } else if (valueKey == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
