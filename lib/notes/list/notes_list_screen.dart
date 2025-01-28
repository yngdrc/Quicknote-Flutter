import 'package:flutter/material.dart';
import 'package:quicknote/navigation/navigation_screen.dart';
import 'package:quicknote/notes/list/note_model.dart';
import 'package:quicknote/notes/widgets_notes.dart';

class NotesListScreen extends StatefulWidget implements NavigationScreen {
  const NotesListScreen({super.key, required this.navigateTo});

  @override
  final Destination destination = DrawerDestination.notesList;

  @override
  final Function(Destination) navigateTo;

  @override
  State<StatefulWidget> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<NoteModel> notes = List.empty(growable: true);
  final ScrollController scrollController = ScrollController();

  bool onScrollEndNotification(ScrollEndNotification notification) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadItems();
    }

    return false;
  }

  Future<void> onRefresh() async {
    notes.clear();
    loadItems();
  }

  void onFabPressed() {
    widget.navigateTo(NoteDestination.createNote);
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() {
    final skip = notes.length;
    final newNotes = Iterable.generate(20, (index) {
      return NoteModel(
        title: "Dummy note ${index + skip} title",
        content: "Dummy note ${index + skip} content",
      );
    });

    setState(() {
      notes.addAll(newNotes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        child: const Icon(Icons.add),
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) => onScrollEndNotification(notification),
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: GestureDetector(
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    NoteListItem(
                      note: notes[index],
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
