/// Set to a domain like 'alustudent.com' to limit sign-up to campus emails
/// (supports the "trusted exchanges" goal). Set to null to allow any email.
const String? kAllowedEmailDomain = 'alustudent.com';

class Validators {
  static String? name(String? v) {
    if (v == null || v.trim().length < 2) return 'Enter your full name';
    return null;
  }

  static String? email(String? v) {
    final value = v?.trim() ?? '';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
    if (!ok) return 'Enter a valid email address';
    if (kAllowedEmailDomain != null &&
        !value.toLowerCase().endsWith('@$kAllowedEmailDomain')) {
      return 'Use your @$kAllowedEmailDomain email';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[0-9]').hasMatch(v)) return 'Include at least one number';
    return null;
  }

  static String? Function(String?) confirm(String Function() original) =>
      (v) => v != original() ? 'Passwords do not match' : null;
}
