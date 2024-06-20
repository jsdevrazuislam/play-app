class LikeVideo {
  List<LikesVideo>? likesVideo;
  int? totalLikes;
  int? totalDislikes;

  LikeVideo({this.likesVideo, this.totalLikes, this.totalDislikes});

  LikeVideo.fromJson(Map<String, dynamic> json) {
    if (json['likesVideo'] != null) {
      likesVideo = <LikesVideo>[];
      json['likesVideo'].forEach((v) {
        likesVideo!.add(new LikesVideo.fromJson(v));
      });
    }
    totalLikes = json['totalLikes'];
    totalDislikes = json['totalDislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.likesVideo != null) {
      data['likesVideo'] = this.likesVideo!.map((v) => v.toJson()).toList();
    }
    data['totalLikes'] = this.totalLikes;
    data['totalDislikes'] = this.totalDislikes;
    return data;
  }
}

class LikesVideo {
  String? sId;
  String? video;
  List<LikedBy>? likedBy;
  List<DisLikedBy>? disLikedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LikesVideo(
      {this.sId,
      this.video,
      this.likedBy,
      this.disLikedBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LikesVideo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    video = json['video'];
    if (json['likedBy'] != null) {
      likedBy = <LikedBy>[];
      json['likedBy'].forEach((v) {
        likedBy!.add(new LikedBy.fromJson(v));
      });
    }
    if (json['disLikedBy'] != null) {
      disLikedBy = <DisLikedBy>[];
      json['disLikedBy'].forEach((v) {
        disLikedBy!.add(new DisLikedBy.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['video'] = this.video;
    if (this.likedBy != null) {
      data['likedBy'] = this.likedBy!.map((v) => v.toJson()).toList();
    }
    if (this.disLikedBy != null) {
      data['disLikedBy'] = this.disLikedBy!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class LikedBy {
  String? sId;
  String? username;
  String? email;
  String? fullName;
  String? avatar;

  LikedBy({this.sId, this.username, this.email, this.fullName, this.avatar});

  LikedBy.fromJson(Map<String, dynamic> json) {
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

class DisLikedBy {
  String? sId;
  String? username;
  String? email;
  String? fullName;
  String? avatar;

  DisLikedBy({this.sId, this.username, this.email, this.fullName, this.avatar});

  DisLikedBy.fromJson(Map<String, dynamic> json) {
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
