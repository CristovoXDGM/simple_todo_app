import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/di/setup_dependecy_injection.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_states.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/stores/todo_store.dart';
import 'package:simple_simple_todo/src/features/todo/presentation/widgets/tasks_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: ValueListenableBuilder(
          valueListenable: todoStore,
          builder: (context, value, child) {
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
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: sizer.height * 0.35,
                    width: sizer.width,
                    child: value is LoadingGetToDoStoreState
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: todoStore.notCompletedTaskList,
                            builder: (context, value, child) {
                              return TasksList(
                                toDos: value,
                              );
                            }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      20,
                    ),
                    child: Text("completed".toUpperCase()),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: sizer.height * 0.35,
                    width: sizer.width,
                    child: value is LoadingGetToDoStoreState
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
