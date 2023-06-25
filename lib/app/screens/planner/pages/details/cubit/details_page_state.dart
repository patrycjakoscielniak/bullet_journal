part of 'details_page_cubit.dart';

@immutable
class DetailsPageState {
  const DetailsPageState({this.errorMessage, this.status = Status.initial});
  final String? errorMessage;
  final Status status;
}
