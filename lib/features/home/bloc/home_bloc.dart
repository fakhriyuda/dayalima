import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dayagram/core/client/result.dart';
import 'package:dayagram/features/home/data/model/post.dart';
import 'package:dayagram/features/home/data/repositories/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetPosts>(_getListPosts);
    on<LoadMore>(_loadMore);

  }

  List<PostItem> listPosts = [];
  int size = 5;
  int page = 1;
  Future _getListPosts(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      Result<Post> result =
          await HomeRepository.getListPosts(size: size, page: page);
      if (result.type == ResultType.Success) {
        listPosts = result.data!.data!;
        page += 1;
        emit(HomeSuccess());
      }

      if (result.data?.status == ResultType.Error.value) {
        emit(HomeError(message: result.data?.info));
      }
    } on DioError catch (e) {
      print(e.toString());
      emit(HomeError(message: e.toString()));
    }
  }

  Future _loadMore(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadMore());
      Result<Post> result =
          await HomeRepository.getListPosts(size: size, page: page);
      if (result.type == ResultType.Success) {
        listPosts.addAll(result.data!.data ?? []);
        if (result.data!.data!.isNotEmpty) {
          page += 1;
        }
        print(result.data!.data);
        emit(HomeSuccess());
      }

      if (result.data?.status == ResultType.Error.value) {
        emit(HomeError(message: result.data?.info));
      }
    } on DioError catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
