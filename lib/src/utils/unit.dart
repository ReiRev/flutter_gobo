enum JapaneseUnit {
  shaku,
  sun,
  bu,
}

extension JapaneseUnitExtension on double {
  double toShaku(JapaneseUnit from) {
    switch (from) {
      case JapaneseUnit.bu:
        return this / 100;
      case JapaneseUnit.sun:
        return this / 10;
      case JapaneseUnit.shaku:
        return this;
      default:
        throw ArgumentError('Invalid unit');
    }
  }

  double toSun(JapaneseUnit from) {
    return toShaku(from) * 10;
  }

  double toBu(JapaneseUnit from) {
    return toShaku(from) * 100;
  }
}
