// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InfoStore on InfoStoreBase, Store {
  final _$userInfoAtom = Atom(name: 'InfoStoreBase.userInfo');

  @override
  Map<dynamic, dynamic> get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(Map<dynamic, dynamic> value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  final _$localInfoAtom = Atom(name: 'InfoStoreBase.localInfo');

  @override
  Map<dynamic, dynamic> get localInfo {
    _$localInfoAtom.reportRead();
    return super.localInfo;
  }

  @override
  set localInfo(Map<dynamic, dynamic> value) {
    _$localInfoAtom.reportWrite(value, super.localInfo, () {
      super.localInfo = value;
    });
  }

  final _$initDataAsyncAction = AsyncAction('InfoStoreBase.initData');

  @override
  Future<void> initData() {
    return _$initDataAsyncAction.run(() => super.initData());
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo},
localInfo: ${localInfo}
    ''';
  }
}
