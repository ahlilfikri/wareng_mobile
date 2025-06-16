import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubes/pages/detail_agenda_page.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedFilter = 'Semua';
  bool _isLocaleInitialized = false;
  bool _isLoading = true;
  final List<String> _filterOptions = [
    'Semua',
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
  ];

  List<Map<String, String>> _allAgendaItems = [];

  List<Map<String, String>> _filteredAgendaItems = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _isLocaleInitialized = true;
      });
    });

    _searchController.addListener(_filterAgendaItems);

    _fetchAgendaItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchAgendaItems() async {
    const url =
        'https://wareng-three.vercel.app/api/v1/informasi/kegiatan/get-kegiatan';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> dataList = jsonResponse['data']['data'];

        setState(() {
          _allAgendaItems.clear();

          for (var item in dataList) {
            _allAgendaItems.add({
              'title': item['title'] ?? '',
              'date': item['date'] ?? '',
              'time': DateFormat('HH:mm WIB').format(DateTime.parse(item['date'])),
              'location': item['location'] ?? '',
              'imagePath':
              'https://wareng-three.vercel.app/uploads/${item['img'].isNotEmpty ? item['img'][0] : ""}',
            });
          }

          _filteredAgendaItems = List.from(_allAgendaItems);
          _applyFilters();
          _isLoading = false;
        });
      } else {
        print('Failed to fetch agenda data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterAgendaItems() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredAgendaItems = _allAgendaItems.where((item) {
        final matchesSearch = item['title']!.toLowerCase().contains(_searchQuery);

        bool matchesDateFilter = true;
        if (_selectedFilter != 'Semua') {
          final itemDate = _parseDate(item['date']!);
          final now = DateTime.now();

          switch (_selectedFilter) {
            case 'Hari ini':
              matchesDateFilter = _isSameDay(itemDate, now);
              break;
            case 'Minggu ini':
              final startOfWeek = _getStartOfWeek(now);
              final endOfWeek = startOfWeek.add(Duration(days: 6));
              matchesDateFilter = itemDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
                  itemDate.isBefore(endOfWeek.add(Duration(days: 1)));
              break;
            case 'Bulan ini':
              matchesDateFilter = itemDate.month == now.month && itemDate.year == now.year;
              break;
          }
        }

        return matchesSearch && matchesDateFilter;
      }).toList();
    });
  }

  DateTime _parseDate(String dateStr) {
    return DateTime.parse(dateStr);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _formatDate(String dateStr) {
    final date = _parseDate(dateStr);

    if (!_isLocaleInitialized) {
      return "${date.day} ${_getMonthName(date.month)} ${date.year}";
    }

    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  String _getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda Desa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00917C),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00917C)),
        ),
      )
          : Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari agenda...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filterOptions.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          selectedColor: Color(0xFF00917C).withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? Color(0xFF00917C)
                                : Colors.black,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedFilter = filter;
                                _applyFilters();
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menampilkan ${_filteredAgendaItems.length} agenda',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Expanded(
            child: _filteredAgendaItems.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tidak ada agenda yang ditemukan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Coba ubah filter atau kata kunci pencarian',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _filteredAgendaItems.length,
              itemBuilder: (context, index) {
                final item = _filteredAgendaItems[index];
                return AgendaItem(
                  title: item['title']!,
                  date: _formatDate(item['date']!),
                  time: item['time']!,
                  location: item['location']!,
                  imagePath: item['imagePath']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String imagePath;

  AgendaItem({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAgendaPage(
                title: title,
                date: date,
                time: time,
                location: location,
                imageUrl: imagePath,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 80, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          date,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.access_time, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          time,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailAgendaPage(
                                title: title,
                                date: date,
                                time: time,
                                location: location,
                                imageUrl: imagePath,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00917C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Kunjungi', style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
