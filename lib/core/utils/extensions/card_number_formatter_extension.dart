extension CardNumberFormatter on String? {
  String get formattedCardNumber {
    if (this == null || this!.length < 4) return "**** **** **** ****";

    String lastFour = this!.substring(this!.length - 4);
    return "**** **** **** $lastFour";
  }
}
