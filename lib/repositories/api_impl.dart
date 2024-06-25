import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';

import 'log.dart';

class ApiImpl implements Api {

  Log log;

  List<Transaction> _data = [
    Transaction(dateTime: "2024-05-25 20:00:00", title: "a", content: "OKa", amount: 1000),
    Transaction(dateTime: "2024-07-26 21:00:00", title: "b", content: "OKb", amount: -200),
    Transaction(dateTime: "2024-07-26 22:00:00", title: "c", content: "OKc", amount: -100),
    Transaction(dateTime: "2024-07-29 21:00:00", title: "d", content: "OKd", amount: -50),

  ];

  ApiImpl(this.log) {
    _data.sort((a,b) => b.dateTime.compareTo(a.dateTime));
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<void> checkLogin(Login login) {
    delay();
    if(login.username == '1' && login.password == '1')
      return Future(() => true);
    return Future(() => false);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await delay();
    for(int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime) throw Exception(
          " Exception");
    }
    _data.add(transaction);
    _data.sort((a,b) => b.dateTime.compareTo(a.dateTime));
    }

  @override
  Future<void> deleteTransaction(String dateTime) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == dateTime) {
        _data.removeAt(i);
      }
      throw Exception(" Not found");
    }
  }

  @override
  Future<void> editTransaction(Transaction transaction) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime) {
        _data[i] = transaction;
        return;
      }
      throw Exception(" Not found");
    }
  }

  @override
  Future<List<String>> getMonths() async {
    await delay();
    Set<String> r = {};
    for(int i = 0; i < _data.length; i++) {
      var temp = _data[i].dateTime.substring(0,7) + "-01 00:00:00";
      r.add(temp);
    }
    return r.toList();
  }

  @override
  Future<double> getTotal() async {
    await delay();
    double total = 0;
    for(int i = 0; i < _data.length; i++) {
      total += _data[i].amount;
    }
    return total;
  }

  @override
  Future<List<Transaction>> getTransaction(String month) async {
    await delay();
    List<Transaction> r = [];
    for(int i = 0; i < _data.length; i++) {
      var temp = _data[i].dateTime.substring(0, 7);
      if (month.startsWith(temp))  r.add(_data[i]);
    }
    return r;
  }
}