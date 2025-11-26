import 'package:flutter/material.dart';
import 'product_list_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  final double total;

  const OrderConfirmationPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final tax = (total + 5.0) * 0.1;
    final finalTotal = total + 5.0 + tax;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text('Order Confirmation'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.green, size: 70),
                ),
                const SizedBox(height: 24),
                const Text('Payment Successful!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('Thank you for your purchase',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(height: 32),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Text('\$${total.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipping:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            const Text('\$5.00',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tax (10%):', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Text('\$${tax.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Amount:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$${finalTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00))),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Order ID:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Text('#${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Status:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Confirmed',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.withOpacity(0.2)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What\'s Next?',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00))),
                      SizedBox(height: 12),
                      Text(
                        '• A confirmation email will be sent shortly\n• Your order will be shipped within 2-3 business days\n• Track your order from your account',
                        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const ProductListPage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B00),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Continue Shopping',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
