
class ApiRespone{
  List<User> users;
  int total;
  int skip;
  int limit;

  ApiRespone({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ApiRespone.fromJson(Map<String, Object?> json) => ApiRespone(
    users: (json["users"] as List).map((e) => User.fromJson(e as Map<String,Object?>)).toList(),
    total: json["total"] as int,
    skip: json["skip"] as int,
    limit: json["limit"] as int,
  );

  Map<String, Object?> toJson() => {
    "users": users.map((e) => User.fromJson(e as Map<String,Object?>)).toList(),
   "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class User {
  int id;
  String firstName;
  String lastName;
  String maidenName;
  int age;
  Gender gender;
  String email;
  String phone;
  String username;
  String password;
  String birthDate;
  String image;
  String bloodGroup;
  int height;
  num weight;
  EyeColor eyeColor;
  Hair hair;
  String domain;
  String ip;
  Address address;
  String macAddress;
  String university;
  Bank bank;
  Company company;
  String ein;
  String ssn;
  String userAgent;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });

  factory User.fromJson(Map<String, Object?> json) => User(
    id: json["id"] as int,
    firstName: json["firstName"] as String,
    lastName: json["lastName"] as String,
    maidenName: json["maidenName"] as String,
    age: json["age"] as int,
    gender: genderValues.map[json["gender"]]!,
    email: json["email"] as String,
    phone: json["phone"] as String,
    username: json["username"] as String,
    password: json["password"] as String,
    birthDate: json["birthDate"] as String,
    image: json["image"] as String,
    bloodGroup: json["bloodGroup"] as String,
    height: json["height"] as int,
    weight: json["weight"] as num,
    eyeColor: eyeColorValues.map[json["eyeColor"]]!,
    hair: Hair.fromJson(json["hair"] as Map<String,Object?>),
    domain: json["domain"] as String,
    ip: json["ip"] as String,
    address: Address.fromJson(json["address"]as Map<String,Object?>),
    macAddress: json["macAddress"] as String,
    university: json["university"] as String,
    bank: Bank.fromJson(json["bank"]as Map<String,Object?>),
    company: Company.fromJson(json["company"]as Map<String,Object?>),
    ein: json["ein"] as String,
    ssn: json["ssn"] as String,
    userAgent: json["userAgent"] as String,
  );

  Map<String, Object?> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "maidenName": maidenName,
    "age": age,
    "gender": genderValues.reverse[gender],
    "email": email,
    "phone": phone,
    "username": username,
    "password": password,
    "birthDate": birthDate,
    "image": image,
    "bloodGroup": bloodGroup,
    "height": height,
    "weight": weight,
    "eyeColor": eyeColorValues.reverse[eyeColor],
    "hair": hair.toJson(),
    "domain": domain,
    "ip": ip,
    "address": address.toJson(),
    "macAddress": macAddress,
    "university": university,
    "bank": bank.toJson(),
    "company": company.toJson(),
    "ein": ein,
    "ssn": ssn,
    "userAgent": userAgent,
  };
}

class Address {
  String address;
  String? city;
  Coordinates coordinates;
  String postalCode;
  String state;

  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, Object?> json) => Address(
    address: json["address"] as String,
    city: json["city"] as String?,
    coordinates: Coordinates.fromJson(json["coordinates"] as Map<String,Object?>),
    postalCode: json["postalCode"] as String,
    state: json["state"] as String,
  );

  Map<String, Object?> toJson() => {
    "address": address,
    "city": city,
    "coordinates": coordinates.toJson(),
    "postalCode": postalCode,
    "state": state,
  };
}

class Coordinates {
  double lat;
  double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, Object?> json) => Coordinates(
    lat: json["lat"] as double,
    lng: json["lng"] as double,
  );

  Map<String, Object?> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Bank {
  String cardExpire;
  String cardNumber;
  String cardType;
  String currency;
  String iban;

  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory Bank.fromJson(Map<String, Object?> json) => Bank(
    cardExpire: json["cardExpire"] as String,
    cardNumber: json["cardNumber"] as String,
    cardType: json["cardType"] as String,
    currency: json["currency"] as String,
    iban: json["iban"] as String,
  );

  Map<String, Object?> toJson() => {
    "cardExpire": cardExpire,
    "cardNumber": cardNumber,
    "cardType": cardType,
    "currency": currency,
    "iban": iban,
  };

  @override
  String toString() {
    return 'cardExpire: $cardExpire,'
        'cardNumber: $cardNumber, '
        'cardType: $cardType, '
        'currency: $currency,'
        ' iban: $iban';
  }
}

class Company {
  Address address;
  String department;
  String name;
  String title;

  @override
  String toString() {
    return 'address: $address, '
        'department: $department, '
        'name: $name,'
        'title: $title';
  }

  Company({
    required this.address,
    required this.department,
    required this.name,
    required this.title,
  });

  factory Company.fromJson(Map<String, Object?> json) => Company(
    address: Address.fromJson(json["address"] as Map<String,Object?>),
    department: json["department"] as String,
    name: json["name"] as String,
    title: json["title"] as String,
  );

  Map<String, Object?> toJson() => {
    "address": address.toJson(),
    "department": department,
    "name": name,
    "title": title,
  };
}

enum EyeColor { GREEN, BROWN, GRAY, AMBER, BLUE }

final eyeColorValues = EnumValues({
  "Amber": EyeColor.AMBER,
  "Blue": EyeColor.BLUE,
  "Brown": EyeColor.BROWN,
  "Gray": EyeColor.GRAY,
  "Green": EyeColor.GREEN
});

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.MALE
});

class Hair {
  Color color;
  Type type;

  Hair({
    required this.color,
    required this.type,
  });

  factory Hair.fromJson(Map<String,Object?> json) => Hair(
    color: colorValues.map[json["color"]]!,
    type: typeValues.map[json["type"]]!,
  );

  Map<String, Object?> toJson() => {
    "color": colorValues.reverse[color],
    "type": typeValues.reverse[type],
  };
}

enum Color { BLACK, BLOND, BROWN, CHESTNUT, AUBURN }

final colorValues = EnumValues({
  "Auburn": Color.AUBURN,
  "Black": Color.BLACK,
  "Blond": Color.BLOND,
  "Brown": Color.BROWN,
  "Chestnut": Color.CHESTNUT
});

enum Type { STRANDS, CURLY, VERY_CURLY, STRAIGHT, WAVY }

final typeValues = EnumValues({
  "Curly": Type.CURLY,
  "Straight": Type.STRAIGHT,
  "Strands": Type.STRANDS,
  "Very curly": Type.VERY_CURLY,
  "Wavy": Type.WAVY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
