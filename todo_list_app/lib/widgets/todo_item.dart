import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/components/app_colors.dart';

import '../components/text_styles.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onChangedTodo;
  final onDeleteTodo;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onChangedTodo,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onChangedTodo(todo);
        },

        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: AppColors.primary,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: AppColors.tdCustomeBlue,
          size: 27,
        ),
        title: Text(
          todo.todoText ?? '',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.textPrimary,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.tdCustomeBlue,
            decorationThickness: 4,
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.tdRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteTodo(todo.id);
            },
            icon: Icon(CupertinoIcons.delete),
            color: Colors.white,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            ),
          ),
        ),
      ),
    );
  }
}
