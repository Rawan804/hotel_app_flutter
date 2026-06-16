sealed class LeaveRequestState {}

class LeaveRequestStateInitial extends LeaveRequestState {

}

class LeaveRequestLoading extends LeaveRequestState {}

class LeaveRequestSuccess extends LeaveRequestState {
  final String message;
  LeaveRequestSuccess(this.message);
}

class LeaveRequestFailure extends LeaveRequestState {
  final String message;
  LeaveRequestFailure(this.message);
}