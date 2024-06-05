import 'package:flutter/material.dart';
import 'package:todo/screens/technicien/tickets/accepted.dart';
import 'package:todo/screens/technicien/tickets/arrived.dart';
import 'package:todo/screens/technicien/tickets/assigned.dart';
import 'package:todo/screens/technicien/tickets/encours.dart';
import 'package:todo/screens/technicien/tickets/enroute.dart';

class ProcessHelpScreen extends StatefulWidget {
  const ProcessHelpScreen({super.key});

  @override
  State<ProcessHelpScreen> createState() => _ProcessHelpScreenState();
}

class _ProcessHelpScreenState extends State<ProcessHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process Tickets'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 150), // space between AppBar and first row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignedFieldScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 108, 182, 211), // background color
                  minimumSize: Size(140, 120), // width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // border radius
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment,
                        color: Colors.white, size: 40), // Icon added here
                    SizedBox(
                        height:
                            15), // Adjust the spacing between the icon and the label
                    Text(
                      'Assigned Tickets',
                      style: TextStyle(color: Colors.white), // text color
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20), // space between buttons

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcceptedFieldScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 255, 1, 115), // background color
                  minimumSize: Size(140, 120), // width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // border radius
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle,
                        color: Colors.white, size: 40), // Icon added here
                    SizedBox(
                        height:
                            15), // Adjust the spacing between the icon and the label
                    Text(
                      'Accepted Tickets',
                      style: TextStyle(color: Colors.white), // text color
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnCoursFieldScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 255, 82, 20), // background color
                  minimumSize: Size(140, 120), // width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // border radius
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings,
                        color: Colors.white, size: 40), // Icon added here
                    SizedBox(
                        height:
                            15), // Adjust the spacing between the icon and the label
                    Text(
                      'EnCours Tickets',
                      style: TextStyle(color: Colors.white), // text color
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
