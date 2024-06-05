import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EnCoursFieldScreen extends StatefulWidget {
  const EnCoursFieldScreen({super.key});

  @override
  State<EnCoursFieldScreen> createState() => _EnCoursFieldScreenState();
}

class _EnCoursFieldScreenState extends State<EnCoursFieldScreen> {
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
        List<dynamic> allTickets = json.decode(response.body);
        // Filter tickets with status "clôturé"
        setState(() {
          fieldTickets = allTickets
              .where((ticket) => ticket['status'] == 'encours')
              .toList();
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
      if (fieldTicketData != null) {
        adress = fieldTicketData['localisation'] ?? '';
        contact = fieldTicketData['contact'] ?? '';
        faultType = fieldTicketData['fault_type'] ?? '';
        status = fieldTicketData['status'] ?? '';
      }
      modalVisible = !modalVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EnCours Tickets'),
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
                            (item['status'] ?? '')
                                .toUpperCase(), // Convertir en majuscules
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Texte en gras
                              color: Color.fromARGB(
                                  255, 238, 67, 29), // background color
                            ),
                          ),
                        ],
                      ),
                      onTap: () => toggleModal(item),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
