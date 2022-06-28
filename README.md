# dart Money

Small utility library to help with working payment amounts in the paylike ecosystem.

## Features

Currently this package only supports a fraction of our JavaScript library. We may extend
 functionality if we can find usecases for it.

## Usage

```dart
import 'package:paylike_money/dart_money.dart';

void main() {
  const eur = 'EUR';
  var amount = Money.fromDouble(eur, 12.5);
  print(amount.toJSONBody());
}
```
