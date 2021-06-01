// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JobStore on _JobStore, Store {
  final _$queryAtom = Atom(name: '_JobStore.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$jobsAtom = Atom(name: '_JobStore.jobs');

  @override
  List<Job> get jobs {
    _$jobsAtom.reportRead();
    return super.jobs;
  }

  @override
  set jobs(List<Job> value) {
    _$jobsAtom.reportWrite(value, super.jobs, () {
      super.jobs = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_JobStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isInitTextAtom = Atom(name: '_JobStore.isInitText');

  @override
  bool get isInitText {
    _$isInitTextAtom.reportRead();
    return super.isInitText;
  }

  @override
  set isInitText(bool value) {
    _$isInitTextAtom.reportWrite(value, super.isInitText, () {
      super.isInitText = value;
    });
  }

  final _$loadingErrorAtom = Atom(name: '_JobStore.loadingError');

  @override
  bool get loadingError {
    _$loadingErrorAtom.reportRead();
    return super.loadingError;
  }

  @override
  set loadingError(bool value) {
    _$loadingErrorAtom.reportWrite(value, super.loadingError, () {
      super.loadingError = value;
    });
  }

  final _$loadJobAsyncAction = AsyncAction('_JobStore.loadJob');

  @override
  Future<void> loadJob() {
    return _$loadJobAsyncAction.run(() => super.loadJob());
  }

  final _$_JobStoreActionController = ActionController(name: '_JobStore');

  @override
  void setQuery(String text) {
    final _$actionInfo =
        _$_JobStoreActionController.startAction(name: '_JobStore.setQuery');
    try {
      return super.setQuery(text);
    } finally {
      _$_JobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initText() {
    final _$actionInfo =
        _$_JobStoreActionController.startAction(name: '_JobStore.initText');
    try {
      return super.initText();
    } finally {
      _$_JobStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
jobs: ${jobs},
isLoading: ${isLoading},
isInitText: ${isInitText},
loadingError: ${loadingError}
    ''';
  }
}
