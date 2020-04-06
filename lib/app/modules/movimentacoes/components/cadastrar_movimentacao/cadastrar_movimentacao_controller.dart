import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/models/categoria_model.dart';
import 'package:dart_week_app/app/repositories/categoria_repository.dart';
import 'package:dart_week_app/app/repositories/movimentacoes_repository.dart';
import 'package:dart_week_app/app/utils/store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'cadastrar_movimentacao_controller.g.dart';

class CadastrarMovimentacaoController = _CadastrarMovimentacaoControllerBase
    with _$CadastrarMovimentacaoController;

abstract class _CadastrarMovimentacaoControllerBase with Store {
  CategoriaRepository _categoriaRepository = Modular.get<CategoriaRepository>();
  MovimentacoesRepository _movimentacoesRepository =
      Modular.get<MovimentacoesRepository>();

  final formKey = GlobalKey<FormState>();
  final moneyController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @observable
  DateTime dataInclusao = DateTime.now();

  @observable
  String errorMessage;

  @observable
  String tipoSelecionado;

  @observable
  List<CategoriaModel> categorias;

  @observable
  bool categoriaValid = true;

  @observable
  CategoriaModel categoria;

  @observable
  String descricao;

  @observable
  double valor;

  @action
  void changeCategoria(CategoriaModel categoriaModel) {
    categoria = categoriaModel;
  }

  @action
  void changeDescricao(String descricao) {
    this.descricao = descricao;
  }

  @action
  void changeValor(double valor) {
    this.valor = valor;
  }

  ObservableFuture<List<CategoriaModel>> _categoriaFuture;

  @computed
  StoreState get categoriaStatus => StoreUtils.statusCheck(_categoriaFuture);

  @action
  void setDataInclusao(DateTime data) {
    dataInclusao = data;
  }

  @action
  Future<void> buscarCategorias(String tipo) async {
    try {
      tipoSelecionado = tipo;
      _categoriaFuture =
          ObservableFuture(_categoriaRepository.getCategorias(tipo));
      List<CategoriaModel> categoriaModel = await _categoriaFuture;
      categorias = categoriaModel;
    } catch (e) {
      errorMessage = 'Erro ao buscar categorias';
      print(e);
    }
  }

  @observable
  ObservableFuture _salvarMovimentacaoFuture;

  @computed
  StoreState get salvarMovimentacaoStatus =>
      StoreUtils.statusCheck(_salvarMovimentacaoFuture);

  @action
  Future<void> salvarMovimento() async {
    try {
      if (formKey.currentState.validate()) {
        if (categoria == null) {
          categoriaValid = null;
        } else {
          _salvarMovimentacaoFuture = ObservableFuture(
              _movimentacoesRepository.salvarMovimentacao(
                categoria.id, 
                dataInclusao,
                descricao,
                moneyController.numberValue                
              ));

          await _salvarMovimentacaoFuture;
        }
      } else {
        if (categoria == null) {
          categoriaValid = false;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
