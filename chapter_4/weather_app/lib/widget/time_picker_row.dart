import 'package:flutter/material.dart';
import 'package:weather_app/controllers/forecast_controller.dart';
import 'package:weather_app/utils/forecast_animation_utils.dart' as utils;

class TimePickerRow extends StatefulWidget {
  final List<String> tabItems;
  final ForecastController forecastController;
  final Function onTabChange;
  final int startIndex;

  const TimePickerRow({Key key, this.forecastController, this.tabItems, this.onTabChange, this.startIndex})
      : super(key: key);

  @override
  _TimePickerRowState createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int activeTabIndex;

  @override
  void initState() {
    _tabController = TabController(length: utils.hours.length, vsync: this, initialIndex: widget.startIndex);
    _tabController.addListener(handleTabChange);
    super.initState();
  }

  void handleTabChange() {
    if (_tabController.indexIsChanging) return;
    widget.onTabChange(_tabController.index);
    setState(() {
      activeTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black38,
      unselectedLabelStyle:
          Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0),
      labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 12.0),
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
      controller: _tabController,
      tabs: widget.tabItems.map((t) => Text(t)).toList(),
      isScrollable: true,
    );
  }
}
