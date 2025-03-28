abstract class ToDoStoreState {}

class InitalToDoStoreStateState extends ToDoStoreState {}

class LoadingToDoStoreState extends ToDoStoreState {}

class SuccessToDoStoreState extends ToDoStoreState {
  SuccessToDoStoreState();
}

class FailureToDoStoreState extends ToDoStoreState {}
