import 'package:agenda_mobile/modules/dashboard/blocs/comunicados/comunicados_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';// Asegúrate de importar el Bloc

class PlannerCalendar extends StatefulWidget {
  const PlannerCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<PlannerCalendar> createState() => _PlannerCalendarState();
}

class _PlannerCalendarState extends State<PlannerCalendar> {
  DateTime _daySelected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late bool formatButtonVisible;

    formatButtonVisible = true;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TableCalendar<Object?>(
        rowHeight: 40,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          formatButtonVisible: formatButtonVisible,
        ),
        calendarFormat: CalendarFormat.twoWeeks,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            shape: BoxShape.circle,
          ),
        ),
        firstDay: DateTime.now().subtract(const Duration(days: 365 * 2)),
        lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
        focusedDay: _daySelected,
        selectedDayPredicate: (day) => isSameDay(day, _daySelected),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _daySelected = selectedDay;
          });

          // Formateamos la fecha a 'yyyy-MM-dd'
          final fechaString = "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";

          // Disparamos el evento FetchComunicadosEvent con la fecha seleccionada
          context.read<ComunicadoBloc>().add(FetchComunicadosEvent(fecha: fechaString));
        },
      ),
    );
  }
}
