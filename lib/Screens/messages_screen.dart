import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:machine_test/Screens/chat_screen.dart';
import 'package:machine_test/model/user_contacts.dart';
import 'package:machine_test/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> get() async {
    const String url = '$baseUrl/chat/chat-messages/queries/contact-users';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token") ?? "#";
    // var userId = pref.getString("userId") ?? "#";

    final headers = {
      'Authorization': 'Bearer $token',
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
            "image": attributes['avatar'] ??
                'https://via.placeholder.com/150', // fallback image
          };
        }).toList();

        setState(() => isLoading = false);
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Stream<UsersContact> fetchChatContacts() async* {
    const String url = '$baseUrl/chat/chat-messages/queries/contact-users';
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token") ?? "#";

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/vnd.api+json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        // final decodedJson = jsonDecode(response.body);
        // final parsedJson = Japx.decode(decodedJson);

        final chatResponse = UsersContact.fromRawJson(response.body);
        yield chatResponse;
      } else {
        yield* Stream.error("Failed to fetch contacts");
      }
    } catch (e) {
      yield* Stream.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<UsersContact>(
          stream: fetchChatContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
              return const Center(child: Text("No users found."));
            }

            final chatUsers = snapshot.data!.data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: chatUsers.length,
                      itemBuilder: (context, index) {
                        final story = chatUsers[index].attributes;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                child: ClipOval(
                                  child: Image.network(
                                    story.profilePhotoUrl,
                                    fit: BoxFit.cover,
                                    width: 56,
                                    height: 56,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person, size: 28);
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2));
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                story.name,
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
                    child: ListView.separated(
                      itemCount: chatUsers.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final user = chatUsers[index].attributes;
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
                            child: ClipOval(
                              child: Image.network(
                                user.profilePhotoUrl,
                                fit: BoxFit.cover,
                                width: 56,
                                height: 56,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person, size: 28);
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2));
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Text(
                            '10:00 AM',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
