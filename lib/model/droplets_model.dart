//@dart=2.9

// To parse this JSON data, do
//
//     final dropletsList = dropletsListFromJson(jsonString);

import 'dart:convert';

DropletsList dropletsListFromJson(String str) =>
    DropletsList.fromJson(json.decode(str));

String dropletsListToJson(DropletsList data) => json.encode(data.toJson());

class DropletsList {
  DropletsList({
    this.droplets,
    this.links,
    this.meta,
  });

  List<Droplet> droplets;
  Links links;
  Meta meta;

  factory DropletsList.fromJson(Map<String, dynamic> json) => DropletsList(
        droplets: List<Droplet>.from(
            json["droplets"].map((x) => Droplet.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "droplets": List<dynamic>.from(droplets.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Droplet {
  Droplet({
    this.id,
    this.name,
    this.memory,
    this.vcpus,
    this.disk,
    this.locked,
    this.status,
    this.kernel,
    this.createdAt,
    this.features,
    this.backupIds,
    this.nextBackupWindow,
    this.snapshotIds,
    this.image,
    this.volumeIds,
    this.size,
    this.sizeSlug,
    this.networks,
    this.region,
    this.tags,
    this.vpcUuid,
  });

  int id;
  String name;
  dynamic memory;
  dynamic vcpus;
  dynamic disk;
  bool locked;
  String status;
  dynamic kernel;
  DateTime createdAt;
  List<String> features;
  List<dynamic> backupIds;
  dynamic nextBackupWindow;
  List<dynamic> snapshotIds;
  Image image;
  List<dynamic> volumeIds;
  Size size;
  String sizeSlug;
  Networks networks;
  Region region;
  List<String> tags;
  String vpcUuid;

  factory Droplet.fromJson(Map<String, dynamic> json) => Droplet(
        id: json["id"],
        name: json["name"],
        memory: json["memory"],
        vcpus: json["vcpus"],
        disk: json["disk"],
        locked: json["locked"],
        status: json["status"],
        kernel: json["kernel"],
        createdAt: DateTime.parse(json["created_at"]),
        features: List<String>.from(json["features"].map((x) => x)),
        backupIds: List<dynamic>.from(json["backup_ids"].map((x) => x)),
        nextBackupWindow: json["next_backup_window"],
        snapshotIds: List<dynamic>.from(json["snapshot_ids"].map((x) => x)),
        image: Image.fromJson(json["image"]),
        volumeIds: List<dynamic>.from(json["volume_ids"].map((x) => x)),
        size: Size.fromJson(json["size"]),
        sizeSlug: json["size_slug"],
        networks: Networks.fromJson(json["networks"]),
        region: Region.fromJson(json["region"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        vpcUuid: json["vpc_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "memory": memory,
        "vcpus": vcpus,
        "disk": disk,
        "locked": locked,
        "status": status,
        "kernel": kernel,
        "created_at": createdAt.toIso8601String(),
        "features": List<dynamic>.from(features.map((x) => x)),
        "backup_ids": List<dynamic>.from(backupIds.map((x) => x)),
        "next_backup_window": nextBackupWindow,
        "snapshot_ids": List<dynamic>.from(snapshotIds.map((x) => x)),
        "image": image.toJson(),
        "volume_ids": List<dynamic>.from(volumeIds.map((x) => x)),
        "size": size.toJson(),
        "size_slug": sizeSlug,
        "networks": networks.toJson(),
        "region": region.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "vpc_uuid": vpcUuid,
      };
}

class Image {
  Image({
    this.id,
    this.name,
    this.distribution,
    this.slug,
    this.public,
    this.regions,
    this.createdAt,
    this.minDiskSize,
    this.type,
    this.sizeGigabytes,
    this.description,
    this.tags,
    this.status,
  });

  int id;
  String name;
  String distribution;
  String slug;
  bool public;
  List<String> regions;
  DateTime createdAt;
  dynamic minDiskSize;
  String type;
  double sizeGigabytes;
  String description;
  List<dynamic> tags;
  String status;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        distribution: json["distribution"],
        slug: json["slug"],
        public: json["public"],
        regions: List<String>.from(json["regions"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        minDiskSize: json["min_disk_size"],
        type: json["type"],
        sizeGigabytes: json["size_gigabytes"].toDouble(),
        description: json["description"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "distribution": distribution,
        "slug": slug,
        "public": public,
        "regions": List<dynamic>.from(regions.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "min_disk_size": minDiskSize,
        "type": type,
        "size_gigabytes": sizeGigabytes,
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "status": status,
      };
}

class Networks {
  Networks({
    this.v4,
    this.v6,
  });

  List<V4> v4;
  List<V6> v6;

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
        v4: List<V4>.from(json["v4"].map((x) => V4.fromJson(x))),
        v6: List<V6>.from(json["v6"].map((x) => V6.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "v4": List<dynamic>.from(v4.map((x) => x.toJson())),
        "v6": List<dynamic>.from(v6.map((x) => x.toJson())),
      };
}

class V4 {
  V4({
    this.ipAddress,
    this.netmask,
    this.gateway,
    this.type,
  });

  String ipAddress;
  String netmask;
  String gateway;
  String type;

  factory V4.fromJson(Map<String, dynamic> json) => V4(
        ipAddress: json["ip_address"],
        netmask: json["netmask"],
        gateway: json["gateway"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "netmask": netmask,
        "gateway": gateway,
        "type": type,
      };
}

class V6 {
  V6({
    this.ipAddress,
    this.netmask,
    this.gateway,
    this.type,
  });

  String ipAddress;
  dynamic netmask;
  String gateway;
  String type;

  factory V6.fromJson(Map<String, dynamic> json) => V6(
        ipAddress: json["ip_address"],
        netmask: json["netmask"],
        gateway: json["gateway"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "netmask": netmask,
        "gateway": gateway,
        "type": type,
      };
}

class Region {
  Region({
    this.name,
    this.slug,
    this.features,
    this.available,
    this.sizes,
  });

  String name;
  String slug;
  List<String> features;
  bool available;
  List<String> sizes;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        name: json["name"],
        slug: json["slug"],
        features: List<String>.from(json["features"].map((x) => x)),
        available: json["available"],
        sizes: List<String>.from(json["sizes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "features": List<dynamic>.from(features.map((x) => x)),
        "available": available,
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
      };
}

class Size {
  Size({
    this.slug,
    this.memory,
    this.vcpus,
    this.disk,
    this.transfer,
    this.priceMonthly,
    this.priceHourly,
    this.regions,
    this.available,
    this.description,
  });

  String slug;
  dynamic memory;
  dynamic vcpus;
  dynamic disk;
  dynamic transfer;
  dynamic priceMonthly;
  double priceHourly;
  List<String> regions;
  bool available;
  String description;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        slug: json["slug"],
        memory: json["memory"],
        vcpus: json["vcpus"],
        disk: json["disk"],
        transfer: json["transfer"],
        priceMonthly: json["price_monthly"],
        priceHourly: json["price_hourly"].toDouble(),
        regions: List<String>.from(json["regions"].map((x) => x)),
        available: json["available"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "memory": memory,
        "vcpus": vcpus,
        "disk": disk,
        "transfer": transfer,
        "price_monthly": priceMonthly,
        "price_hourly": priceHourly,
        "regions": List<dynamic>.from(regions.map((x) => x)),
        "available": available,
        "description": description,
      };
}

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links();

  Map<String, dynamic> toJson() => {};
}

class Meta {
  Meta({
    this.total,
  });

  dynamic total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
