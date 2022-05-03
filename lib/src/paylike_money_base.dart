import 'package:equatable/equatable.dart';
import 'package:paylike_currencies/paylike_currencies.dart';

/// Describes the options for string representation of [PaymentAmount]
class PaymentAmountStringOptions {
  /// Describes padding for the integers
  final int padIntegers;

  /// Describes padding for the fractions
  final int padFractions;

  /// Indicates to include currency or not
  final bool currency;
  const PaymentAmountStringOptions(
      {this.padFractions = 0, this.padIntegers = 0, this.currency = true});
}

/// Describes an amount in a payment
class PaymentAmount extends Equatable {
  /// Currency of the payment
  final PaylikeCurrency currency;

  /// Value of the payment
  final int value;

  /// Exponent of the payment
  final int exponent;
  const PaymentAmount(
      {required this.currency, required this.value, required this.exponent});

  @override
  List<Object> get props => [currency, value, exponent];

  /// Returns the amount you would see displayed (e.g. EUR 0.25)
  String toRepresentationString(
      {PaymentAmountStringOptions options =
          const PaymentAmountStringOptions()}) {
    String wholes, somes;
    var negative = value < 0;
    var integer = (negative ? -value : value).toString();
    if (exponent <= 0) {
      wholes = integer + ''.padRight(-exponent, '0');
      somes = '';
    } else if (integer.length <= exponent) {
      wholes = '0';
      somes = integer.padLeft(exponent, '0');
    } else {
      wholes = integer.substring(0, integer.length - exponent);
      somes = integer.substring(integer.length - exponent);
    }
    var paddedWholes = wholes.padLeft(options.padIntegers, ' ');
    var paddedSomes = somes.padRight(options.padFractions, '0');
    var currencyString = options.currency ? currency.code + ' ' : '';
    return (currencyString +
        (negative ? '-' : '') +
        paddedWholes +
        (paddedSomes == '' ? '' : '.' + paddedSomes));
  }

  /// Converts to a JSON Object
  Map<String, dynamic> toJSONBody() => {
        'currency': currency.code,
        'value': value,
        'exponent': exponent,
      };
}

/// Describes an exception for working with unsafe numbers
class UnsafeNumberException implements Exception {
  double n;
  UnsafeNumberException(this.n);
  @override
  String toString() => 'Number is not in safe range $n';
}

/// Static class defining utility functions to work with money
///
/// This is a clone implementation of the paylike JS library
class Money {
  static int maxInt =
      (double.infinity is int) ? double.infinity as int : ~minInt;
  static int minInt =
      (double.infinity is int) ? -double.infinity as int : (-1 << 63);
  static bool isInSafeRange(double n) {
    return n <= maxInt && n >= -maxInt;
  }

  /// Converts a double value and a currency into an API compatible PaymentAmount
  static PaymentAmount fromDouble(PaylikeCurrency currency, double n) {
    if (!n.isFinite) {
      throw Exception('Non finite number $n');
    }
    if (!isInSafeRange(n)) {
      throw UnsafeNumberException(n);
    }
    var splitted = n.toString().split('.');
    var wholes = splitted[0];
    var somes = splitted.length > 1 ? splitted[1] : "";
    var value = int.parse(wholes + somes);
    return PaymentAmount(
        currency: currency,
        value: value,
        exponent: value == 0 ? 0 : somes.length);
  }
}
