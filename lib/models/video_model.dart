class Video {
  String? sId;
  String? videoFile;
  String? thumbnail;
  Owner? owner;
  String? title;
  String? description;
  String? duration;
  int? views;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Video(
      {this.sId,
      this.videoFile,
      this.thumbnail,
      this.owner,
      this.title,
      this.description,
      this.duration,
      this.views,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Video.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoFile = json['videoFile'];
    thumbnail = json['thumbnail'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    views = json['views'];
    isPublished = json['isPublished'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['videoFile'] = this.videoFile;
    data['thumbnail'] = this.thumbnail;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['views'] = this.views;
    data['isPublished'] = this.isPublished;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Owner {
  String? sId;
  String? username;
  String? email;
  String? fullName;
  String? avatar;

  Owner({this.sId, this.username, this.email, this.fullName, this.avatar});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    return data;
  }
}
