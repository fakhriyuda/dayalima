part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends HomeEvent {}

class LoadMore extends HomeEvent {}
