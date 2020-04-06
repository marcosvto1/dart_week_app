import 'package:dart_week_app/app/core/store_state.dart';
import 'package:dart_week_app/app/modules/movimentacoes/components/painel_saldo/painel_saldo_controller.dart';
import 'package:dart_week_app/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:mobx/mobx.dart';

class PainelSaldoWidget extends StatefulWidget {
  final double appBarHeight;

  PainelSaldoWidget(this.appBarHeight);

  @override
  _PainelSaldoWidgetState createState() => _PainelSaldoWidgetState();
}

class _PainelSaldoWidgetState
    extends ModularState<PainelSaldoWidget, PainelSaldoController> {
  List<ReactionDisposer> disposers;

  @override
  void initState() {
    super.initState();
    disposers ??= [
      reaction((_) => controller.data, (_) {
        controller.buscarTotalDoMes();
      })
    ];
    controller.buscarTotalDoMes();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingSheet(
        elevation: 8,
        cornerRadius: 30,
        snapSpec: SnapSpec(
            snap: true,
            snappings: [0.1, 0.4],
            positioning: SnapPositioning.relativeToAvailableSpace),
        headerBuilder: (_, state) {
          return Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)));
        },
        builder: (_, state) {
          return Observer(builder: (_) {
            switch (controller.totalState) {
              case StoreState.initial:
              case StoreState.loading:
                return Container(
                  height: SizeUtils.heightScreen,
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(),
                  ),
                );
              case StoreState.loaded:
                return _makeContent();
              case StoreState.error:
                Get.snackbar('Erro ao buscar dados', controller.erroMessage);
                return Container();
            }
          });
        });
  }

  Widget _makeContent() {
    var model = controller.movimentacaoTotal;
    var numberFormat = NumberFormat('####.00', 'pt_BR');

    return Container(
      width: SizeUtils.widthScreen,
      height: SizeUtils.heightScreen * .4 - widget.appBarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => controller.previousMonth()),
              //Top format DateFormat.yMMMM('pt_BR').format(controller.data)
              Text(DateFormat.yMMMM('pt_BR').format(controller.data),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: model.saldo < 0 ? Colors.red : Colors.green)),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => controller.nextMonth(),
              )
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Column(
            children: <Widget>[
              Text('Saldo'),
              Text(
                'R\$ ${model.saldo != null ? numberFormat.format(model.saldo) : '-'}',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: model.saldo < 0 ? Colors.red : Colors.green),
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF4BCE97),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.arrow_upward),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Receitas',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4BCE97),
                          ),
                        ),
                        Text(
                          'R\$ ${model.receitas.total != null ? numberFormat.format(model.receitas.total) : '-'}',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF4BCE97)),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Despesas',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'R\$ ${model.despesas.total != null ? numberFormat.format(model.despesas.total) : '-'}',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
