// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'settings_adapter.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class SettingsModel extends HiveObject with EquatableMixin {
  @HiveField(0, defaultValue: true)
  late bool isDark;

  @HiveField(1, defaultValue: 1.0)
  late double textScaleFactor;

  @HiveField(2, defaultValue: 0)
  late int locale;

  @HiveField(3, defaultValue: 7)
  late int seedColorId;

  @HiveField(4)
  late String baseUrl;

  @HiveField(5)
  late String materialsUrl;

  @HiveField(6)
  late String inventoryUrl;

  @HiveField(7)
  late String signInUrl;

  @HiveField(8, defaultValue: false)
  late bool isLoggedIn;

  @HiveField(9)
  late String username;

  @HiveField(10)
  late String password;

  @HiveField(11)
  late String accessToken;

  @HiveField(12)
  final List<String>? recentMaterials;

  SettingsModel({
    this.isDark = true,
    this.textScaleFactor = 1.0,
    this.locale = 0,
    this.seedColorId = 7,
    this.baseUrl = '',
    this.inventoryUrl = '',
    this.materialsUrl = '',
    this.isLoggedIn = false,
    this.signInUrl = '',
    this.username = '',
    this.password = '',
    this.accessToken = '',
    this.recentMaterials,
  });

  @override
  String toString() =>
      'SettingsModel(name: $isDark, path: $textScaleFactor, isPinned: $locale, isLoggedin: $isLoggedIn)';

  @override
  List<Object?> get props => [isDark, textScaleFactor, locale, isLoggedIn];

  SettingsModel copyWith({
    bool? isDark,
    double? textScaleFactor,
    int? locale,
    int? seedColorId,
    String? baseUrl,
    String? inventoryUrl,
    String? materialsUrl,
    String? signInUrl,
    bool isLoggedIn = false,
    String? username,
    String? password,
    String? accessToken,
    List<String>? recentMaterials,
  }) {
    return SettingsModel(
        isDark: isDark ?? this.isDark,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        locale: locale ?? this.locale,
        seedColorId: seedColorId ?? this.seedColorId,
        baseUrl: baseUrl ?? this.baseUrl,
        materialsUrl: materialsUrl ?? this.materialsUrl,
        inventoryUrl: inventoryUrl ?? this.inventoryUrl,
        signInUrl: signInUrl ?? this.signInUrl,
        isLoggedIn: isLoggedIn,
        username: username ?? this.username,
        password: password ?? this.password,
        accessToken: accessToken ?? this.accessToken,
        recentMaterials: recentMaterials ?? this.recentMaterials);
  }
}
