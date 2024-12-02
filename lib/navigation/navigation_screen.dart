import 'package:flutter/material.dart';
import 'package:quicknote/notes/notes_list_screen.dart';
import 'package:quicknote/settings/settings_screen.dart';

abstract class NavigationScreen extends Widget {
  const NavigationScreen({
    super.key,
    required this.destination
  });

  final Destination destination;
}

enum Destination {
  notesList(name: "Notes", iconData: Icons.notes),
  settings(name: "Settings", iconData: Icons.settings);

  const Destination({required this.name, required this.iconData});

  final String name;
  final IconData iconData;

  NavigationScreen get navigationScreen => getNavigationScreenByIndex(index)!;
}

NavigationScreen? getNavigationScreenByIndex(int index) {
  final destination = getDestinationByIndex(index);
  if (destination == Destination.settings) {
    return SettingsScreen();
  } else if (destination == Destination.notesList) {
    return NotesListScreen();
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
