// To parse this JSON data, do
//
//     final submit = submitFromJson(jsonString);

import 'dart:convert';

Upload uploadFromJson(String str) => Upload.fromJson(json.decode(str));

String uploadToJson(Upload data) => json.encode(data.toJson());

class Upload {
    String? status;
    String? data;
    dynamic info;

    Upload({
        this.status,
        this.data,
        this.info,
    });

    factory Upload.fromJson(Map<String, dynamic> json) => Upload(
        status: json["status"],
        data: json["data"],
        info: json["info"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "info": info,
    };
}
