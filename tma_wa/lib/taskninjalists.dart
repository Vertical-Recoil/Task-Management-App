import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskNinjaLists extends StatefulWidget {
  const TaskNinjaLists({super.key});

  @override
  TaskNinjaListsState createState() => TaskNinjaListsState();
}

class TaskNinjaListsState extends State<TaskNinjaLists> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late String _email;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;
    String email = user.email;
    setState(() {
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskNinja'),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome $_email',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your TaskNinja Workspaces:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection('workspaces')
                    .where('members', arrayContains: _email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Widget> workspaceList = [];
                    for (DocumentSnapshot document in snapshot.data.docs) {
                      String workspaceName = document.data()['name'];
                      workspaceList.add(Text(workspaceName));
                    }
                    return ListView(
                      children: workspaceList,
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement workspace creation
              },
              child: Text('Create a new workspace'),
            ),
          ],
        ),
      ),
    );
  }
}
