import 'package:paylike_money/paylike_money.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final currencies = PaylikeCurrencies();
    test('First Test', () {
      var eur = currencies.byCode(CurrencyCode.EUR);
      expect(Money.fromDouble(eur, 0),
          PaymentAmount(currency: eur, value: 0, exponent: 0));

      expect(Money.fromDouble(eur, -0),
          PaymentAmount(currency: eur, value: 0, exponent: 0));

      expect(Money.fromDouble(eur, -0.0),
          PaymentAmount(currency: eur, value: 0, exponent: 0));

      expect(Money.fromDouble(eur, 1),
          PaymentAmount(currency: eur, value: 10, exponent: 1));

      expect(Money.fromDouble(eur, -1),
          PaymentAmount(currency: eur, value: -10, exponent: 1));

      expect(Money.fromDouble(eur, 120),
          PaymentAmount(currency: eur, value: 1200, exponent: 1));

      expect(Money.fromDouble(eur, 12.0),
          PaymentAmount(currency: eur, value: 120, exponent: 1));

      expect(Money.fromDouble(eur, 1.2),
          PaymentAmount(currency: eur, value: 12, exponent: 1));

      expect(Money.fromDouble(eur, 0.12),
          PaymentAmount(currency: eur, value: 12, exponent: 2));

      expect(Money.fromDouble(eur, 0.012),
          PaymentAmount(currency: eur, value: 12, exponent: 3));

      expect(() => Money.fromDouble(eur, double.maxFinite + 1),
          throwsA(isA<UnsafeNumberException>()));
    });
  });
}
