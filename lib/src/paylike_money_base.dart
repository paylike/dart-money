import 'package:equatable/equatable.dart';
import 'package:paylike_currencies/paylike_currencies.dart';

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
