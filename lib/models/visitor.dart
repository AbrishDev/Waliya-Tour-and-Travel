class Visitor {
  String firstName;
  String lastName;
  String siteName;
  String dateOfBirth;
  String sex;
  String nationality;
  String phoneNumber;
  List<Language> languages;
  String startingDate;
  String endingDate;
  String bookingStatus;
  EmergencyContact emergencyContact;
  String guidePhoneNumber;

  Visitor({
    required this.firstName,
    required this.lastName,
    required this.siteName,
    required this.dateOfBirth,
    required this.sex,
    required this.nationality,
    required this.phoneNumber,
    required this.languages,
    required this.startingDate,
    required this.endingDate,
    required this.bookingStatus,
    required this.emergencyContact,
    required this.guidePhoneNumber,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      firstName: json['firstName'],
      lastName: json['lastName'],
      siteName: json['siteName'],
      dateOfBirth: json['dateOfBirth'],
      sex: json['sex'],
      nationality: json['nationality'],
      phoneNumber: json['phoneNumber'],
      languages: (json['languages'] as List)
          .map((lang) => Language.fromJson(lang))
          .toList(),
      startingDate: json['startingDate'],
      endingDate: json['endingDate'],
      bookingStatus: json['bookingStatus'],
      emergencyContact: EmergencyContact.fromJson(json['emergencyContact']),
      guidePhoneNumber: json['guidePhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'siteName': siteName,
      'dateOfBirth': dateOfBirth,
      'sex': sex,
      'nationality': nationality,
      'phoneNumber': phoneNumber,
      'languages': languages.map((lang) => lang.toJson()).toList(),
      'startingDate': startingDate,
      'endingDate': endingDate,
      'bookingStatus': bookingStatus,
      'emergencyContact': emergencyContact.toJson(),
      'guidePhoneNumber': guidePhoneNumber,
    };
  }
}

class Language {
  String language;
  String proficiency;

  Language({
    required this.language,
    required this.proficiency,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      language: json['language'],
      proficiency: json['proficiency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'proficiency': proficiency,
    };
  }
}

class EmergencyContact {
  String name;
  String relationship;
  String phoneNumber;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      relationship: json['relationship'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
    };
  }
}
