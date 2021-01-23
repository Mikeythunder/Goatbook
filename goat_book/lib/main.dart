import 'package:flutter/material.dart';
import 'package:goat_book/auth.dart';
import './views/account.dart';
import './views/groups.dart';
import './views/queue.dart';
import './views/messaging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

AuthService _authService;

class MyApp extends StatelessWidget {
  // This is the color theme for the whole app
  final ThemeData theme = ThemeData(primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goatbook',
      theme: theme,
      home: NavigationWrapper(),
    );
  }
}

class NavigationWrapper extends StatefulWidget {
  NavigationWrapper();

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;
  static const TextStyle optionsStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _bottomNavOptions = <Widget>[
    // Add each page here!!!!
    MessagingView(),
    GroupsView(),
    QueueView(),
    AccountView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(child: _bottomNavOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messaging',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle),
            label: 'Queue',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(ctx).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
