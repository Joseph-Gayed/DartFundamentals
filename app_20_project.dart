// Typedef for filtering orders by status
typedef OrderFilter = bool Function(Order order);

// Define a filter for completed orders
OrderFilter completedOrderFilter = (Order order) {
  return order.orderState == OrderState.completed;
};

// Typedef for sorting orders by date
typedef OrderSort = int Function(Order order1, Order order2);

// Define a sorting function for sorting by most recent order date
OrderSort recentFirstSort = (Order order1, Order order2) {
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
          0, (output, current) => output + (current.value * current.key.price));
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
  double applyDiscount({required double discount, required double price}) {
    return price * ((100 - discount) / 100);
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
}

class OrderManagment {
  List<Order> orders = [];

  void placeOrder(Order order) {
    orders.add(order);
  }

  void cancelOrder(Order order) {
    orders.remove(order);
  }

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

  // Filtering orders by user
  List<Order> sortOrdersByDate() {
    return orders..sort(recentFirstSort);
  }

  // Get Last Order of a customer
  Order getMostRecentOrderOfCustomer(userName) {
    return (getCustomerOrders(userName)..sort(recentFirstSort)).first;
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

  print("completing order1...");

  await orderManagment.completeOrder(todayOrders[0]);

  print("Completed orders");
  var completedOrders =
      orderManagment.getOrders(orderState: OrderState.completed);
  completedOrders.forEach(print);

  var totalRevenue = orderManagment.calculateRevenue();
  print('Total Revenue: \$$totalRevenue');

  //calculate Total For user before discount
  Order janeSmithOrder =
      orderManagment.getMostRecentOrderOfCustomer('Jane Smith');
  print("Jane Smith order");
  double janeSmithOrderPrice = janeSmithOrder.calculateTotal();
  print("before discout = ${janeSmithOrderPrice.toCurrency()}");
  //calculate Total For user after 10% discount
  print(
      "after 10% discout = ${janeSmithOrder.applyDiscount(discount: 0.1, price: janeSmithOrderPrice)}");
}

// Extension method to format currency
extension CurrencyFormatter on double {
  String toCurrency() {
    return '\$${toStringAsFixed(2)}';
  }
}

extension MapsExtenstion on Map? {
  bool isNullOrEmpty() => (this == null || (this?.entries ?? []).isEmpty);
}
