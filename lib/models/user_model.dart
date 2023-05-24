class UserModel {
  String? id;
  String? image;
  String? name;
  int? age;
  String? sign;

  UserModel(
      {required this.id,
        required this.image,
      required this.name,
      required this.age,
      required this.sign});

  UserModel.fromJson(Map<String, dynamic> json) {
      id = json['_id'];
      image = json['image'];
      name = json['name'] ?? 'Ayşe';
      age = json['age'] ?? 19;
      sign = json['sign'] ?? 'Virgo';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['name'] = this.name;
    data['age'] = this.age;
    data['sign'] = this.sign;
    return data;
  }

  static String getSign(month, day) {
    switch (month) {
      case 1:
        if (day <= 19 && day >= 1) {
          return'♑Capricorn';
        } else {
          return '♒Aquarius';
        }
        
      case 2:
        if (day <= 18 && day >= 1) {
          return '♒Aquarius';
        } else {
          return '♓Pisces';
        }
        
      case 3:
        if (day <= 20 && day >= 1) {
          return '♓Pisces';
        } else {
          return '♈Aries';
        }
        
      case 4:
        if (day <= 19 && day >= 1) {
          return '♈Aries';
        } else {
          return '♉Taurus';
        }
        
      case 5:
        if (day <= 20 && day >= 1) {
          return '♉Taurus';
        } else {
          return '♊Gemini';
        }
        
      case 6:
        if (day <= 20 && day >= 1) {
          return '♊Gemini';
        } else {
          return '♋Cancer';
        }
        
      case 7:
        if (day <= 22 && day >= 1) {
          return '♋Cancer';
        } else {
          return '♌Leo';
        }
        
      case 8:
        if (day <= 22 && day >= 1) {
          return '♌Leo';
        } else {
          return '♍Virgo';
        }
        
      case 9:
        if (day <= 22 && day >= 1) {
          return '♍Virgo';
        } else {
          return '♎Libra';
        }
        
      case 10:
        if (day <= 22 && day >= 1) {
          return '♎Libra';
        } else {
          return '♏Scorpio';
        }
        
      case 11:
        if (day <= 22 && day >= 1) {
          return '♏Scorpio';
        } else {
          return '♐Sagittarius';
        }
        
      case 12:
        if (day <= 21 && day >= 1) {
          return '♐Sagittarius';
        } else {
          return '♑Capricorn';
        }
        
      default:
        return 'Virgo';
    }
  }

  static int getAge(DateTime birthday) {
    return DateTime.now().year - birthday.year;
  }
}
