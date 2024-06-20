class Comments {
  String? sId;
  String? content;
  CommentVideo? video;
  CommentOwner? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.sId,
      this.content,
      this.video,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    video =
        json['video'] != null ? new CommentVideo.fromJson(json['video']) : null;
    owner =
        json['owner'] != null ? new CommentOwner.fromJson(json['owner']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CommentVideo {
  String? sId;
  String? videoFile;
  String? thumbnail;
  String? title;
  String? description;
  String? duration;
  int? views;
  bool? isPublished;

  CommentVideo(
      {this.sId,
      this.videoFile,
      this.thumbnail,
      this.title,
      this.description,
      this.duration,
      this.views,
      this.isPublished});

  CommentVideo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoFile = json['videoFile'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    views = json['views'];
    isPublished = json['isPublished'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['videoFile'] = this.videoFile;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['views'] = this.views;
    data['isPublished'] = this.isPublished;
    return data;
  }
}

class CommentOwner {
  String? sId;
  String? username;
  String? email;
  String? fullName;
  String? avatar;

  CommentOwner(
      {this.sId, this.username, this.email, this.fullName, this.avatar});

  CommentOwner.fromJson(Map<String, dynamic> json) {
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
