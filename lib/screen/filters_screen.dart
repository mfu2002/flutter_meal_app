import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meal_app/widget/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  const FiltersScreen({Key key, this.saveFilters, this.filters})
      : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String desc, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(desc),
      onChanged: (newValue) => setState(() => updateValue(newValue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters!'),
        actions: [
          IconButton(
              onPressed: () => widget.saveFilters(
                    {
                      'gluten': _glutenFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegetarian': _vegetarian,
                    },
                  ),
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Gluten-free',
                'Only include gluten-free meals.',
                _glutenFree,
                (newValue) => _glutenFree = newValue,
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'Only include lactose-free meals.',
                _lactoseFree,
                (newValue) => _lactoseFree = newValue,
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian meals.',
                _vegetarian,
                (newValue) => _vegetarian = newValue,
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include vegan meals.',
                _vegan,
                (newValue) => _vegan = newValue,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
