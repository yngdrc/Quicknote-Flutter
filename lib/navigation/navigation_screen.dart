import 'package:flutter/material.dart';
import 'package:quicknote/notes/form/notes_form_screen.dart';
import 'package:quicknote/settings/settings_screen.dart';

import '../notes/list/notes_list_screen.dart';

abstract class NavigationScreen extends Widget {
  const NavigationScreen(
      {super.key, required this.destination, required this.navigateTo});

  final Destination destination;
  final Function(Destination) navigateTo;
}

abstract class Destination {
  const Destination({required this.name});

  final String name;

  NavigationScreen getNavigationScreen(Function(Destination) navigateTo);
}

enum DrawerDestination implements Destination {
  notesList(name: "Notes", iconData: Icons.notes),
  settings(name: "Settings", iconData: Icons.settings);

  const DrawerDestination({required this.name, required this.iconData});

  @override
  final String name;
  final IconData iconData;

  @override
  NavigationScreen getNavigationScreen(Function(Destination) navigateTo) {
    switch (this) {
      case DrawerDestination.notesList:
        return NotesListScreen(
          navigateTo: navigateTo,
        );

      case DrawerDestination.settings:
        return SettingsScreen(
          navigateTo: navigateTo,
        );
    }
  }
}

abstract class ChildDestination implements Destination {
  const ChildDestination(
      {required this.name,
      required this.drawerDestination,
      required this.parentDestination});

  @override
  final String name;
  final DrawerDestination drawerDestination;
  final Destination parentDestination;
}

enum NoteDestination implements ChildDestination {
  createNote(name: "Create a note");

  const NoteDestination({required this.name});

  @override
  final String name;

  @override
  final DrawerDestination drawerDestination = DrawerDestination.notesList;

  @override
  final Destination parentDestination = DrawerDestination.notesList;

  @override
  NavigationScreen getNavigationScreen(Function(Destination) navigateTo) {
    switch (this) {
      case NoteDestination.createNote:
        return NotesFormScreen(
          navigateTo: navigateTo,
        );
    }
  }
}
