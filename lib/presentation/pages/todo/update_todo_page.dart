import '../../../core/presentation/some_went_wrong_page.dart';
import '../../../domain/entities/todo/todo.dart';
import '../../blocs/todo_form/todo_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTodoPage extends StatefulWidget {
  static const routeName = '/UpdateTodoPage';

  final Todo todoModel;

  const UpdateTodoPage({Key? key, required this.todoModel});

  @override
  State<StatefulWidget> createState() {
    return UpdateTodoPageState();
  }
}

class UpdateTodoPageState extends State<UpdateTodoPage> {
  final _formKey = GlobalKey<FormState>();
  Todo? _task;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = widget.todoModel.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                _formKey.currentState?.save();
                BlocProvider.of<TodoFormBloc>(context).add(
                  TodoFormUpdateEvent(
                    task:
                        Todo(task: myController.text, id: widget.todoModel.id),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: BlocBuilder<TodoFormBloc, TodoFormState>(
        builder: (BuildContext context, TodoFormState todoFormState) {
          if (todoFormState is TodoFormLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (todoFormState is TodoFormUpdateSuccessState) {
            return _buildBody(context);
          } else if (todoFormState is TodoFormUpdateFailState) {
            return _buildBody(context);
          }
          return _buildBody(context);
        },
      ),
      //body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                controller: myController,
                scrollPadding: const EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  _task?.task = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
}

class ViewUpdateTodoPageArguments {
  final Todo todoModel;

  ViewUpdateTodoPageArguments({required this.todoModel});
}
