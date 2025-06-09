import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PageKurir extends StatefulWidget {
  const PageKurir({Key? key}) : super(key: key);

  @override
  _PageKurirState createState() => _PageKurirState();
}

class _PageKurirState extends State<PageKurir>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courier Dashboard',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Delivery History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProfileTab(),
          DeliveryHistoryTab(),
        ],
      ),
    );
  }
}

// Profile Tab
class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in'));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('couriers')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Profile not found'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/64'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'ID: ${data['courierId'] ?? 'N/A'}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Phone: ${data['phone'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Email: ${data['email'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Vehicle: ${data['vehicle'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Delivery History Tab
class DeliveryHistoryTab extends StatelessWidget {
  const DeliveryHistoryTab({Key? key}) : super(key: key);

  Future<void> _updateDeliveryStatus(String deliveryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('deliveries')
          .doc(deliveryId)
          .update({'status': 'Completed'});
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('deliveries')
          .where('courierId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No deliveries found'));
        }

        final deliveries = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: deliveries.length,
          itemBuilder: (context, index) {
            final delivery = deliveries[index].data() as Map<String, dynamic>;
            final deliveryId = deliveries[index].id;
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery #${delivery['deliveryId'] ?? 'N/A'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'To: ${delivery['recipient'] ?? 'N/A'}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            delivery['address'] ?? 'N/A',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(
                              (delivery['date'] as Timestamp).toDate(),
                            )}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Status: ${delivery['status'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: delivery['status'] == 'Completed'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (delivery['status'] == 'In Progress')
                      TextButton(
                        onPressed: () => _updateDeliveryStatus(deliveryId),
                        child: const Text(
                          'Mark Complete',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
