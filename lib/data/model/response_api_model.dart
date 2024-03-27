class ResponseApiModel {
  final List<Datum> data;
  final int status;

  ResponseApiModel({
    required this.data,
    required this.status,
  });

  factory ResponseApiModel.fromJson(Map<String, dynamic> json) =>
      ResponseApiModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  final int id;
  final String title;
  final String description;
  final String banner;
  final String logo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Playlist> playlist;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.banner,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.playlist,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        banner: json["banner"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        playlist: List<Playlist>.from(
            json["playlist"].map((x) => Playlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "banner": banner,
        "logo": logo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "playlist": List<dynamic>.from(playlist.map((x) => x.toJson())),
      };
}

class Playlist {
  final int id;
  final int dirId;
  final String title;
  final String description;
  final String url;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Playlist({
    required this.id,
    required this.dirId,
    required this.title,
    required this.description,
    required this.url,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        dirId: json["dir_id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dir_id": dirId,
        "title": title,
        "description": description,
        "url": url,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
