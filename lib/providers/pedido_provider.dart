import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';

class PedidoProvider with ChangeNotifier {
  List<PedidoEstado> _estados = [];

  List<PedidoEstado> get estados => _estados;

  void inicializarEstados(List<PedidoEstado> estadosIniciales) {
    _estados = estadosIniciales;
    notifyListeners();
  }

  void actualizarEstado(PedidoEstado nuevoEstado,) {
    _estados.add(nuevoEstado);
    notifyListeners();
  }
}