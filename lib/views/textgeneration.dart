import 'dart:typed_data';

import 'package:chatgtp/utils/helper/api_hepler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textgeneration extends StatefulWidget {
  textgeneration({super.key});

  @override
  State<textgeneration> createState() => _textgenerationState();
}

class _textgenerationState extends State<textgeneration> {
  TextEditingController controller = TextEditingController();
  String? data = "Text Not available";
  @override
  Widget build(BuildContext context) {
    Uint8List? uint8list;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter you question..",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      data = await ApiHelper.apiHelper
                          .textgenerationapi(text: controller.text);
                      setState(() {});
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("$data"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
