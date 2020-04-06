// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painel_saldo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PainelSaldoController on _PainelSaldoControllerBase, Store {
  Computed<String> _$anoMesComputed;

  @override
  String get anoMes =>
      (_$anoMesComputed ??= Computed<String>(() => super.anoMes)).value;
  Computed<StoreState> _$totalStateComputed;

  @override
  StoreState get totalState =>
      (_$totalStateComputed ??= Computed<StoreState>(() => super.totalState))
          .value;

  final _$dataAtom = Atom(name: '_PainelSaldoControllerBase.data');

  @override
  DateTime get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(DateTime value) {
    _$dataAtom.context.conditionallyRunInAction(() {
      super.data = value;
      _$dataAtom.reportChanged();
    }, _$dataAtom, name: '${_$dataAtom.name}_set');
  }

  final _$erroMessageAtom =
      Atom(name: '_PainelSaldoControllerBase.erroMessage');

  @override
  String get erroMessage {
    _$erroMessageAtom.context.enforceReadPolicy(_$erroMessageAtom);
    _$erroMessageAtom.reportObserved();
    return super.erroMessage;
  }

  @override
  set erroMessage(String value) {
    _$erroMessageAtom.context.conditionallyRunInAction(() {
      super.erroMessage = value;
      _$erroMessageAtom.reportChanged();
    }, _$erroMessageAtom, name: '${_$erroMessageAtom.name}_set');
  }

  final _$_totalMovimentacaoAtom =
      Atom(name: '_PainelSaldoControllerBase._totalMovimentacao');

  @override
  ObservableFuture<MovimentacaoTotalModel> get _totalMovimentacao {
    _$_totalMovimentacaoAtom.context
        .enforceReadPolicy(_$_totalMovimentacaoAtom);
    _$_totalMovimentacaoAtom.reportObserved();
    return super._totalMovimentacao;
  }

  @override
  set _totalMovimentacao(ObservableFuture<MovimentacaoTotalModel> value) {
    _$_totalMovimentacaoAtom.context.conditionallyRunInAction(() {
      super._totalMovimentacao = value;
      _$_totalMovimentacaoAtom.reportChanged();
    }, _$_totalMovimentacaoAtom, name: '${_$_totalMovimentacaoAtom.name}_set');
  }

  final _$movimentacaoTotalAtom =
      Atom(name: '_PainelSaldoControllerBase.movimentacaoTotal');

  @override
  MovimentacaoTotalModel get movimentacaoTotal {
    _$movimentacaoTotalAtom.context.enforceReadPolicy(_$movimentacaoTotalAtom);
    _$movimentacaoTotalAtom.reportObserved();
    return super.movimentacaoTotal;
  }

  @override
  set movimentacaoTotal(MovimentacaoTotalModel value) {
    _$movimentacaoTotalAtom.context.conditionallyRunInAction(() {
      super.movimentacaoTotal = value;
      _$movimentacaoTotalAtom.reportChanged();
    }, _$movimentacaoTotalAtom, name: '${_$movimentacaoTotalAtom.name}_set');
  }

  final _$buscarTotalDoMesAsyncAction = AsyncAction('buscarTotalDoMes');

  @override
  Future buscarTotalDoMes() {
    return _$buscarTotalDoMesAsyncAction.run(() => super.buscarTotalDoMes());
  }

  final _$_PainelSaldoControllerBaseActionController =
      ActionController(name: '_PainelSaldoControllerBase');

  @override
  dynamic nextMonth() {
    final _$actionInfo =
        _$_PainelSaldoControllerBaseActionController.startAction();
    try {
      return super.nextMonth();
    } finally {
      _$_PainelSaldoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousMonth() {
    final _$actionInfo =
        _$_PainelSaldoControllerBaseActionController.startAction();
    try {
      return super.previousMonth();
    } finally {
      _$_PainelSaldoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'data: ${data.toString()},erroMessage: ${erroMessage.toString()},movimentacaoTotal: ${movimentacaoTotal.toString()},anoMes: ${anoMes.toString()},totalState: ${totalState.toString()}';
    return '{$string}';
  }
}
