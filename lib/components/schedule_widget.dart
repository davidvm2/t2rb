import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({Key key}) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  DateTimeRange calendarSelectedDay;

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: FlutterFlowCalendar(
          color: FlutterFlowTheme.customColor3,
          iconColor: FlutterFlowTheme.tertiaryColor,
          weekFormat: true,
          weekStartsMonday: true,
          onChange: (DateTimeRange newSelectedDate) {
            setState(() => calendarSelectedDay = newSelectedDate);
          },
          titleStyle: TextStyle(
            color: FlutterFlowTheme.tertiaryColor,
          ),
          dayOfWeekStyle: TextStyle(
            color: FlutterFlowTheme.tertiaryColor,
          ),
          dateStyle: TextStyle(
            color: FlutterFlowTheme.tertiaryColor,
          ),
          selectedDateStyle: TextStyle(),
          inactiveDateStyle: TextStyle(),
        ),
      ),
    );
  }
}
