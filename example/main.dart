import 'package:paylike_money/paylike_money.dart';

void main() {
  var eur = PaylikeCurrencies().byCode(CurrencyCode.EUR);
  var amount = Money.fromDouble(eur, 12.5);
  print(amount.toJSONBody());
}
