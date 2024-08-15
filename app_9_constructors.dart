class Transaction {
  String type;
  String desc;
  int amount;

  //Default required positional parameters constructor
  Transaction(this.type, this.desc, this.amount);

  //Named constructor
  Transaction.salary({int sal = 50})
      : type = "income",
        desc = "Salary",
        amount = sal;
  
  Transaction.rent(): type = "expense",
        desc = "Sakan",
        amount = 1500;

  //Factory constructor
  factory Transaction.fromMap(Map<String, dynamic> transactionInfo) =>
      Transaction(transactionInfo["transactionType"], transactionInfo["desc"],
          transactionInfo["amount"]);

  @override
  String toString() {
    return "Amount:$amount , Type:$type , Desc:$desc";
  }
}

void main() {
  Transaction juniorSalary = Transaction.salary(sal: 20);
  print(juniorSalary);
  Transaction seniorSalary = Transaction.salary(sal: 40);
  print(seniorSalary);

  
  Transaction rent = Transaction.rent();
  print(rent);

  Transaction mappedTransaction =
      Transaction.fromMap({"transactionType": "income", "desc": "salary", "amount": 50});
  print(mappedTransaction);
}
