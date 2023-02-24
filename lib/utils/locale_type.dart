import 'package:medbuddy/utils/locale_type.dart';


enum LocaleType {
  en,
  fr,
  es,
}

extension LocaleTypeExtension on LocaleType {
  String get code {
    switch (this) {
      case LocaleType.en:
        return 'en';
      case LocaleType.fr:
        return 'fr';
      case LocaleType.es:
        return 'es';
      default:
        return 'en';
    }
  }
}
