import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/helper/api_hepler.dart';

class imagegeneration extends StatefulWidget {
  imagegeneration({super.key});

  @override
  State<imagegeneration> createState() => _imagegenerationState();
}

class _imagegenerationState extends State<imagegeneration> {
  Uint8List? uint8list;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Image Type...",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      uint8list = await ApiHelper.apiHelper
                          .imageapi(question: controller.text);
                      setState(() {});
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              (uint8list == null)
                  ? Container(
                      height: 300,
                      width: 300,
                      child: Image.network(
                        "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 120,
                      width: 120,
                      child: Image.memory(uint8list!),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
