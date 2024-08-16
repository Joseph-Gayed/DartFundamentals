/**
 * Map, Where , Reduce ,Fold
 */

class Transaction {
  String type;
  String desc;
  int amount;

  Transaction({required this.type, required this.desc, required this.amount});
  @override
  String toString() {
    return "Amount:$amount , Type:$type , Desc:$desc";
  }
}

class Budget {
  List<Transaction> transactions = [];

  void addTransaction(Transaction t) {
    transactions.add(t);
  }

//Use map to convert List<A> to List<B> .
  List<String> getBeautifiedTransactions() {
    // return transactions
    //     .map((Transaction t) => "${t.type} : ${t.amount} : ${t.desc}")
    //     .toList();
    return transactions.map((t) => "$t").toList();
  }

//Use Where to filter list of items to other list of items that match a specific criteria.
  List<Transaction> filterTransactionsByType(String inputType) {
    return transactions
        .where((Transaction transaction) => transaction.type == inputType)
        .toList();
  }

//Use fisrt Where to filter list of items to the first single item that match a specific criteria.
  Transaction getFirstTransactionWithType(String inputType) {
    return transactions
        .firstWhere((Transaction transaction) => transaction.type == inputType);
  }

  int calculateTotalWithoutFold(String inputType) {
    List<Transaction> filteredTransactions =
        filterTransactionsByType(inputType);

    int sumOfAmounts = 0;
    filteredTransactions.forEach((Transaction t) => sumOfAmounts += t.amount);
    return sumOfAmounts;
  }

  int calculateTotalWithFold(String inputType) {
    List<Transaction> filteredTransactions =
        filterTransactionsByType(inputType);

    String comaSeparatedDescriptions =
        filteredTransactions.fold("", (output, current) {
      if (output.isEmpty) {
        return current.desc;
      } else {
        return "$output , ${current.desc}";
      }
    });

    print("----------------");
    print("Fold with Strings:");
    print(comaSeparatedDescriptions);

    return filteredTransactions.fold(
        0, (int output, Transaction current) => output + current.amount);
  }

  Transaction getMaxTransaction(String inputType) {
    List<Transaction> filteredTransactions =
        filterTransactionsByType(inputType);

    return filteredTransactions
        .reduce((Transaction output, Transaction currentTransaction) {
      if (output.amount > currentTransaction.amount) {
        return output;
      } else {
        return currentTransaction;
      }
    });
  }
}

void main() {
  Budget budget = Budget();
  List<Transaction> transactions = [
    Transaction(type: "income", desc: "salary", amount: 50),
    Transaction(type: "income", desc: "resturant", amount: 200),
    Transaction(type: "income", desc: "freelance", amount: 60),
    Transaction(type: "expense", desc: "employees", amount: 100),
    Transaction(type: "expense", desc: "food", amount: 40),
  ];

  transactions.forEach((t) => budget.addTransaction(t));

  print("Fold function example");
  int totalIncome = budget.calculateTotalWithFold("income");
  print("Total Income with Fold:$totalIncome");

  int totalExpenses = budget.calculateTotalWithFold("expense");
  print("Total expense with Fold:$totalExpenses");

  print("-----------");
  print("map function example");
  budget.getBeautifiedTransactions().forEach(print);

  print("-----------");
  print("Reduce function example");

  Transaction maxIncomeTransaction = budget.getMaxTransaction("income");
  print("Max Income Transaction = $maxIncomeTransaction");

  Transaction maxExpenseTransaction = budget.getMaxTransaction("expense");
  print("Max Expense Transaction = $maxExpenseTransaction");
}
