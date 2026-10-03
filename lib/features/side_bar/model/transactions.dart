class Transactions {
  int? id;
  String? type;
  String? amount;
  String? currency;
  String? createdAt;

  Transactions({
    this.id,
    this.type,
    this.amount,
    this.currency,
    this.createdAt,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    currency = json['currency'];
    createdAt = json['created_at'];
  }
}
