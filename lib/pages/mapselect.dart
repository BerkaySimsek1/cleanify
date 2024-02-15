import 'package:cleanify/pages/tabbar.dart';
import 'package:flutter/material.dart';

class MapSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppbar(preference: "back"),
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  // İkinci sayfadan geri dönerken bir değer döndür
                  Navigator.of(context).pop(true);
                },
                child: const Text('Select Map'))));
  }
}
