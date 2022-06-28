import 'package:paylike_money/paylike_money.dart';

void main() {
  var amount = Money.fromDouble("EUR", 12.5);
  print(amount.toJSONBody());
  print(amount.toRepresentationString());
}
