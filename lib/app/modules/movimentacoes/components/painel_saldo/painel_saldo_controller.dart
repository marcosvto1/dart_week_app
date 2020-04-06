import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/models/movimentacao_total_item_model.dart';
import 'package:dart_week_app/app/models/movimentacao_total_model.dart';
import 'package:dart_week_app/app/repositories/movimentacoes_repository.dart';
import 'package:dart_week_app/app/utils/store_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'painel_saldo_controller.g.dart';

class PainelSaldoController = _PainelSaldoControllerBase
    with _$PainelSaldoController;

abstract class _PainelSaldoControllerBase with Store {

  _PainelSaldoControllerBase(this.repository);

  final MovimentacoesRepository repository;

  @observable
  DateTime data = DateTime.now();

  @computed
  String get anoMes => DateFormat('yyyyMM').format(data);

  @action
  nextMonth() {
    data = DateTime(data.year, data.month + 1, 1);
  }

  @action
  previousMonth() {
    data = DateTime(data.year, data.month - 1, 1);
  }

  @observable
  String erroMessage;

  @observable
  ObservableFuture<MovimentacaoTotalModel> _totalMovimentacao;

  @computed
  StoreState get totalState => StoreUtils.statusCheck(_totalMovimentacao);

  @observable
  MovimentacaoTotalModel movimentacaoTotal;
  
  @action
  buscarTotalDoMes() async{
    try {
      erroMessage = '';
      _totalMovimentacao = ObservableFuture(repository.getTotalMes(anoMes));
      movimentacaoTotal = await _totalMovimentacao;
    }catch(e) {
      print(e);
      erroMessage = 'Falha ao carregar movimentação total';
    }

  }


}
