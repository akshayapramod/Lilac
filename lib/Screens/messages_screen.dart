import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:machine_test/Screens/chat_screen.dart';
import 'package:machine_test/utils/constants.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Map<String, dynamic>> chatUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChatContacts();
  }

  Future<void> fetchChatContacts() async {
    const String url = '$baseUrl/chat/chat-messages/queries/contact-users';

    final headers = {
      'Cookie': 'laravel_session=QtW5xwlo3TVmDTzs7bdQcdULwiKXj5ZW7BtrjyTF',
      'Accept': 'application/vnd.api+json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final parsedJson = Japx.decode(decodedJson);

        final users = parsedJson['data'] as List<dynamic>;

        chatUsers = users.map((user) {
          final attributes = user['attributes'] as Map<String, dynamic>;
          return {
            "id": user['id'],
            "name": attributes['name'] ?? '',
            "image": attributes['avatar'] ?? 'https://via.placeholder.com/150',
          };
        }).toList();

        setState(() {
          isLoading = false;
        });
      } else {
        ;
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 12),
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chatUsers.length,
                  itemBuilder: (context, index) {
                    final story = chatUsers[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(story['image']),
                            radius: 28,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            story['name'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Chat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : chatUsers.isEmpty
                        ? const Center(child: Text("No users found."))
                        : ListView.separated(
                            itemCount: chatUsers.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final user = chatUsers[index];
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ChatPage(),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user['image']),
                                ),
                                title: Text(
                                  user['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Text(
                                  '10:00 AM',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
