import 'package:flutter/material.dart';
import 'package:todoapp/constant/color.dart';
import 'package:todoapp/models/ToDoItems.dart';

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final onItemClicked;
  final onDeleteClicked;

  const ToDoItem(
      {Key? key,
      required this.toDo,
      required this.onItemClicked,
      required this.onDeleteClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          this.onItemClicked(toDo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          toDo.isDone
              ? Icons.check_box
              : Icons.check_box_outline_blank_outlined,
          color: tdBlue,
        ),
        title: Text(
          toDo.todoText,
          style: TextStyle(
              color: tdBlack,
              fontSize: 16,
              decoration: toDo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.zero,
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              onDeleteClicked(toDo.id);
            },
          ),
        ),
      ),
    );
  }
}
