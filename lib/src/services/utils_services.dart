import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

class UtilsServices {
// CRUD LOCAL PARA SALVAR TOKEN

  final storage = const FlutterSecureStorage();

// SALVA TOKEN

  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

// RECUPERA TOKEN
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

//DELETA TOKEN

  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

// FIM DO CRUD LOCAL

  //R$ valor
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : Colors.white,
        textColor: isError ? Colors.white : Colors.black,
        fontSize: 14.0);
  }
}
