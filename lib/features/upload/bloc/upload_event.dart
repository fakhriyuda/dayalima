part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}


class UploadPost extends UploadEvent {
  final String? message;
  final File? image;
  final String? videoUrl;
  
  const UploadPost({this.message,this.image,this.videoUrl});

  @override
  List<Object> get props => [message!,image!,videoUrl!];
}