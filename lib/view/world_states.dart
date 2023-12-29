import 'package:covid_19_app/Model/world_state_model.dart';
import 'package:covid_19_app/Services/state_services.dart';
import 'package:covid_19_app/view/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = [
    Color(0xff874abc),
    Color(0xFFDA4040),
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              FutureBuilder(
                future: stateServices.getWorldApi(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        PieChart(
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .03),
                        Card(
                          child: Column(
                            children: <Widget>[
                              UseButton(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              UseButton(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              UseButton(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              UseButton(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              UseButton(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              UseButton(
                                  title: 'Total deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              UseButton(
                                  title: 'Total Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Track countries',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UseButton extends StatelessWidget {
  final String title, value;
  const UseButton({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              Text(value),
            ],
          ),
        ),
        SizedBox(height: 3),
        Divider(),
      ],
    );
  }
}
