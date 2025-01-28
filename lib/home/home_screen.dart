import 'package:flutter/material.dart';
import 'package:quicknote/navigation/navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  Destination _currentDestination = DrawerDestination.notesList;

  void _onLeadingActionClicked() {
    if (_navigatorKey.currentState?.canPop() != true) {
      return _scaffoldKey.currentState!.openDrawer();
    }

    final currentDestination = _currentDestination;
    if (currentDestination is ChildDestination) {
      setState(
              () => _currentDestination = currentDestination.parentDestination);
    }

    return _navigatorKey.currentState?.pop();
  }

  void _onDestinationSelected(int index) {
    final destination = DrawerDestination.values[index];
    navigateTo(destination);
  }

  void navigateTo(Destination destination) {
    if (_currentDestination == destination) {
      return;
    }

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => destination.getNavigationScreen(navigateTo),
    );

    if (destination is DrawerDestination) {
      _navigatorKey.currentState?.pushAndRemoveUntil(
        route,
        (route) => false,
      );
    } else if (destination is ChildDestination) {
      _navigatorKey.currentState?.push(
        route,
      );
    }

    setState(() => _currentDestination = destination);
  }

  int? _getSelectedDrawerDestinationIndex(Destination currentDestination) {
    if (currentDestination is DrawerDestination) {
      return currentDestination.index;
    } else if (currentDestination is ChildDestination) {
      return currentDestination.drawerDestination.index;
    } else {
      return null;
    }
  }

  bool _canNavigateBack() {
    return _navigatorKey.currentState?.canPop() == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _currentDestination.name,
        ),
        leading: IconButton(
          onPressed: _onLeadingActionClicked,
          icon: Icon(
            _canNavigateBack() ? Icons.chevron_left : Icons.menu,
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: NavigationDrawer(
        onDestinationSelected: (index) => _onDestinationSelected(index),
        selectedIndex: _getSelectedDrawerDestinationIndex(_currentDestination),
        children: [
          ...DrawerDestination.values.map(
            (destination) {
              return NavigationDrawerDestination(
                icon: Icon(destination.iconData),
                label: Text(destination.name),
              );
            },
          ),
        ],
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) =>
                _currentDestination.getNavigationScreen(navigateTo),
            settings: settings,
          );
        },
      ),
    );
  }
}
