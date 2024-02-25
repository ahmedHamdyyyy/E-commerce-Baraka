import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  final String productDescription;
  final String productName;
  final double price;
  final double discount;

  const CartWidget({
    super.key,
    required this.productDescription,
    required this.productName,
    required this.price,
    required this.discount,
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool _isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(199, 255, 255, 255),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(widget.productName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? null : 40,
                child: Text(
                  widget.productDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _isExpanded ? null : 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text("Price: \$${widget.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                const Spacer(),
                Text("Discount: ${widget.discount.toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
