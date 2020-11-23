import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';

/// Edita um item dentro do pedido.
///
/// Modifica a quantidade, ou remove da lista de pedido.
class DialogEditarItem extends StatefulWidget {
  /// Contrói o editor de entradas do carrinho.
  ///
  /// Usa Notifiers para recber um objeto do tipo [Carrinho] e [ItemCarrinho].
  DialogEditarItem();

  @override
  _DialogEditarItemState createState() => _DialogEditarItemState();
}

class _DialogEditarItemState extends State<DialogEditarItem> {
  CarrinhoNotifier _carrinhoNotifier;
  ItemCarrinhoNotifier _itemCarrinhoNotifier;
  int _quantidade;

  void initState() {
    super.initState();
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    _itemCarrinhoNotifier = Provider.of<ItemCarrinhoNotifier>(context);
    _quantidade = _itemCarrinhoNotifier.quantidadeItemAtual;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${_itemCarrinhoNotifier.nomeItemAtual}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacer(),
              IconButton(
                constraints: BoxConstraints.tightFor(),
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () {
                  _carrinhoNotifier
                      .removerItem(_itemCarrinhoNotifier.itemAtual);
                },
              ),
            ],
          ),
        ),
        AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              _itemCarrinhoNotifier.urlImagemItemAtual,
              fit: BoxFit.fitWidth,
            )
            // ANCHOR - remover
            // child: Container(
            //   color: Colors.teal[200],
            // ),
            ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Valor unitário: R\$ ${_itemCarrinhoNotifier.valorUnitarioItemAtual}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        _buildEditorQuantidade(context),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Subtotal: R\$ ${_itemCarrinhoNotifier.valorTotalItemAtual.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ok'.toUpperCase(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: () {
                if (_quantidade == 0) {
                  _carrinhoNotifier
                      .removerItem(_itemCarrinhoNotifier.itemAtual);
                  return;
                }
                if (_quantidade != _itemCarrinhoNotifier.quantidadeItemAtual) {
                  _itemCarrinhoNotifier.quantidadeItemAtual = _quantidade;
                  return;
                }
              },
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'cancelar'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Contrói a barra de edição da quantidade do item.
  Widget _buildEditorQuantidade(BuildContext context) {
    return Table(
      columnWidths: {1: FlexColumnWidth(0.4)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _quantidade--;
                  });
                },
              ),
            ),
            Text(
              '$_quantidade',
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                color: Colors.green,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _quantidade++;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
