abstract class GetToDoStoreState {}

class InitalGetToDoStoreState extends GetToDoStoreState {}

class LoadingGetToDoStoreState extends GetToDoStoreState {}

class SuccessGetToDoStoreState extends GetToDoStoreState {
  SuccessGetToDoStoreState();
}

class FailureGetToDoStoreState extends GetToDoStoreState {}
