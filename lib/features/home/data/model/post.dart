// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    String? status;
    List<PostItem>? data;
    dynamic info;

    Post({
        this.status,
        this.data,
        this.info,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        status: json["status"],
        data: json["data"] == null ? [] : List<PostItem>.from(json["data"]!.map((x) => PostItem.fromJson(x))),
        info: json["info"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "info": info,
    };
}

class PostItem {
    int? id;
    String? message;
    String? videoUrl;
    dynamic image;
    int? likes;
    DateTime? createdDate;

    PostItem({
        this.id,
        this.message,
        this.videoUrl,
        this.image,
        this.likes,
        this.createdDate,
    });

    factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
        id: json["id"],
        message: json["message"],
        videoUrl: json["videoUrl"],
        image: json["image"],
        likes: json["likes"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "videoUrl": videoUrl,
        "image": image,
        "likes": likes,
        "createdDate": createdDate?.toIso8601String(),
    };
}
