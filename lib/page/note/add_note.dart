import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {

  late TextEditingController titleC;
  late TextEditingController contentC;
  late TextEditingController reminderC;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeOfDay = TimeOfDay.now();

  // Future<void> createChecklist() async {
  //   try {
  //     Dio dio = Dio();
  //     await dio.post("http://94.74.86.174:8080/api/checklist",
  //       data: {
  //         "name": nameC.text
  //       },
  //       options: Options(
  //         headers: {
  //           "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJyb2xlcyI6W119.i2OVQdxr08dmIqwP7cWOJk5Ye4fySFUqofl-w6FKbm4EwXTStfm0u-sGhDvDVUqNG8Cc7STtUJlawVAP057Jlg"
  //         }
  //       )
  //     );

  //     Future.delayed(const Duration(seconds: 1), () {
  //       Navigator.pop(context, 'back');
  //     });

  //   } catch(e, stacktrace) {
  //     debugPrint(stacktrace.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();

    titleC = TextEditingController();
    contentC = TextEditingController();
    reminderC = TextEditingController();
  }

  @override 
  void dispose() {
    titleC.dispose();
    contentC.dispose();
    reminderC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Catatan",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, 'back');
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
          
                TextField(
                  controller: titleC,
                  style: const TextStyle(
                    fontSize: 16.0
                  ),
                  decoration: const InputDecoration(
                    labelText: "Judul",
                    labelStyle: TextStyle(
                      fontSize: 14.0
                    )
                  ),
                ),

                // const SizedBox(height: 20.0),

                TextField(
                  controller: contentC,
                  style: const TextStyle(
                    fontSize: 16.0
                  ),
                  maxLines: null,
                  minLines: 3,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: "Isi",
                    labelStyle: TextStyle(
                      fontSize: 14.0
                    )
                  ),
                ),

                const SizedBox(height: 20.0),

                TextField(
                  readOnly: true,
                  onTap: () async {

                    var date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101)
                    );

                    if(date != null) {

                      setState(() => selectedDate = date);

                      Future.delayed(Duration.zero, () async {
                        
                        var time = await showTimePicker(
                          context: context, 
                          initialTime: selectedTimeOfDay
                        );

                        if(time != null) {
                          setState(() => selectedTimeOfDay = time);

                          String year = selectedDate.year.toString();
                          String month = selectedDate.month.toString();
                          String day = selectedDate.day.toString();

                          setState(() => reminderC = TextEditingController(text: "$year-$month-$day ${selectedTimeOfDay.hour}:${selectedTimeOfDay.minute}"));
                        }

                      });

                    }
                  },
                  controller: reminderC,
                  style: const TextStyle(
                    fontSize: 16.0
                  ),
                  decoration: const InputDecoration(
                    labelText: "Set Reminder",
                    labelStyle: TextStyle(
                      fontSize: 14.0
                    )
                  ),
                ),


                // ElevatedButton(
                //   onPressed: () async {
                //     await createChecklist();
                //   },
                //   child: isLoading 
                //   ? const SizedBox(
                //       width: 16.0,
                //       height: 16.0,
                //       child: CircularProgressIndicator(
                //         color: Colors.blue,
                //       ),
                //     ) 
                //   : const Text("Create")
                // )
          
              ],
            )
          ),
        ),
      )
    );
  }
}