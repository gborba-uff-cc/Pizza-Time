// NOTE - essa rota foi desenvolvida para ser chamada a partir da rota finalizarPedido.

import 'package:flutter/material.dart';

/// Posiciona os widgets da tela onde o usuário revisa seu pedido.
///
/// ```dart
/// Navigator.pushNamed(context, [NovoEndereco.nomeTela]);
/// ```
class NovoEndereco extends StatefulWidget {
  static const nomeTela = '/novo_endereco';
  @override
  _NovoEnderecoState createState() => _NovoEnderecoState();
}

class _NovoEnderecoState extends State<NovoEndereco> {
  GlobalKey<FormState> _formNovoEnderecoKey;
  String _endereco;
  String _numero;
  String _complemento;

  @override
  void initState() {
    super.initState();
    _formNovoEnderecoKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo endereço'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SingleChildScrollView(
            child: Form(
              key: _formNovoEnderecoKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Endereço*',
                      hintText: 'Endereço para entrega',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarEndereco(value),
                    onSaved: (newValue) {
                      _endereco = newValue;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Número*',
                      hintText: 'número...',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarNumero(value),
                    onSaved: (newValue) {
                      _numero = newValue;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Complemento*',
                      hintText: 'complemento...',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarComplemento(value),
                    onSaved: (newValue) {
                      _complemento = newValue;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        RaisedButton(
          padding: Theme.of(context).buttonTheme.padding,
          child: Text(
            'salvar'.toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
          onPressed: () {
            if (_salvarEndereco()) {
              // se salvar endereço, ocorreu com sucesso então volte
              Navigator.pop(context);
            }
          },
        ),
        FlatButton(
          padding: Theme.of(context).buttonTheme.padding,
          child: Text(
            'cancelar'.toUpperCase(),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarEndereco(String value) {
    if (value.isEmpty) {
      return 'Preencha o endereço';
    }
    return null;
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarNumero(String value) {
    if (value.isEmpty) {
      return 'Preencha o número';
    }
    return null;
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarComplemento(String value) {
    if (value.isEmpty) {
      return 'Preencha o compelemento';
    }
    return null;
  }

  /// Armazena o endereço fornecido.
  ///
  /// O endereço fornecido não deve ser armazenado por tempo indefinido no perfil
  /// do cliente.
  _salvarEndereco() {
    // verdadeiro se o formulario for válido, falso caso contrário.
    if (_formNovoEnderecoKey.currentState.validate()) {
      _formNovoEnderecoKey.currentState.save();

      // endereço disponível aqui

      // TODO - salvar o endereço no banco de dados;
      return true;
    }
    return false;
  }
}
