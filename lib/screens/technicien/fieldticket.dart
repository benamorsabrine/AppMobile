import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/screens/technicien/fiche_intervention.dart';
import 'package:todo/screens/technicien/scanne_code_qr.dart';

class FieldTicketScreen extends StatefulWidget {
  @override
  _FieldTicketScreenState createState() => _FieldTicketScreenState();
}

class _FieldTicketScreenState extends State<FieldTicketScreen> {
  List<dynamic> fieldTickets = [];
  bool isLoading = true;
  bool modalVisible = false;
  String adress = '';
  String faultType = '';
  String contact = '';
  String heureDebut = '';
  String status = '';
  bool refreshing = false;

  @override
  void initState() {
    super.initState();
    fetchFieldTicketData();
  }

  Future<void> fetchFieldTicketData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.189.54:4000/api/field/all'));
      if (response.statusCode == 200) {
        setState(() {
          fieldTickets = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load field tickets');
      }
    } catch (error) {
      print('Error fetching field tickets: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleModal(dynamic fieldTicketData) {
    setState(() {
      adress = fieldTicketData?['localisation'] ?? '';
      contact = fieldTicketData?['contact'] ?? '';
      faultType = fieldTicketData?['fault_type'] ?? '';
      faultType = fieldTicketData?['status'] ?? '';
      modalVisible = !modalVisible;
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> handleAction(String fieldTicketId, String status) async {
    print('Updating ticket with id $fieldTicketId');
    try {
      final response = await http.put(
        Uri.parse('http://192.168.189.54:4000/api/field/update/$fieldTicketId'),
        body: {'status': status},
      );
      if (response.statusCode == 200) {
        showToast('Success updating ticket');
        fetchFieldTicketData();
        if (status == 'arrived') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrScanner(),
            ),
          );
        }
      } else {
        throw Exception('Failed to update ticket: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating ticket: $error');
      showToast('Error: $error');
    }
  }

  String getButtonText(String status) {
    switch (status) {
      case 'assigned':
        return 'Accepter';
      case 'accepted':
        return 'Départ';
      case 'enroute':
        return 'Arrivé';
      case 'arrived':
        return 'Démarrer';
      case 'encours':
        return 'Clôturer';
      default:
        return 'N/A';
    }
  }

  Color getButtonColor(String status) {
    switch (status) {
      case 'assigned':
        return Colors.pink;
      case 'accepted':
        return Colors.lightBlue;
      case 'enroute':
        return Colors.grey;
      case 'arrived':
        return Colors.orange;
      case 'encours':
        return Colors.orange;
      case 'cloturé':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field Tickets'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchFieldTicketData,
              child: ListView.builder(
                itemCount: fieldTickets.length,
                itemBuilder: (context, index) {
                  final item = fieldTickets[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['localisation'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['contact'] ?? ''),
                          Text(item['fault_type'] ?? ''),
                          Text(
                            (item['status'] ?? '').toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getButtonColor(item['status']),
                        ),
                        onPressed: () {
                          handleAction(item['_id'], item['status']);
                        },
                        child: Text(
                          getButtonText(item['status']),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleModal(null);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
