part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {}

final class HomeLoadMore extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  final int? statusCode;

  const HomeError({required this.message, this.statusCode});
}
