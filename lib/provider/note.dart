import 'package:checklist_app/SQlite/db.dart';
import 'package:checklist_app/enum/enum.dart';
import 'package:flutter/material.dart';

class NoteNotifier with ChangeNotifier {

  ProviderState _providerState = ProviderState.idle;
  ProviderState get providerState => _providerState;

  final List<Map<String, dynamic>> _notes = [];
  List<Map<String, dynamic>> get notes => [..._notes];

  Future<void> reset() async {
    _notes.clear();
    notifyListeners();
  }

  Future<void> getNotes() async {
    _providerState = ProviderState.loading;
    notifyListeners();

    List<Map<String, dynamic>> notes = await DB.getNotes();
    _notes.addAll(notes);
    notifyListeners();

    if(notes.isEmpty) {
      _providerState = ProviderState.empty;
      notifyListeners();
    }
  } 

  Future<void> storeNote() async {

  }

  Future<void> destroyNote() async {

  }

}