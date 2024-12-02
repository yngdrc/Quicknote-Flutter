import 'package:flutter/material.dart';
import 'package:quicknote/navigation/navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NavigationScreen _currentScreen = Destination.notesList.navigationScreen;

  void onLeadingActionClicked() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void onDestinationSelected(int index) {
    final destination = getDestinationByIndex(index);
    if (destination == null || _currentScreen.destination == destination) {
      return;
    }

    setState(() => _currentScreen = destination.navigationScreen);
  }

  Future<void> onFabPressed() {
    // TODO navigate to note form
    throw UnimplementedError();
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
          onPressed: onLeadingActionClicked,
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: NavigationDrawer(
        onDestinationSelected: (index) => onDestinationSelected(index),
        selectedIndex: _currentScreen.destination.index,
        children: [
          ...Destination.values.map(
            (destination) {
              return NavigationDrawerDestination(
                icon: Icon(destination.iconData),
                label: Text(destination.name),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        child: const Icon(Icons.add),
      ),
      body: _currentScreen,
    );
  }
}
