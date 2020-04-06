import 'package:dart_week_app/app/components/controleja_button.dart';
import 'package:dart_week_app/app/components/controleja_text_form_field.dart';
import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/mixins/loader_mixin.dart';
import 'package:dart_week_app/app/utils/size_utils.dart';
import 'package:dart_week_app/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> with LoaderMixin {
  //use 'controller' variable to access controller

  List<ReactionDisposer> _disposer;

  @override
  void initState() {
    super.initState();

    _disposer ??= [
      reaction((_) => controller.state, (StoreState state) {
        if (state == StoreState.loading) {
          // Chamar um loading
          showLoader();
        } else if (state == StoreState.loaded) {
          // Esconder o load
          hideLoader();
        }
      }),
      reaction((_) => controller.loginSuccess, (success) {
        if (success != null && success) {
          Get.offAllNamed('/movimentacoes');
        } else {
          Get.snackbar('Erro ao realizar login', 'Login ou senha Inválidos', backgroundColor: Colors.white);
          //hideLoader();
        }
      }),
      reaction((_) => controller.errorMessage, (String errorMessage) {
        if (errorMessage.isNotEmpty) {
          // esconder o loadnig
          hideLoader();
          Get.snackbar('Erro ao realizar login', errorMessage , backgroundColor: Colors.white);
        }
      })
    ]; 

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            _makeHeader(),
            SizedBox(height: 30,),
            _makeForm(),
          ],
        ),
      ),
    );
  }

  Widget _makeHeader() {
    return Container(
      width: SizeUtils.widthScreen,
      color: ThemeUtils.primmaryColor,
      height: ((SizeUtils.heightScreen) * .5) - SizeUtils.statusBarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //Image.asset('assets')
          Positioned(
            bottom: 50,
            child: Image.asset('assets/images/logo.png')
          )
        ],
      ),
    );
  }

  Form _makeForm() {
    return Form(
      key: controller.globalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        
        child: Column(
          children: <Widget>[
            ControleJaTextFormField(
              label: 'Login', 
              onChanged: controller.changeLogin,
              validator: (String valor) {
                if (valor.isEmpty) {
                  return 'Senha Obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            ControleJaTextFormField(
              label: 'Senha', 
              obscureText: true,
              onChanged: controller.changeSenha,
              validator: (String valor) {
                if (valor.isEmpty) {
                  return 'Senha Obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 30,),
            ControleJaButton(label: 'Entrar', onPressed: controller.requestLogin),
            SizedBox(height: 30,),
            FlatButton(
              onPressed: () {
                Get.toNamed('/cadastro');
              },
              child: Text('Cadastra-se', 
              style: TextStyle(color: ThemeUtils.primmaryColor, fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}
