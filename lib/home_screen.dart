import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app_flutter/login_screen.dart';
import 'package:to_do_app_flutter/model/todo_moddle.dart';
import 'package:to_do_app_flutter/services/auth_services.dart';
import 'package:to_do_app_flutter/services/database_services.dart';
import 'package:to_do_app_flutter/widgets/completed_widget.dart';
import 'package:to_do_app_flutter/widgets/pending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int _buttonIndex = 0;
final _widgets =[
//pending tasks widget
  PendingWidget(),
//completed tasks widget
  CompletedWidget(),


];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text('Todo App'),

        actions: [
          IconButton(
            onPressed: () async
            {await AuthServices().signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
                         );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){
                    setState(() {
                      _buttonIndex = 0;
                    });
                  },

                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 0 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          color: _buttonIndex == 0 ? Colors.white : Colors.indigo,
                          fontSize: _buttonIndex == 0 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ),
                ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                  onTap: (){
                    setState(() {
                      _buttonIndex = 1;
                    });
                  },

                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 1 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: _buttonIndex == 1 ? Colors.white : Colors.indigo,
                          fontSize: _buttonIndex == 1 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            _widgets[_buttonIndex],
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.indigo,
        ),
        onPressed: (){
          _showTaskDialog(context);
          
        },






         ),
    );

  }

  void _showTaskDialog(BuildContext context,{Todo? todo}){
    final TextEditingController _titleController = TextEditingController(text: todo?.title);
    final TextEditingController _descriptionController = TextEditingController(text: todo?.description);
    final DatabaseServices _databaseServices = DatabaseServices();

    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          todo == null ? "add task" : "edit task",
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              
            ),
            
            onPressed: () async{
            if(todo == null)
            {
              await _databaseServices.addTodo(
                _titleController.text, _descriptionController.text);
            }
            else
            {
              await _databaseServices.updateTodo(todo.id, 
              _titleController.text, _descriptionController.text);
            }
            Navigator.pop(context);
          },
           child: Text(todo == null ? 'Add' : 'Update'),),
        ],
              );
            }
          );


  }
}