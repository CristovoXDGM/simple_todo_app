import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/constants/app_colors.dart';
import 'package:simple_simple_todo/src/core/di/setup_dependecy_injection.dart';
import 'package:simple_simple_todo/src/features/todo/domain/entities/todo.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_states.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_store.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/widgets/tasks_list.dart';

import '../../../../core/constants/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final todoStore = getIt.get<GetTodoStore>();

  @override
  void initState() {
    super.initState();

    todoStore.getAllToDos();
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            width: sizer.width,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "Search",
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.primaryColor,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      todoStore.addToDo(
                        ToDo(
                          description: searchController.text,
                          completed: false,
                        ),
                      );
                      searchController.clear();

                      todoStore.getAllToDos();
                    },
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.addButtonColor,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: todoStore,
          builder: (context, value, child) {
            final isLoading = value is LoadingToDoStoreState;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      20,
                    ),
                    child: Text(
                      "To do".toUpperCase(),
                      style: titleStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: sizer.height * 0.35,
                    width: sizer.width,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: todoStore.notCompletedTaskList,
                            builder: (context, value, child) {
                              return TasksList(
                                toDos: value,
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      20,
                    ),
                    child: Text(
                      "completed".toUpperCase(),
                      style: titleStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: sizer.height * 0.35,
                    width: sizer.width,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: todoStore.completedTaskList,
                            builder: (context, value, child) {
                              return TasksList(
                                toDos: value,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
