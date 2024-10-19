// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:quicknote/authentication/auth_service.dart' as _i587;
import 'package:quicknote/quicknote_module.dart' as _i634;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final quicknoteModule = _$QuicknoteModule();
    gh.factoryAsync<_i460.SharedPreferences>(() => quicknoteModule.prefs);
    gh.singleton<_i587.AuthService>(() => _i587.AuthServiceImpl());
    return this;
  }
}

class _$QuicknoteModule extends _i634.QuicknoteModule {}
