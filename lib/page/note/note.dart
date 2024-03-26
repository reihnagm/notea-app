import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:checklist_app/page/note/add_checklist.dart';

import 'package:checklist_app/provider/note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => NotePageState();
}

class NotePageState extends State<NotePage> {

  late NoteNotifier noteNotifier;

  List<dynamic> checkList = [];

  Future<void> getData() async {
    if(!mounted) return;
      noteNotifier.getNotes();
  }

  @override 
  void initState() {
    super.initState();

    noteNotifier = context.read<NoteNotifier>();

    Future.microtask(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              title: const Text("Catatan Harian",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              centerTitle: true,
              actions: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        final data = await Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => const AddChecklistPage()
                          ),
                        );
                        if(data != null) {
                          getData();
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            )
          ];
        }, 
        body: RefreshIndicator.adaptive(
          onRefresh: () {
            return Future.sync(() {
              getData();
            });
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
          
              // if(isLoading)
              //   const SliverFillRemaining(
              //     hasScrollBody: false,
              //     child: Center(
              //       child: CircularProgressIndicator(
              //         color: Colors.blue,
              //       ),
              //     )
              //   ),

              // SliverPadding(
              //   padding: const EdgeInsets.all(16.0),
              //   sliver: SliverList.builder(
              //     itemCount: checkList.length,
              //     itemBuilder: (_, int i) {
              //       return ListTile(
              //         title: Text(checkList[i]["name"],
              //           style: const TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18.0
              //           ),
              //         ),
              //         trailing: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: InkWell(
              //             onTap: () async {

              //             },
              //             child: const Icon(
              //               Icons.delete,
              //               color: Colors.red,
              //             )
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // )
          
            ],
          ),
        )
      )
    );
  }
}