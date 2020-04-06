import 'package:dart_week_app/app/components/controleja_button.dart';
import 'package:dart_week_app/app/components/controleja_text_form_field.dart';
import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/mixins/loader_mixin.dart';
import 'package:dart_week_app/app/utils/size_utils.dart';
import 'package:dart_week_app/app/utils/store_utils.dart';
import 'package:dart_week_app/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> with LoaderMixin {
  //use 'controller' variable to access controller
  AppBar appBar = AppBar(elevation: 0);

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
          Get.snackbar('Login Cadastro', 'Login cadastrado com sucesso');
          Get.offAllNamed('/login');
        }
      }),
      reaction((_) => controller.cadastroLoginSuccess, (success) {
        if (success != null) {
          Get.offAllNamed('/Login');
        } else {
          Get.snackbar('Erro ao realizar cadastro', 'Login ou senha Inválidos', backgroundColor: Colors.white);
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
      appBar: appBar,
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
      height: ((SizeUtils.heightScreen) * .4) - (SizeUtils.statusBarHeight + appBar.preferredSize.height),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //Image.asset('assets')
          Positioned(
            bottom: 50,
            child: Text('A logo aqui'),
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
                  return 'Campo obrigatŕoio';
                } 
                return null;
              }  
            ),
            SizedBox(height: 30,),
            ControleJaTextFormField(
              label: 'Senha', 
              obscureText: false,
              onChanged: controller.changeSenha,
              validator: (String valor) {
                if (valor.isEmpty) {
                  return 'Campo obrigatŕoio';
                } 
                return null;
              }  
            ),
            SizedBox(height: 30,),
            ControleJaTextFormField(label: 'Confirme Senha', obscureText: false,
              onChanged: controller.changeConfirmaSenha,
              validator: (String valor) {
                if (valor.isNotEmpty) {
                  if (valor != controller.senha) {
                    return 'Senha diferente de confirma senha';
                  }      
                } else {
                  return 'Confirma senha obrigatório';
                }
                return null;
              }  
            ),
            SizedBox(height: 30,),
            ControleJaButton(label: 'Salvar', onPressed: controller.salvarUsuario,),
            SizedBox(height: 30,),           
          ],
        ),
      ),
    );
  }
}
