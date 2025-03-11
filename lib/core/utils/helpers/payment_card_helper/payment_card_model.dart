import '/core/_core.dart';

class PaymentCard {
  CardType? type;
  String? number;
  String? name;
  int? month;
  int? year;
  int? cvv;

  PaymentCard({this.type, this.number, this.name, this.month, this.year, this.cvv});

  // fromJson
  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    return PaymentCard(
      type: json['type'] as CardType?,
      number: json['number'] as String?,
      name: json['name'] as String?,
      month: json['month'] as int?,
      year: json['year'] as int?,
      cvv: json['cvv'] as int?,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'name': name,
      'month': month,
      'year': year,
      'cvv': cvv,
    };
  }

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }
}
