import 'package:flutter/material.dart';
import 'package:todo_list_app/components/text_styles.dart';

import '../components/app_colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundTodo = [];
  String _lastSearchText = '';

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
            color: AppColors.background,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 80),
            child: Column(
              children: [
                searchBar(),
                // SizedBox(height: 25),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 50, bottom: 25),
                  child: Text(
                    "Your ToDos",
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      color: AppColors.textPrimary,
                      fontSize: 33,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundTodo.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final todo = _foundTodo[index];
                      return TodoItem(
                        todo: todo,
                        onChangedTodo: _handleTodoChange,
                        onDeleteTodo: _onDeleteTodo,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: "Enter your todo item",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_todoController.text.isNotEmpty) {
                        _addTodo(_todoController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(20, 20),
                      elevation: 10,
                      backgroundColor: AppColors.tdCustomeBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (item) => item.todoText!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  void _addTodo(String todoItem) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todoItem,
        ),
      );
    });
    _todoController.clear();
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _onDeleteTodo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
    _runFilter(_lastSearchText);
  }

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: AppColors.textPrimary),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset("assets/images/todo_icon.png", height: 50),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(17),
      ),
      child: TextField(
        onChanged: (value) {
          _lastSearchText = value;

          setState(() {
            _runFilter(value);
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          hintText: "Search",
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textPrimary,
            size: 30,
          ),
          border: InputBorder.none,
          prefixIconConstraints: BoxConstraints(maxHeight: 27, minHeight: 15),
        ),
      ),
    );
  }
}
