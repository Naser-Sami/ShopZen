import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class UsersListScreen extends StatelessWidget {
  static const routeName = '/users-list';
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: sl<FirebaseFirestore>().collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No current users yet.'));
          }

          List<DocumentSnapshot> users = snapshot.data!.docs;

          return ListView(
            children:
                users.map<Widget>((doc) => _buildUserListItem(doc, context)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(DocumentSnapshot doc, BuildContext context) {
    final user = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    if (user.uid == sl<FirebaseAuth>().currentUser!.uid) {
      return const SizedBox.shrink();
    }

    // if the use is the admin, don't show them in the list
    if (user.uid == 'dEHgKd4HtCO0jbopy4VoYP8cXfI3') {
      return const SizedBox.shrink();
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.profilePic != '' ? NetworkImage(user.profilePic) : null,
      ),
      title: Text(user.name == '' ? user.email.split('@')[0] : user.name),
      subtitle: Text(user.email),
      onTap: () {
        String userName = user.name == '' ? user.email.split('@')[0] : user.name;
        context.push("${ChatRoomScreen.routeName}/$userName", extra: user);
      },
    );
  }
}
