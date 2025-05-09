import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final int _ticketQuantity = 1;
  int _adultsCount = 1;
  int _childrenCount = 0;
  String _selectedDate = "Select Date";
  String _selectedMuseum = "Museum 1";
  bool _cameraSelected = false;

  // Example prices in INR (Indian Rupees)
  final double _ticketPrice = 1500.0; // Price per adult ticket in INR
  final double _childrenPrice = 800.0; // Price per child ticket in INR
  final double _cameraPrice = 1000.0; // Camera rental price in INR
  double _totalPrice = 1500.0;

  // Example list of museums
  List<String> museums = ["Museum 1", "Museum 2", "Museum 3"];

  // Method to update the total price
  void _updateTotalPrice() {
    setState(() {
      _totalPrice = (_adultsCount * _ticketPrice) +
          (_childrenCount * _childrenPrice) +
          (_cameraSelected ? _cameraPrice : 0);
    });
  }

  // Method to select the number of adults
  void _increaseAdults() {
    setState(() {
      _adultsCount++;
      _updateTotalPrice();
    });
  }

  void _decreaseAdults() {
    if (_adultsCount > 1) {
      setState(() {
        _adultsCount--;
        _updateTotalPrice();
      });
    }
  }

  // Method to select the number of children
  void _increaseChildren() {
    setState(() {
      _childrenCount++;
      _updateTotalPrice();
    });
  }

  void _decreaseChildren() {
    if (_childrenCount > 0) {
      setState(() {
        _childrenCount--;
        _updateTotalPrice();
      });
    }
  }

  // Method to select date
  void _selectDate() async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2025),
  );
  if (picked != null) { // Remove the comparison with DateTime.now()
    setState(() {
      _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
    });
  }
}

  // Method to proceed to payment
  void _proceedToPayment() {
    // Navigate to the payment screen (update with your actual route)
    Navigator.pushNamed(context, '/payment');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Book Tickets', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Museum selection
            const Text('Select Museum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedMuseum,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMuseum = newValue!;
                });
              },
              items: museums.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Ticket quantity selection
            const Text('Select Tickets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decreaseAdults,
                ),
                Text('Adults: $_adultsCount', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _increaseAdults,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decreaseChildren,
                ),
                Text('Children: $_childrenCount', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _increaseChildren,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Camera rental option
            Row(
              children: <Widget>[
                Checkbox(
                  value: _cameraSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      _cameraSelected = value!;
                      _updateTotalPrice();
                    });
                  },
                ),
                Text('Rent a Camera (₹$_cameraPrice)', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),

            // Date picker with InkWell for better touch interaction
            GestureDetector(
              onTap: _selectDate,
              child: InkWell(
                onTap: _selectDate,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(_selectedDate, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Total Price display
            Text(
              'Total Price: ₹${_totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),

            // Book Now button
            Center(
              child: ElevatedButton(
                onPressed: _proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Correct parameter name for button color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Book Now', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
