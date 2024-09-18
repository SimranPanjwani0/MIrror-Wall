import 'package:flutter/material.dart';
import 'package:mirror_wall_app/controller/app_controller.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: Provider.of<HomeProvider>(context).historylist.length,
              itemBuilder: (context, index) {
                final item =
                    Provider.of<HomeProvider>(context).historylist[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.link,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        // Handle the selected value
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Open', 'Delete', 'Share'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.blueAccent,
                      ),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      'Visited on ${DateTime.now().toString()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
