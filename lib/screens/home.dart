import 'package:flutter/material.dart';
import 'package:todoapp/constant/color.dart';
import 'package:todoapp/models/ToDoItems.dart';
import 'package:todoapp/widget/todo_item.dart';
import 'package:todoapp/utils/scrollbehavior/no_flow_Scroll_behavior.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todoList = ToDo.todoList();
  List<ToDo> _searchResult = [];
  final _addItemController = TextEditingController();

  @override
  void initState() {
    _searchResult = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            searchBoxWidget(),
            allToDosText(),
            todoItemsWidget(),
            addNewItemWidget(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
          ],
        ),
      );

  Widget searchBoxWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) => _filterList(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
          ),
        ),
      );

  Widget allToDosText() => Container(
        margin: const EdgeInsets.only(top: 50, bottom: 30),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'All ToDos',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Widget todoItemsWidget() => Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: _searchResult.length,
          itemBuilder: (context, index) {
            final todo = _searchResult[index];
            return ToDoItem(
              toDo: todo,
              onItemClicked: _handleToDoClicked,
              onDeleteClicked: _handleDeleteItem,
            );
          },
        ),
      ),
  );

  Widget addNewItemWidget() => Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _addItemController,
                decoration: InputDecoration(
                  hintText: 'Add new Todo Item',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 25),
            child: ElevatedButton(
              onPressed: () {
                _addTodoItem(_addItemController.text);
                FocusScope.of(context).unfocus();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  minimumSize: const Size(60, 60),
                  elevation: 100),
              child: const Text(
                '+',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      );

  void _handleToDoClicked(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String item) {
    setState(() {
      todoList.insert(
          0,
          ToDo(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              todoText: item));
    });
    _addItemController.clear();
  }

  void _filterList(String keyword) {
    List<ToDo> results = [];
    if (keyword.isNotEmpty) {
      results = todoList.where((item) => item.todoText.toLowerCase().contains(keyword.toLowerCase())).toList();
    } else {
      results = todoList;
    }

    setState(() {
      _searchResult = results;
    });
  }
}
