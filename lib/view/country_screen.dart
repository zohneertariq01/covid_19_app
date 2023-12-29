import 'package:covid_19_app/view/world_states.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  String name;
  String image;
  int cases, deaths, recovered, active, critical, todayRecovered, tests;
  CountryScreen({
    super.key,
    required this.name,
    required this.image,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .07),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04),
                            UseButton(
                                title: 'Total Cases',
                                value: widget.cases.toString()),
                            UseButton(
                                title: 'Total Deaths',
                                value: widget.deaths.toString()),
                            UseButton(
                                title: 'Total Recovered',
                                value: widget.recovered.toString()),
                            UseButton(
                                title: 'Active',
                                value: widget.active.toString()),
                            UseButton(
                                title: 'Critical',
                                value: widget.critical.toString()),
                            UseButton(
                                title: 'Today Recovered',
                                value: widget.todayRecovered.toString()),
                            UseButton(
                                title: 'Tests', value: widget.tests.toString()),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.image),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
