import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumbersGrid extends StatefulWidget {
  const NumbersGrid({super.key});

  @override
  _NumbersGridState createState() => _NumbersGridState();
}

class _NumbersGridState extends State<NumbersGrid> {
  List<int> numbers = List.generate(100, (index) => index + 1);
  String selectedFilter = 'all';

  bool isEven(int number) => number % 2 == 0;

  bool isPrime(int number) {
    if (number <= 1) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false; 
    for (int i = 3; i * i <= number; i += 2) {
      // check odd divisors only
      if (number % i == 0) return false;
    }
    return true;
  }

  bool isFibonacci(int number) {
    int a = 0, b = 1;
    while (b < number) {
      int temp = b;
      b += a;
      a = temp;
    }
    return b == number 
    || number == 0;
  }

  @override
  Widget build(BuildContext context) {
    List<String> rules = ['Even', 'Odd', 'Prime', 'Fibonacci'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Number Grid',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          OverflowBar(
            alignment: MainAxisAlignment.center,
            overflowSpacing: 12,
            children: rules
                .asMap()
                .entries
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: MaterialButton(
                        color: selectedFilter == e.value
                            ? Colors.purple.shade600
                            : Colors.purple.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          setState(() {
                            selectedFilter = e.value;
                          });
                        },
                        child: Text(
                          e.value,
                          style: TextStyle(
                              color: selectedFilter == e.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
              ),
              itemCount: 100,
              itemBuilder: (context, index) {
                bool highlight = false;

                if (selectedFilter == 'Even' && isEven(numbers[index])) {
                  highlight = true;
                } else if (selectedFilter == 'Odd' && !isEven(numbers[index])) {
                  highlight = true;
                } else if (selectedFilter == 'Prime' &&
                    isPrime(numbers[index])) {
                  highlight = true;
                } else if (selectedFilter == 'Fibonacci' &&
                    isFibonacci(numbers[index])) {
                  highlight = true;
                }

                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: highlight ? Colors.blueAccent : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    numbers[index].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: highlight ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
