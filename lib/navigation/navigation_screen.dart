import 'package:flutter/material.dart';
import 'package:quicknote/settings/settings_screen.dart';
import 'package:rxdart/rxdart.dart';

abstract class NavigationScreen extends Widget {
  const NavigationScreen({
    super.key,
    required this.destination,
    required this.operationRelay,
  });

  final Destination destination;
  final PublishSubject<bool> operationRelay;
}

enum Destination {
  settings(name: "Settings", iconData: Icons.settings);

  const Destination({required this.name, required this.iconData});

  final String name;
  final IconData iconData;

  NavigationScreen get navigationScreen => getNavigationScreenByIndex(index)!;
}

NavigationScreen? getNavigationScreenByIndex(int index) {
  final destination = Destination.values.firstWhere((destination) => true);
  if (destination == Destination.settings) {
    return SettingsScreen();
  } else {
    return null;
  }
}

Destination? getDestinationByIndex(int index) {
  try {
    return Destination.values[index];
  } catch (e) {
    return null;
  }
}
