import 'package:astro/secret.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'frontpage.dart';
import 'dart:convert';

class ChapterSummary extends StatefulWidget {
  final String dropdownvalue;

  ChapterSummary(this.dropdownvalue);
  @override
  _ChapterSummaryState createState() => _ChapterSummaryState();
}

class _ChapterSummaryState extends State<ChapterSummary> {
  String getData = "wait..";
  List<dynamic> dynamicValuesList = [];

  Future apicall() async {
    http.Response response;
    response = await http.get(
      Uri.parse(
          "https://bhagavad-gita3.p.rapidapi.com/v2/chapters/$dropdownvalue/"),
      headers: {
        'X-RapidAPI-Key': secret,
        'X-RapidAPI-Host': 'bhagavad-gita3.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        getData = response.body;
        dynamicValuesList =
            json.decode(utf8.decode(response.bodyBytes)).values.toList();
      });
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Bhagavad Gita Summary'),
          centerTitle: true,
          backgroundColor: Colors.amber[800],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(100, 20, 100, 100),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 249, 230, 187),
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/krishna.png',
                  width: 600,
                  height: 200,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText(
                        "Chapter Number :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[6].toString()
                            : ""),
                    _buildText(
                        "Chapter Name :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[1].toString()
                            : ""),
                    _buildText(
                        "Name Translated :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[3].toString()
                            : ""),
                    _buildText(
                        "Meaning of Chapter Name :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[7].toString()
                            : ""),
                    _buildText(
                        "Number of verses in this Chapter :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[5].toString()
                            : ""),
                    _buildText(
                        "Chapter Summary in English :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[8].toString()
                            : ""),
                    _buildText(
                        "Chapter Summary in Hindi :",
                        dynamicValuesList.isNotEmpty
                            ? dynamicValuesList[9].toString()
                            : ""),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FrontPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                  ),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String labelText, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        Text(
          value,
          style: const TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 251, 5, 5)),
        ),
      ],
    );
  }
}
