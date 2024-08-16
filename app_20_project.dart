// Typedef for sorting orders by date
typedef OrderSort = int Function(Order order1, Order order2);

// Define a sorting function for sorting by most recent order date
OrderSort sortByDateRecentFirst = (Order order1, Order order2) {
  return order2.orderDate.compareTo(order1.orderDate); // Most recent first
};

enum CoffeeSize { small, medium, large } // Enum for coffee sizes

enum CoffeeAddOn {
  milk("Milk", 25),
  sugar("Sugar", 15),
  cream("Cream", 20);

  final String name;
  final int price;
  const CoffeeAddOn(this.name, this.price);
} // Enum for coffee add-ons

enum OrderState { completed, pending }

abstract class Coffee {
  int id;
  String name;
  double price;
  CoffeeSize size;
  Map<CoffeeAddOn, int>? addOnsWithAmount;

  Coffee({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    this.addOnsWithAmount,
  });

  double calculateTotalPrice() {
    return price + calculateAddonsPrice();
  }

  double calculateAddonsPrice() {
    if (addOnsWithAmount.isNullOrEmpty()) {
      return 0;
    } else {
      return addOnsWithAmount!.entries.fold(
          0, (output, MapEntry currentEntry) => output + (currentEntry.value * currentEntry.key.price));
    }
  }

  @override
  String toString() {
    List<String> addonsNames = addOnsWithAmount?.entries
            .map((entries) => "${entries.value}: ${entries.key.name}")
            .toList() ??
        [];
    return "ID: $id, Name: $name, Price: $price , Size: ${size.name} , addons: $addonsNames";
  }
}

class Espresso extends Coffee {
  Espresso({
    required super.id,
    required super.size,
    super.addOnsWithAmount,
  }) : super(name: 'Espresso', price: 3.0);
}

class Latte extends Coffee with Discountable {
  Latte({
    required super.id,
    required super.size,
    super.addOnsWithAmount,
  }) : super(name: 'Latte', price: 4.0);
}

// Mixin for discount functionality
mixin Discountable {
  double applyDiscount({required double discountPercentage, required double priceBeforeDiscount}) {
    return priceBeforeDiscount * ((100 - discountPercentage) / 100);
  }
}

class Order with Discountable {
  int orderId;
  String customerName;
  DateTime orderDate;
  List<Coffee> coffees;
  OrderState orderState;

  Order({
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.coffees,
    this.orderState = OrderState.pending,
  });

  void completeOrder() {
    orderState = OrderState.completed;
  }

  double calculateTotal() {
    return coffees.fold(
        0.0, (sum, coffee) => sum + coffee.calculateTotalPrice());
  }

  @override
  String toString() {
    List<String> coffeeNames = coffees.map((cof) => cof.toString()).toList();
    return "${orderState.name.toUpperCase()} Order for $customerName was ordered on $orderDate. \n Ordered items are $coffeeNames. \n TotalPrice: ${calculateTotal()}";
  }

  double getPriceAfterDiscount(){
    double priceBeforeDiscount = calculateTotal();

    if(priceBeforeDiscount>100){
      return applyDiscount(discountPercentage: 0.3, priceBeforeDiscount: priceBeforeDiscount);
    }
    else{
      return priceBeforeDiscount;
    }
  }
}

class OrderManagment {
  List<Order> orders = [];

  void placeOrder(Order order) {
    orders.add(order);
  }

  void cancelOrder(Order order) {
    orders.remove(order);
  }

  //simulate process that takes time
  Future<void> completeOrder(Order order) async {
    await Future.delayed(Duration(seconds: 3));
    order.completeOrder();
  }

  // Filtering orders by completion status
  List<Order> getOrders({OrderState? orderState}) {
    return orderState != null
        ? orders.where((order) => order.orderState == orderState).toList()
        : orders;
  }

  // Filtering orders by user
  List<Order> getCustomerOrders(userName) {
    return orders.where((order) => order.customerName == userName).toList();
  }

  // Sorting by date , sort function is void, but we need to sort the orders and return the sorted orders.. so we used cascade
  List<Order> sortOrdersByDate() {
    return orders..sort(sortByDateRecentFirst);
  }

  // Get Last Order of a customer
  Order getMostRecentOrderOfCustomer(userName) {
    var customerOrders = getCustomerOrders(userName);
    var sortedOrders = customerOrders..sort(sortByDateRecentFirst);
    return sortedOrders.first;
  }

  // Calculating total revenue from completed orders
  double calculateRevenue() => getOrders(orderState: OrderState.completed)
      .fold(0.0, (sum, order) => sum + order.calculateTotal());
}

void main() async {
  OrderManagment orderManagment = OrderManagment();

  List<Order> todayOrders = [
    Order(
      orderId: 1,
      customerName: 'John Doe',
      orderDate: DateTime.now(),
      coffees: [
        Espresso(
            id: 1,
            size: CoffeeSize.small,
            addOnsWithAmount: {CoffeeAddOn.milk: 2, CoffeeAddOn.sugar: 3})
      ],
    ),
    Order(
      orderId: 1,
      customerName: 'Jane Smith',
      orderDate: DateTime.now().add(Duration(days: -1)),
      coffees: [
        Latte(
            id: 1,
            size: CoffeeSize.large,
            addOnsWithAmount: {CoffeeAddOn.cream: 2, CoffeeAddOn.sugar: 4})
      ],
    ),
    
    Order(
      orderId: 1,
      customerName: 'Jane Smith',
      orderDate: DateTime.now().add(Duration(days: -5)),
      coffees: [
        Espresso(
            id: 1,
            size: CoffeeSize.medium,
            addOnsWithAmount: {CoffeeAddOn.milk: 1, CoffeeAddOn.sugar: 2})
      ],
    ),
  ];

  todayOrders.forEach(orderManagment.placeOrder);

  print("Pending orders");
  var pendingOrders = orderManagment.getOrders(orderState: OrderState.pending);
  pendingOrders.forEach(print);

  print("--------------------------------");
  print("completing order1...");

  await orderManagment.completeOrder(todayOrders[0]);

  print("Completed orders");
  var completedOrders =
      orderManagment.getOrders(orderState: OrderState.completed);
  completedOrders.forEach(print);

  print("--------------------------------");

  var totalRevenue = orderManagment.calculateRevenue();
  print('Total Revenue: \$$totalRevenue');

  print("--------------------------------");
  //calculate Total For user before discount
  Order janeSmithOrder = orderManagment.getMostRecentOrderOfCustomer('Jane Smith');
  print("Jane Smith order");
  double janeSmithOrderPriceBeforeDiscount = janeSmithOrder.calculateTotal();
  print("before discout = ${janeSmithOrderPriceBeforeDiscount.toCurrency()}");
  double janeSmithOrderPriceAfterDiscount = janeSmithOrder.getPriceAfterDiscount();
  print("after discout = ${janeSmithOrderPriceAfterDiscount.toCurrency()}");
}

// Extension method to format currency
extension CurrencyFormatter on double {
  String toCurrency() {
    return '\$ ${toStringAsFixed(2)}';
  }
}

extension MapsExtenstion on Map? {
  bool isNullOrEmpty() => (this == null || (this?.entries ?? []).isEmpty);
}
