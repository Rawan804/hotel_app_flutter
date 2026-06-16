sealed class ComplaintsRequestState {}

class ComplaintsRequestInitial extends ComplaintsRequestState {}

class ComplaintsRequestLoading extends ComplaintsRequestState {}

class ComplaintsRequestSuccess extends ComplaintsRequestState {
  final String message;
  ComplaintsRequestSuccess(this.message);
}

class ComplaintsRequestFailure extends ComplaintsRequestState {
  final String message;
  ComplaintsRequestFailure(this.message);
}