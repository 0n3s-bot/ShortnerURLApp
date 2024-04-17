// To parse this JSON data, do
//
//     final shortUrlResponseModal = shortUrlResponseModalFromJson(jsonString);

import 'dart:convert';

ShortUrlResponseModal shortUrlResponseModalFromJson(String str) =>
    ShortUrlResponseModal.fromJson(json.decode(str));

String shortUrlResponseModalToJson(ShortUrlResponseModal data) =>
    json.encode(data.toJson());

class ShortUrlResponseModal {
  final String? id;
  final String? title;
  final String? slashtag;
  final String? destination;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic expiredAt;
  final String? status;
  final List<dynamic>? tags;
  final String? linkType;
  final int? clicks;
  final bool? isPublic;
  final String? shortUrl;
  final String? domainId;
  final String? domainName;
  final Domain? domain;
  final bool? https;
  final bool? favourite;
  final Creator? creator;
  final bool? integrated;

  ShortUrlResponseModal({
    this.id,
    this.title,
    this.slashtag,
    this.destination,
    this.createdAt,
    this.updatedAt,
    this.expiredAt,
    this.status,
    this.tags,
    this.linkType,
    this.clicks,
    this.isPublic,
    this.shortUrl,
    this.domainId,
    this.domainName,
    this.domain,
    this.https,
    this.favourite,
    this.creator,
    this.integrated,
  });

  factory ShortUrlResponseModal.fromJson(Map<String, dynamic> json) =>
      ShortUrlResponseModal(
        id: json["id"],
        title: json["title"],
        slashtag: json["slashtag"],
        destination: json["destination"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        expiredAt: json["expiredAt"],
        status: json["status"],
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        linkType: json["linkType"],
        clicks: json["clicks"],
        isPublic: json["isPublic"],
        shortUrl: json["shortUrl"],
        domainId: json["domainId"],
        domainName: json["domainName"],
        domain: json["domain"] == null ? null : Domain.fromJson(json["domain"]),
        https: json["https"],
        favourite: json["favourite"],
        creator:
            json["creator"] == null ? null : Creator.fromJson(json["creator"]),
        integrated: json["integrated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slashtag": slashtag,
        "destination": destination,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "expiredAt": expiredAt,
        "status": status,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "linkType": linkType,
        "clicks": clicks,
        "isPublic": isPublic,
        "shortUrl": shortUrl,
        "domainId": domainId,
        "domainName": domainName,
        "domain": domain?.toJson(),
        "https": https,
        "favourite": favourite,
        "creator": creator?.toJson(),
        "integrated": integrated,
      };
}

class Creator {
  final String? id;
  final String? fullName;
  final String? avatarUrl;

  Creator({
    this.id,
    this.fullName,
    this.avatarUrl,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        fullName: json["fullName"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "avatarUrl": avatarUrl,
      };
}

class Domain {
  final String? id;
  final String? ref;
  final String? fullName;
  final Sharing? sharing;
  final bool? active;

  Domain({
    this.id,
    this.ref,
    this.fullName,
    this.sharing,
    this.active,
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        id: json["id"],
        ref: json["ref"],
        fullName: json["fullName"],
        sharing:
            json["sharing"] == null ? null : Sharing.fromJson(json["sharing"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref": ref,
        "fullName": fullName,
        "sharing": sharing?.toJson(),
        "active": active,
      };
}

class Sharing {
  final Protocol? protocol;

  Sharing({
    this.protocol,
  });

  factory Sharing.fromJson(Map<String, dynamic> json) => Sharing(
        protocol: json["protocol"] == null
            ? null
            : Protocol.fromJson(json["protocol"]),
      );

  Map<String, dynamic> toJson() => {
        "protocol": protocol?.toJson(),
      };
}

class Protocol {
  final List<String>? allowed;
  final String? protocolDefault;

  Protocol({
    this.allowed,
    this.protocolDefault,
  });

  factory Protocol.fromJson(Map<String, dynamic> json) => Protocol(
        allowed: json["allowed"] == null
            ? []
            : List<String>.from(json["allowed"]!.map((x) => x)),
        protocolDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "allowed":
            allowed == null ? [] : List<dynamic>.from(allowed!.map((x) => x)),
        "default": protocolDefault,
      };
}
