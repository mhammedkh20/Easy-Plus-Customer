import 'package:easy_plus_customer/features/side_bar/model/transactions.dart';

class WalletObject {
  int? id;
  String? balance;
  String? currency;
  List<Transactions>? transactions;

  WalletObject({this.id, this.balance, this.currency, this.transactions});

  WalletObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    currency = json['currency'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }
}
