

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app_flutter/model/todo_moddle.dart';

class DatabaseServices {
  final CollectionReference todoCollection = 
  FirebaseFirestore.instance.collection('todos');

  User? user = FirebaseAuth.instance.currentUser;

  //add todo task
  Future <DocumentReference> addTodo(
    String title, String description,) async {
    return await todoCollection.add({
      'uid' : user!.uid,
      'title': title,
      'description': description,
      'completed': false, 
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  
//update todo task
  Future<void> updateTodo(
    String id, String title, String description) async {
      final updatetodoCollection = 
      FirebaseFirestore.instance.collection('todos').doc(id);

    return await updatetodoCollection.update({

      'title': title,
      'description': description,
      
    });
  }

//update todo status
  Future<void> updateStatus(
    String id, bool completed) async {


    return await todoCollection.doc(id).update({
      'completed': completed
      
    });
  }



  //delete todo task
  Future <void> deleteTodoTask (String id) async {
    return await todoCollection.doc(id).delete();
  }

  //get pending task
  Stream<List<Todo>> get todos {
    return todoCollection.where('uid', isEqualTo: user!.uid).where
    ('completed', isEqualTo: false)
    .snapshots().map(_todoListFromSnapshot);
  } 


//get completed task
    Stream<List<Todo>> get completedtodos {
    return todoCollection.where('uid', isEqualTo: user!.uid).where('completed', 
    isEqualTo: true).snapshots().map(_todoListFromSnapshot);
  }

List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Todo(
      id: doc.id,
      title: doc['title'] ?? '',
      description: doc['description'] ?? '',
      completed: doc['completed'] ?? false,
      timestamp: doc['createdAt'] ?? '',
    );
  }).toList();
}
}