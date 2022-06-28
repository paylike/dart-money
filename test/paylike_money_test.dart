import 'package:paylike_money/paylike_money.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    const eur = 'EUR';
    test('fromDouble', () {
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

    test('PaymentAmount toRepresentationStringString', () {
      expect(Money.fromDouble(eur, 0).toRepresentationString(), 'EUR 0');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(),
          'EUR 1');
      expect(
          PaymentAmount(currency: eur, value: -1, exponent: 0)
              .toRepresentationString(),
          'EUR -1');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 1)
              .toRepresentationString(),
          'EUR 0.1');
      expect(
          PaymentAmount(currency: eur, value: -1, exponent: 1)
              .toRepresentationString(),
          'EUR -0.1');
      expect(Money.fromDouble(eur, 0.01).toRepresentationString(), 'EUR 0.01');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: -1)
              .toRepresentationString(),
          'EUR 10');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: -1)
              .toRepresentationString(),
          'EUR 120');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: 0)
              .toRepresentationString(),
          'EUR 12');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: 1)
              .toRepresentationString(),
          'EUR 1.2');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: 2)
              .toRepresentationString(),
          'EUR 0.12');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: 3)
              .toRepresentationString(),
          'EUR 0.012');

      expect(
          PaymentAmount(currency: eur, value: 123, exponent: 2)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padFractions: 0)),
          'EUR 1.23');
      expect(
          PaymentAmount(currency: eur, value: 123, exponent: 2)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padFractions: 2)),
          'EUR 1.23');
      expect(
          PaymentAmount(currency: eur, value: 123, exponent: 2)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padFractions: 3)),
          'EUR 1.230');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 2)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padFractions: 3)),
          'EUR 0.010');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padFractions: 3)),
          'EUR 1.000');

      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(currency: false)),
          '1');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(currency: true)),
          'EUR 1');

      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padIntegers: 0)),
          'EUR 1');
      expect(
          PaymentAmount(currency: eur, value: 1, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padIntegers: 2)),
          'EUR  1');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: 0)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padIntegers: 3)),
          'EUR  12');
      expect(
          PaymentAmount(currency: eur, value: 123, exponent: 1)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padIntegers: 3)),
          'EUR  12.3');
      expect(
          PaymentAmount(currency: eur, value: 12, exponent: -1)
              .toRepresentationString(
                  options: PaymentAmountStringOptions(padIntegers: 3)),
          'EUR 120');
    });
  });
}
