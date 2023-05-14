import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text('검색'),
          centerTitle: true,
          //backgroundColor: const Color(0xFF212121),
        ),
        //backgroundColor: ,
        body: const Center(
          child: Text('Search'),
        ),
      ),
    );
  }
}
