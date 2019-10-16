import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'my simple interset calculator',
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Naira' 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;

  var _currenciesItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currenciesItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAssest(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter a principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'principal',
                          hintText: 'Enter  principal amount e.g #1000',
                          labelStyle: textStyle,
                          errorStyle: errorStyle(),

                          // errorStyle: TextStyle(
                          //     color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: rateController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter the rate';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of interest',
                          hintText: 'In percentage',
                          labelStyle: textStyle,
                          errorStyle: errorStyle(),

                          // errorStyle: TextStyle(
                          //     color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: termController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please this field cant be empty';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in Years',
                                labelStyle: textStyle,
                                errorStyle: errorStyle(),
                                // errorStyle: TextStyle(
                                //     color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Container(width: _minimumPadding * 5),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currenciesItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculate();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAssest() {
    AssetImage assetImage = AssetImage('images/myimg.jpg');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10.0),
    );
  }

  void _onDropItemSelected(String newValueSelected) {
    setState(() {
      this._currenciesItemSelected = newValueSelected;
    });
  }

  String _calculate() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * rate * term) / 100;
    double interest = (principal * rate * term) / 100;

    String result =
        "After $term years, your interest would be $interest $_currenciesItemSelected and your investment would worth $total $_currenciesItemSelected";
    debugPrint(result);
    
    return result;
  }

  void _reset() {
    principalController.text = '';
    rateController.text = "";
    termController.text = "";
    displayResult = '';
    _currenciesItemSelected = _currencies[0];
    
  }

  TextStyle errorStyle() {
    return TextStyle(color: Colors.yellowAccent, fontSize: 15.0);
  }
}
