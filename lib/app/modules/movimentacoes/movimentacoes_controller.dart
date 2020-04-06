import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/models/movimentacao_model.dart';
import 'package:dart_week_app/app/modules/movimentacoes/components/painel_saldo/painel_saldo_controller.dart';
import 'package:dart_week_app/app/repositories/movimentacoes_repository.dart';
import 'package:dart_week_app/app/utils/store_utils.dart';
import 'package:mobx/mobx.dart';

part 'movimentacoes_controller.g.dart';

class MovimentacoesController = _MovimentacoesControllerBase
    with _$MovimentacoesController;

abstract class _MovimentacoesControllerBase with Store {
  final MovimentacoesRepository repository;
  final PainelSaldoController painelSaldoController;

  _MovimentacoesControllerBase(this.repository, this.painelSaldoController);

  @observable
  String errorMessage;

  @observable
  ObservableList<MovimentacaoModel> movimentacoes;

  @observable
  ObservableFuture<List<MovimentacaoModel>> _movimentacoesFuture;

  @computed
  StoreState get movimentacoesState => StoreUtils.statusCheck(_movimentacoesFuture);


  @action
  Future<void> buscarMovimentacoes() async {
    try{
      _movimentacoesFuture = ObservableFuture(repository.getMovimentacoes(painelSaldoController.anoMes));
      List<MovimentacaoModel> movimentacoesResultado = await _movimentacoesFuture;
      movimentacoes = movimentacoesResultado.asObservable();
    }catch(e) {
      errorMessage = 'Erro ao buscar movimentações';
    }
  }

}
