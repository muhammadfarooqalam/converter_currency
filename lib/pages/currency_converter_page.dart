import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String baseCurrency = 'USD';
  String targetCurrency = 'EUR';
  double amount = 1.0;
  double convertedAmount = 0.0;

  void convertCurrency() async {
    final dio = Dio();
    try {
      final response = await dio
          .get('https://api.exchangerate-api.com/v4/latest/$baseCurrency');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final double rate = data['rates'][targetCurrency];
        setState(() {
          convertedAmount = amount * rate;
        });
      } else {
        setState(() {
          convertedAmount = 0.0;
        });
      }
    } catch (e) {
      setState(() {
        convertedAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Stack(children: [
        SizedBox(
          height: 900,
          child: Image.asset(
            "assets/images/currency_symbols.jpg",
            fit: BoxFit.fill,
            opacity: const AlwaysStoppedAnimation(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Colors.black54,
                      filled: true,
                      hintText: "Enter Amount",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20))),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white70,
                  onChanged: (value) {
                    setState(() {
                      amount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(color: Colors.black54)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: baseCurrency,
                      dropdownColor: Colors.black,
                      iconEnabledColor: Colors.white,
                      items: <String>['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                            selectionColor: Colors.white,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          baseCurrency = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(color: Colors.black54)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: targetCurrency,
                      dropdownColor: Colors.black,
                      iconEnabledColor: Colors.white,
                      items: <String>['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          targetCurrency = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    convertCurrency();
                  },
                  child: const Text(
                    'Convert',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'Converted Amount: ${convertedAmount.toStringAsFixed(2)} $targetCurrency',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
