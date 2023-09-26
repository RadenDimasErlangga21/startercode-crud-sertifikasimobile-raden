// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:crud_sederhana_raden/screens/pengaturan.dart';
import 'package:crud_sederhana_raden/services/pemasukan_service.dart';
import 'package:crud_sederhana_raden/services/pengeluaran_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_sederhana_raden/helpers/drawer_navigation.dart';
import 'package:crud_sederhana_raden/screens/pemasukan_screen.dart';
import 'package:crud_sederhana_raden/screens/pengeluaran_screen.dart';
import 'package:crud_sederhana_raden/screens/detail_cashflow.dart';
import 'package:crud_sederhana_raden/services/user_data_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables to hold total pengeluaran and total pemasukan data
  int totalPengeluaran = 0;
  int totalPemasukan = 0;

  @override
  void initState() {
    super.initState();
    // Fetch the actual data and update the variables here
    fetchTotalPengeluaran();
    fetchTotalPemasukan();
  }

  // Function to fetch and calculate total Pengeluaran
  void fetchTotalPengeluaran() async {
    final pengeluaranService = PengeluaranService();
    final pengeluaranList = await pengeluaranService.getPengeluaranList();
    int total = 0;

    if (pengeluaranList != null) {
      for (var pengeluaran in pengeluaranList) {
        // Use the correct column name 'value_pengeluaran'
        total += pengeluaran['value_pengeluaran'] as int? ?? 0;
      }
    }

    setState(() {
      totalPengeluaran = total;
    });
  }

  // Function to fetch and calculate total Pemasukan
  void fetchTotalPemasukan() async {
    final pemasukanService = PemasukanService();
    final pemasukanList = await pemasukanService.getPemasukanList();
    int total = 0;

    if (pemasukanList != null) {
      for (var pemasukan in pemasukanList) {
        // Use the correct column name 'value_pemasukan'
        total += pemasukan['value_pemasukan'] as int? ?? 0;
      }
    }

    setState(() {
      totalPemasukan = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      drawer: DrawerNavigation(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Rangkuman Bulan Ini',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryText(
                    text: 'Total Pengeluaran :',
                    color: Colors.red,
                    value: totalPengeluaran,
                  ),
                  SizedBox(height: 8),
                  _buildSummaryText(
                    text: 'Total Pemasukan :',
                    color: Colors.green,
                    value: totalPemasukan,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Image.asset(
                'lib/assets/your_image.png', // Replace with the actual path to your image
                width: 1280,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: _buildNavigationButton(
                      icon: Icons.attach_money,
                      label: 'Tambah Pemasukan',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PemasukanScreen(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: _buildNavigationButton(
                      icon: Icons.money_off,
                      label: 'Tambah Pengeluaran',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PengeluaranScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: _buildNavigationButton(
                      icon: Icons.list,
                      label: 'Detail Cash Flow',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCashFlow(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    child: _buildNavigationButton(
                      icon: Icons.settings,
                      label: 'Pengaturan',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pengaturan(
                              userId: 1), // Pass the user ID (change 1 to the actual user ID)
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildSummaryText({
    required String text,
    required Color color,
    required int value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text $value',
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
