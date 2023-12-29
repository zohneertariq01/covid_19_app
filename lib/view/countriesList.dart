import 'package:covid_19_app/Services/state_services.dart';
import 'package:covid_19_app/view/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StateServices stateServices = StateServices();
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (newValue) {
                  setState(() {});
                },
                controller: searchEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search named with country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Expanded(
              child: FutureBuilder(
                future: stateServices.getCountriesApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: 50,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchEditingController.text.isEmpty) {
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountryScreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                cases: snapshot.data![index]
                                                    ['cases'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                tests: snapshot.data![index]
                                                    ['tests'],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                            searchEditingController.text.toLowerCase())) {
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountryScreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                cases: snapshot.data![index]
                                                    ['cases'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered'],
                                                tests: snapshot.data![index]
                                                    ['tests'],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
