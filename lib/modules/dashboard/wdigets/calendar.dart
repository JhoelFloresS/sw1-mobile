// import 'package:activities_repository/activities_repository.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_planner/planner/planner.dart';
import 'package:table_calendar/table_calendar.dart';

class PlannerCalendar extends StatefulWidget {
  const PlannerCalendar({
    Key? key,
    // required this.currentSize,
  }) : super(key: key);

  @override
  State<PlannerCalendar> createState() => _PlannerCalendarState();
}

class _PlannerCalendarState extends State<PlannerCalendar> {
  DateTime _daySelected = DateTime.now();

  // final PlannerSize currentSize;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late bool formatButtonVisible;

    // if (currentSize == PlannerSize.large) {
    //   formatButtonVisible = false;
    // } else {
    formatButtonVisible = true;
    // }

    // final calendarFormat = currentSize == PlannerSize.large
    //     ? CalendarFormat.month
    //     : CalendarFormat.week;

    // final selectedDay = context.select(
    //   (PlannerBloc bloc) => bloc.state.selectedDay,
    // );

    // final focusedDay = context.select(
    //   (PlannerBloc bloc) => bloc.state.focusedDay,
    // );

    // final events = context.select((PlannerBloc bloc) => bloc.state.events);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TableCalendar<Object?>(
        // locale: ',
        rowHeight: 40,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          formatButtonVisible: formatButtonVisible,
        ),
        calendarFormat: CalendarFormat.twoWeeks,
        calendarStyle: CalendarStyle(
          // todayTextStyle: Theme.of(context)
          // .textTheme
          // .bodyText2!
          // .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            shape: BoxShape.circle,
          ),
          // selectedTextStyle: Theme.of(context)
          // .textTheme
          // .bodyText2!
          // .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          // selectedDecoration: BoxDecoration(
          //   color: Theme.of(context).pricontext
          //   .read<PlannerBloc>()
          //   .add(PlannerFocusedDayChanged(focusedDay))maryColor,
          //   shape: BoxShape.circle,
          // ),
        ),
        firstDay: DateTime.now().subtract(
          const Duration(days: 365 * 2),
        ),
        lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
        focusedDay: _daySelected,
        // eventLoader: (day) => _filterEvents(day: day, events: events),
        selectedDayPredicate: (day) => isSameDay(
          day,
          _daySelected,
        ),
        onDaySelected: (selectedDay, focusedDay) => {
          setState(() {
            _daySelected = selectedDay;
          }),
        },
        // onPageChanged: (focusedDay) => {_daySelected = focusedDay},
      ),
    );
  }
}
