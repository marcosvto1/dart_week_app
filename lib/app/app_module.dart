import 'package:dart_week_app/app/app_controller.dart';
import 'package:dart_week_app/app/modules/cadastro/cadastro_module.dart';
import 'package:dart_week_app/app/modules/login/login_module.dart';
import 'package:dart_week_app/app/modules/movimentacoes/movimentacoes_module.dart';
import 'package:dart_week_app/app/repositories/usuario_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:dart_week_app/app/app_widget.dart';
import 'package:dart_week_app/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => UsuarioRepository())
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
        Router('/login', module: LoginModule()),
        Router('/cadastro', module: CadastroModule()),
        Router('/movimentacoes', module: MovimentacoesModule())
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
