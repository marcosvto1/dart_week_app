import 'package:dart_week_app/app/models/movimentacao_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovimentacaoItem extends StatelessWidget {


  const MovimentacaoItem({Key key, this.item}): super(key: key);
  
  final MovimentacaoModel item;

  @override
  Widget build(BuildContext context) {

    var numberFormat = NumberFormat('###.00', 'pt_BR');
    var dateFormat = DateFormat('dd/MM/yyyy');

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child:   Text('${dateFormat.format(item.dataMovimentacao)}'),
        ),      
        ListTile(
          leading: CircleAvatar(
            backgroundColor: item.categoria.tipo == 'TipoCategoria.despesa' ? Colors.red: Colors.blue,
            child: Icon(
              item.categoria.tipo == 'TipoCategoria.despesa' ? Icons.money_off : Icons.attach_money,
             color: Colors.white,)),
          title: Text(item.descricao),
          subtitle: Text(item.categoria.nome),
          trailing: Container(
            padding: EdgeInsets.only(right: 10),
            child: Text("R\$ ${numberFormat.format(item.valor)}", 
            style: TextStyle(color:  item.categoria.tipo == 'TipoCategoria.despesa' ? Colors.red: Colors.blue),),

          ),
          onTap: () {
            print('sss');
          },
        )
      ],
    );
  }
}