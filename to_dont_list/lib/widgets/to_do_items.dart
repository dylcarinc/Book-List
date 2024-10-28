import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/book.dart';

typedef ToDoListChangedCallback = Function(Book item, bool completed);
typedef ToDoListRemovedCallback = Function(Book item);

class BookItem extends StatefulWidget {
  BookItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Book item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed //
        ? Colors.black
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          widget.item.increaseProgress();
        });
      },
      onLongPress: widget.completed
          ? () {
              setState(() {
                widget.onDeleteItem(widget.item);
              });
            }
          : null,
      // Added Icon next to progress button
      // Now when the icon is pressed it will open the edit book dialog
      leading: Row(
        children: [
          CircularProgressIndicator(
              value: widget.item.progress,
              backgroundColor: Colors.black54,
              color: widget.item.isFiction == true ? Colors.red : Colors.green
              //child: Text(item.abbrev()),
              ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Open edit book dialog here when tapped
            },
          ),
        ],
      ),
      title: Text(
        widget.item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
