import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMemoPage extends StatefulWidget {
  const CalendarMemoPage({super.key});

  @override
  State<CalendarMemoPage> createState() => _CalendarMemoPageState();
}

class _CalendarMemoPageState extends State<CalendarMemoPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final paddedDay = _focusedDay.day.toString().padLeft(3, ' '); // 已經不用了，可以刪除

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 日曆
              Padding(
                padding: const EdgeInsets.all(16),
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2000),
                  lastDay: DateTime.utc(2100),
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xFFE9F4ED),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(color: Colors.black),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFFE9F4ED),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              // memo
              if (_selectedDay != null) ...[
                const SizedBox(height: 16),

                // memo 區塊
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F4ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'memo',
                          style: TextStyle(fontSize: 18, fontFamily: 'monospace'),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _memoController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write something...',
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('memo saved! (not yet stored)')),
                            );
                          },
                          child: const Text('enter →'),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 圓形貼紙區塊
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Cafe', '#朋友', '可愛', 'Life', 'Happy', 'Story', '2020'
                    ].map((label) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[label.hashCode % Colors.primaries.length].withOpacity(0.3),
                        ),
                        child: Text(label, style: const TextStyle(fontFamily: 'monospace')),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
