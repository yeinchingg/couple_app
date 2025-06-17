import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:couple_app/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'profile.dart';

class CalendarMemoPage extends StatefulWidget {
  const CalendarMemoPage({super.key});

  @override
  State<CalendarMemoPage> createState() => _CalendarMemoPageState();
}

class _CalendarMemoPageState extends State<CalendarMemoPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _memoController = TextEditingController();

  Map<String, String> _memoData = {}; // 儲存日期 -> 備忘錄文字
  Map<String, List<String>> _tagData = {}; // 儲存日期 -> 標籤清單
  Set<String> _selectedTags = {}; // 當天被選中的標籤集合

  @override
  void initState() {
    super.initState();
    _loadMemo();
  }

  // 把日期轉成字串key（年-月-日）
  String _dateKey(DateTime day) => '${day.year}-${day.month}-${day.day}';

  // 切換日期時，更新當天備忘錄跟標籤
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;

      String key = _dateKey(selectedDay);
      _memoController.text = _memoData[key] ?? '';
      _selectedTags = Set.from(_tagData[key] ?? []);
    });
  }

  // 點擊標籤切換是否選中
  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  // 儲存備忘錄與標籤到 SharedPreferences
  Future<void> _saveMemo() async {
    if (_selectedDay == null) return;

    String key = _dateKey(_selectedDay!);
    _memoData[key] = _memoController.text;
    _tagData[key] = _selectedTags.toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('memoData', json.encode(_memoData));
    prefs.setString('tagData', json.encode(_tagData));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Memo and tags saved!')),
    );
  }

  // 從 SharedPreferences 讀取資料
  Future<void> _loadMemo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? memoJson = prefs.getString('memoData');
    String? tagJson = prefs.getString('tagData');

    if (memoJson != null) {
      _memoData = Map<String, String>.from(json.decode(memoJson));
    }
    if (tagJson != null) {
      Map<String, dynamic> tagMap = json.decode(tagJson);
      _tagData = tagMap.map((k, v) => MapEntry(k, List<String>.from(v)));
    }

    if (_selectedDay != null) {
      String key = _dateKey(_selectedDay!);
      _memoController.text = _memoData[key] ?? '';
      _selectedTags = Set.from(_tagData[key] ?? []);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tags = ['Mad', '#Friend', 'Sad', 'Life', 'Happy', 'Story', '2025'];

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
                  onDaySelected: _onDaySelected,
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFFE9F4ED),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: bodyStyle.copyWith(fontSize: 14, color: Colors.black),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFE9F4ED),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: bodyStyle.copyWith(fontSize: 14, color: Colors.black),
                    defaultTextStyle: bodyStyle.copyWith(fontSize: 14),
                    weekendTextStyle: bodyStyle.copyWith(fontSize: 14),
                    outsideTextStyle: bodyStyle.copyWith(fontSize: 14, color: Colors.grey),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: headingStyle.copyWith(fontSize: 16),
                    formatButtonVisible: false,
                    leftChevronIcon: const Icon(Icons.chevron_left),
                    rightChevronIcon: const Icon(Icons.chevron_right),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: bodyStyle.copyWith(fontSize: 13),
                    weekendStyle: bodyStyle.copyWith(fontSize: 13),
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
                        Text(
                          'memo',
                          style: headingStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _memoController,
                          maxLines: 5,
                          style: bodyStyle.copyWith(fontSize: 14),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Write something...',
                            hintStyle: bodyStyle.copyWith(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _saveMemo,
                          child: Text('enter →', style: bodyStyle.copyWith(fontSize: 14)),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 圓形標籤區塊
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((label) {
                      final isSelected = _selectedTags.contains(label);
                      return GestureDetector(
                        onTap: () => _toggleTag(label),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? Colors.blue.withOpacity(0.7)
                                : Colors.primaries[label.hashCode % Colors.primaries.length].withOpacity(0.3),
                          ),
                          child: Text(
                            label,
                            style: bodyStyle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ),
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
