import 'dart:convert';

class UsersContact {
  final List<Datum> data;
  final List<Included> included;
  final Meta meta;
  final Links links;

  UsersContact({
    required this.data,
    required this.included,
    required this.meta,
    required this.links,
  });

  factory UsersContact.fromRawJson(String str) =>
      UsersContact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersContact.fromJson(Map<String, dynamic> json) => UsersContact(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        included: List<Included>.from(
            json["included"].map((x) => Included.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "included": List<dynamic>.from(included.map((x) => x.toJson())),
        "meta": meta.toJson(),
        "links": links.toJson(),
      };
}

class Datum {
  final String type;
  final String id;
  final DatumAttributes attributes;
  final Relationships relationships;

  Datum({
    required this.type,
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        id: json["id"],
        attributes: DatumAttributes.fromJson(json["attributes"]),
        relationships: Relationships.fromJson(json["relationships"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
      };
}

class DatumAttributes {
  final DateTime messageReceivedFromPartnerAt;
  final int authUserId;
  final String name;
  final String username;
  final String email;
  final dynamic profilePhotoPath;
  final dynamic profilePhotoId;
  final String phone;
  final String gender;
  final dynamic countryId;
  final dynamic countryName;
  final dynamic stateId;
  final dynamic stateName;
  final dynamic cityId;
  final dynamic cityName;
  final dynamic customCityName;
  final bool isActive;
  final String customerCode;
  final bool isPremiumCustomer;
  final bool isOnline;
  final dynamic bioIntroText;
  final dynamic lastActiveAt;
  final dynamic address;
  final DateTime dateOfBirth;
  final dynamic nativeLanguageId;
  final dynamic nativeLanguageName;
  final String referralCode;
  final dynamic referredBy;
  final dynamic referredId;
  final bool isVanishModeEnabled;
  final bool isChatInitiated;
  final DateTime likebackCreatedAt;
  final String profilePhotoUrl;
  final String square100ProfilePhotoUrl;
  final String square300ProfilePhotoUrl;
  final String square500ProfilePhotoUrl;
  final int age;

  DatumAttributes({
    required this.messageReceivedFromPartnerAt,
    required this.authUserId,
    required this.name,
    required this.username,
    required this.email,
    required this.profilePhotoPath,
    required this.profilePhotoId,
    required this.phone,
    required this.gender,
    required this.countryId,
    required this.countryName,
    required this.stateId,
    required this.stateName,
    required this.cityId,
    required this.cityName,
    required this.customCityName,
    required this.isActive,
    required this.customerCode,
    required this.isPremiumCustomer,
    required this.isOnline,
    required this.bioIntroText,
    required this.lastActiveAt,
    required this.address,
    required this.dateOfBirth,
    required this.nativeLanguageId,
    required this.nativeLanguageName,
    required this.referralCode,
    required this.referredBy,
    required this.referredId,
    required this.isVanishModeEnabled,
    required this.isChatInitiated,
    required this.likebackCreatedAt,
    required this.profilePhotoUrl,
    required this.square100ProfilePhotoUrl,
    required this.square300ProfilePhotoUrl,
    required this.square500ProfilePhotoUrl,
    required this.age,
  });

  factory DatumAttributes.fromRawJson(String str) =>
      DatumAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        messageReceivedFromPartnerAt:
            DateTime.parse(json["message_received_from_partner_at"]),
        authUserId: json["auth_user_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profilePhotoPath: json["profile_photo_path"],
        profilePhotoId: json["profile_photo_id"],
        phone: json["phone"],
        gender: json["gender"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        customCityName: json["custom_city_name"],
        isActive: json["is_active"],
        customerCode: json["customer_code"],
        isPremiumCustomer: json["is_premium_customer"],
        isOnline: json["is_online"],
        bioIntroText: json["bio_intro_text"],
        lastActiveAt: json["last_active_at"],
        address: json["address"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        nativeLanguageId: json["native_language_id"],
        nativeLanguageName: json["native_language_name"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        referredId: json["referred_id"],
        isVanishModeEnabled: json["is_vanish_mode_enabled"],
        isChatInitiated: json["is_chat_initiated"],
        likebackCreatedAt: DateTime.parse(json["likeback_created_at"]),
        profilePhotoUrl: json["profile_photo_url"],
        square100ProfilePhotoUrl: json["square100_profile_photo_url"],
        square300ProfilePhotoUrl: json["square300_profile_photo_url"],
        square500ProfilePhotoUrl: json["square500_profile_photo_url"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "message_received_from_partner_at":
            messageReceivedFromPartnerAt.toIso8601String(),
        "auth_user_id": authUserId,
        "name": name,
        "username": username,
        "email": email,
        "profile_photo_path": profilePhotoPath,
        "profile_photo_id": profilePhotoId,
        "phone": phone,
        "gender": gender,
        "country_id": countryId,
        "country_name": countryName,
        "state_id": stateId,
        "state_name": stateName,
        "city_id": cityId,
        "city_name": cityName,
        "custom_city_name": customCityName,
        "is_active": isActive,
        "customer_code": customerCode,
        "is_premium_customer": isPremiumCustomer,
        "is_online": isOnline,
        "bio_intro_text": bioIntroText,
        "last_active_at": lastActiveAt,
        "address": address,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "native_language_id": nativeLanguageId,
        "native_language_name": nativeLanguageName,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "referred_id": referredId,
        "is_vanish_mode_enabled": isVanishModeEnabled,
        "is_chat_initiated": isChatInitiated,
        "likeback_created_at": likebackCreatedAt.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "square100_profile_photo_url": square100ProfilePhotoUrl,
        "square300_profile_photo_url": square300ProfilePhotoUrl,
        "square500_profile_photo_url": square500ProfilePhotoUrl,
        "age": age,
      };
}

class Relationships {
  final BlockedContacts blockedContacts;
  final UserSettings userSettings;

  Relationships({
    required this.blockedContacts,
    required this.userSettings,
  });

  factory Relationships.fromRawJson(String str) =>
      Relationships.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        blockedContacts: BlockedContacts.fromJson(json["blockedContacts"]),
        userSettings: UserSettings.fromJson(json["userSettings"]),
      );

  Map<String, dynamic> toJson() => {
        "blockedContacts": blockedContacts.toJson(),
        "userSettings": userSettings.toJson(),
      };
}

class BlockedContacts {
  final List<dynamic> data;

  BlockedContacts({
    required this.data,
  });

  factory BlockedContacts.fromRawJson(String str) =>
      BlockedContacts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockedContacts.fromJson(Map<String, dynamic> json) =>
      BlockedContacts(
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class UserSettings {
  final Data data;

  UserSettings({
    required this.data,
  });

  factory UserSettings.fromRawJson(String str) =>
      UserSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String type;
  final String id;

  Data({
    required this.type,
    required this.id,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class Included {
  final String type;
  final String id;
  final IncludedAttributes attributes;

  Included({
    required this.type,
    required this.id,
    required this.attributes,
  });

  factory Included.fromRawJson(String str) =>
      Included.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Included.fromJson(Map<String, dynamic> json) => Included(
        type: json["type"],
        id: json["id"],
        attributes: IncludedAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class IncludedAttributes {
  final int userId;
  final bool isRealGiftsAccepted;
  final bool isGenderRevealed;
  final bool isHeightRevealed;
  final bool isReligionRevealed;
  final bool isDrinkingHabitRevealed;
  final bool isSmokingHabitRevealed;
  final bool isSexualOrientationRevealed;
  final bool isEducationalQualificationRevealed;
  final bool isPersonalityTraitsRevealed;
  final bool isLifestyleActivitiesRevealed;
  final bool isContactDiscoveryEnabled;
  final bool isGhostModeEnabled;
  final bool isDarkModeEnabled;
  final bool isReceivingPushNotifications;
  final bool isReceivingFlashMessages;
  final bool isLastSeenEnabled;
  final bool isOnlineStatusEnabled;
  final bool isReadReceiptsEnabled;

  IncludedAttributes({
    required this.userId,
    required this.isRealGiftsAccepted,
    required this.isGenderRevealed,
    required this.isHeightRevealed,
    required this.isReligionRevealed,
    required this.isDrinkingHabitRevealed,
    required this.isSmokingHabitRevealed,
    required this.isSexualOrientationRevealed,
    required this.isEducationalQualificationRevealed,
    required this.isPersonalityTraitsRevealed,
    required this.isLifestyleActivitiesRevealed,
    required this.isContactDiscoveryEnabled,
    required this.isGhostModeEnabled,
    required this.isDarkModeEnabled,
    required this.isReceivingPushNotifications,
    required this.isReceivingFlashMessages,
    required this.isLastSeenEnabled,
    required this.isOnlineStatusEnabled,
    required this.isReadReceiptsEnabled,
  });

  factory IncludedAttributes.fromRawJson(String str) =>
      IncludedAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IncludedAttributes.fromJson(Map<String, dynamic> json) =>
      IncludedAttributes(
        userId: json["user_id"],
        isRealGiftsAccepted: json["is_real_gifts_accepted"],
        isGenderRevealed: json["is_gender_revealed"],
        isHeightRevealed: json["is_height_revealed"],
        isReligionRevealed: json["is_religion_revealed"],
        isDrinkingHabitRevealed: json["is_drinking_habit_revealed"],
        isSmokingHabitRevealed: json["is_smoking_habit_revealed"],
        isSexualOrientationRevealed: json["is_sexual_orientation_revealed"],
        isEducationalQualificationRevealed:
            json["is_educational_qualification_revealed"],
        isPersonalityTraitsRevealed: json["is_personality_traits_revealed"],
        isLifestyleActivitiesRevealed: json["is_lifestyle_activities_revealed"],
        isContactDiscoveryEnabled: json["is_contact_discovery_enabled"],
        isGhostModeEnabled: json["is_ghost_mode_enabled"],
        isDarkModeEnabled: json["is_dark_mode_enabled"],
        isReceivingPushNotifications: json["is_receiving_push_notifications"],
        isReceivingFlashMessages: json["is_receiving_flash_messages"],
        isLastSeenEnabled: json["is_last_seen_enabled"],
        isOnlineStatusEnabled: json["is_online_status_enabled"],
        isReadReceiptsEnabled: json["is_read_receipts_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "is_real_gifts_accepted": isRealGiftsAccepted,
        "is_gender_revealed": isGenderRevealed,
        "is_height_revealed": isHeightRevealed,
        "is_religion_revealed": isReligionRevealed,
        "is_drinking_habit_revealed": isDrinkingHabitRevealed,
        "is_smoking_habit_revealed": isSmokingHabitRevealed,
        "is_sexual_orientation_revealed": isSexualOrientationRevealed,
        "is_educational_qualification_revealed":
            isEducationalQualificationRevealed,
        "is_personality_traits_revealed": isPersonalityTraitsRevealed,
        "is_lifestyle_activities_revealed": isLifestyleActivitiesRevealed,
        "is_contact_discovery_enabled": isContactDiscoveryEnabled,
        "is_ghost_mode_enabled": isGhostModeEnabled,
        "is_dark_mode_enabled": isDarkModeEnabled,
        "is_receiving_push_notifications": isReceivingPushNotifications,
        "is_receiving_flash_messages": isReceivingFlashMessages,
        "is_last_seen_enabled": isLastSeenEnabled,
        "is_online_status_enabled": isOnlineStatusEnabled,
        "is_read_receipts_enabled": isReadReceiptsEnabled,
      };
}

class Links {
  final String self;
  final String first;
  final String last;

  Links({
    required this.self,
    required this.first,
    required this.last,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        first: json["first"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "last": last,
      };
}

class Meta {
  final Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
