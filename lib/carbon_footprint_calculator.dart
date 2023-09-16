import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'components/rounded_button.dart';
import 'tips_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarbonFootprintCalculator extends StatefulWidget {
  @override
  _CarbonFootprintCalculatorState createState() =>
      _CarbonFootprintCalculatorState();
}

class _CarbonFootprintCalculatorState extends State<CarbonFootprintCalculator> {
  // Define the variables that will store the user's inputs
  double _carMileage = 0;
  double _carUsageTime = 0;
  double _publicTransportUsageTime = 0;
  double _flightsPerYear = 0;
  double _meatConsumption = 0;
  double _plasticUsage = 0;
  double _electricityUsage = 0;
  bool loading = false;
  // Define the variables that will store the carbon footprint calculations
  double _carCarbonFootprint = 0;
  double _publicTransportCarbonFootprint = 0;
  double _flightsCarbonFootprint = 0;
  double _meatCarbonFootprint = 0;
  double _plasticCarbonFootprint = 0;
  double _electricityCarbonFootprint = 0;
  double _totalCarbonFootprint = 0;
  final myitems = [
    Image.asset('assets/images/img1.jpg'),
    Image.asset('assets/images/img2.webp'),
    Image.asset('assets/images/img3.png'),
    Image.asset('assets/images/img4.png'),
    Image.asset('assets/images/img5.png'),
    Image.asset('assets/images/img6.jpeg'),
  ];

  int myCurrentIndex = 0;

  // Define the function that will calculate the carbon footprint
  void _calculateCarbonFootprint() {
    // Calculate the carbon footprint for each input
    _carCarbonFootprint = _carMileage * _carUsageTime * 0.42;
    _publicTransportCarbonFootprint = _publicTransportUsageTime * 0.09;
    _flightsCarbonFootprint = _flightsPerYear * 0.24;
    _meatCarbonFootprint = _meatConsumption * 2.5;
    _plasticCarbonFootprint = _plasticUsage * 0.11;
    _electricityCarbonFootprint = _electricityUsage * 1.35;

    // Calculate the total carbon footprint
    _totalCarbonFootprint = _carCarbonFootprint +
        _publicTransportCarbonFootprint +
        _flightsCarbonFootprint +
        _meatCarbonFootprint +
        _plasticCarbonFootprint +
        _electricityCarbonFootprint;

    if (_totalCarbonFootprint < 10) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Great job!"),
            content: Text(
                "Your carbon footprint is less than 10 tons of CO2 per year."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      double treesToPlant = (_totalCarbonFootprint - 10) / 0.6;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You can do better!"),
            content: Text(
                "Your carbon footprint is ${_totalCarbonFootprint.toStringAsFixed(2)} tons of CO2 per year. You should plant ${treesToPlant.toStringAsFixed(0)} trees per year to offset your carbon emissions."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }

    // Update the UI with the new values
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          //  brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 70,
          centerTitle: true,
          flexibleSpace:  Container(
            padding: const EdgeInsets.fromLTRB(5, 25, 5, 0),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calculate_outlined, color: Colors.black),
                            onPressed: () {
                              // Add the Facebook button's action here
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Carbon FootPrint Calculator",style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calculate_outlined, color: Colors.black),
                            onPressed: () {
                              // Add the Facebook button's action here
                            },
                          ),
                        ],
                      )
                    ],
                  ),

                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Awareness About CO2 ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 200,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          myCurrentIndex = index;
                        });
                      },
                    ),
                    items: myitems,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: AnimatedSmoothIndicator(activeIndex: myCurrentIndex,
                      count: myitems.length,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 10,
                        dotColor: Colors.grey.shade200,
                        activeDotColor: Colors.orangeAccent,
                        paintStyle: PaintingStyle.fill,
                      ),),
                  ),
                  const Divider(color:Colors.white),
                  SizedBox(height: 10.0),
                  Text("Enter to calculate your carbon footprint:",
                    style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Car mileage (miles per gallon)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _carMileage = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Car usage time (hours per week)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _carUsageTime = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Public transport usage time (hours per week)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _publicTransportUsageTime = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Flights per year',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _flightsPerYear = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Meat consumption (pounds per week)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _meatConsumption = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Plastic usage (pounds per week)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _plasticUsage = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1E6FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Electricity usage (kilowatt-hours per month)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _electricityUsage = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: RoundedButton(
                      press: _calculateCarbonFootprint,
                     text : 'Calculate',

                      loading: loading,
                    ),
                  ),
                  Divider(color: Colors.white,),
                  SizedBox(height: 16.0),
                  Text(
                    'Your carbon footprint is:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${_totalCarbonFootprint.toStringAsFixed(2)} tons of CO2 per year',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RoundedButton(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarbonFootprintTipsScreen()),
                        );
                      },
                       text :'Reduce Carbon Emissions',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
