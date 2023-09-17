import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dayagram/core/client/result.dart';
import 'package:dayagram/features/upload/data/model/upload.dart';
import 'package:dayagram/features/upload/data/repositories/upload_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial()) {
    on<UploadPost>(_uploadPost);
  }
  
  Future _uploadPost(UploadPost event, Emitter<UploadState> emit) async {
    emit(UploadLoading());
    try {
      
      Result<Upload> result = await UploadRepository.uploadCoverPodcast(
          message: event.message, image: event.image, videoUrl: event.videoUrl);
      if (result.type == ResultType.Success) {
        emit(UploadSuccess());
      }

      if (result.data?.status == ResultType.Error.value) {
        emit(UploadError(message: result.data?.info));
      }
    } on DioError catch (e) {
      var dataMap = jsonDecode(e.response?.data);
      var message = dataMap['info']['message'];
      emit(UploadError(message: message));
    }
  }
}
