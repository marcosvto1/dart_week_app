import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/repositories/usuario_repository.dart';
import 'package:dart_week_app/app/utils/store_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final UsuarioRepository usuarioRepository;

  _CadastroControllerBase(this.usuarioRepository);

  @observable
  String login;

  @observable
  String senha;

  @observable
  String confirmaSenha;

  @action
  changeLogin(String loginValue) {
    login = loginValue;
  }

  @action
  changeConfirmaSenha(String confirmaSenhaValue) {
    confirmaSenha = confirmaSenhaValue;
  }

  @action
  changeSenha(String senhaValue) {
    senha = senhaValue;
  }

  @observable
  ObservableFuture<void> _cadastraLoginFuture;

  @computed
  StoreState get state => StoreUtils.statusCheck(_cadastraLoginFuture);

  @observable
  String errorMessage;

  @observable
  bool cadastroLoginSuccess;

  Future<void> salvarUsuario() async {
    if (globalKey.currentState.validate()) {
      try{
        errorMessage = '';
        _cadastraLoginFuture = ObservableFuture(usuarioRepository.cadastrarUsuario(login, senha));
        await _cadastraLoginFuture;
      }catch(e) {
        print(e);
        errorMessage = 'Erro ao cadastrar usuário';
      }
    }
  }
 
}
