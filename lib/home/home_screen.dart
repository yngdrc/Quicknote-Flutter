import 'package:flutter/material.dart';
import 'package:quicknote/navigation/navigation_screen.dart';
import 'package:quicknote/navigation/rx_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late NavigationScreen _currentScreen = Destination.settings.navigationScreen;

  void openDrawer() => _scaffoldKey.currentState!.openDrawer();

  void onDestinationSelected(Destination destination) {
    if (_currentScreen.destination == destination) {
      return;
    }

    setState(() => _currentScreen = destination.navigationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _currentScreen.destination.name,
        ),
        leading: IconButton(
          onPressed: openDrawer,
          icon: const Icon(Icons.menu_rounded),
        ),
        bottom: RxProgressIndicator(
          operationRelay: _currentScreen.operationRelay,
        ),
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: (index) {
          final destination = getDestinationByIndex(index);
          if (destination == null) {
            return;
          }

          onDestinationSelected(destination);
        },
        selectedIndex: _currentScreen.destination.index,
        children: [
          NavigationDrawerDestination(
            icon: Icon(Destination.settings.iconData),
            label: Text(Destination.settings.name),
          ),
        ],
      ),
      body: _currentScreen,
    );
  }
}
