import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegeterian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitch(
      String title, String subtitle, bool myValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: myValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegeterian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your preferences',
                style: Theme.of(context).textTheme.title),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              buildSwitch(
                'Gluten Free',
                'Only include gluten-free meals',
                _glutenFree,
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              buildSwitch(
                'Vegeterian',
                'Include only vegeterian meals',
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              buildSwitch(
                'Vegan',
                'Include only vegan meals',
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
              buildSwitch(
                'Lactose Free',
                'Include only lactose free meals',
                _lactoseFree,
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
