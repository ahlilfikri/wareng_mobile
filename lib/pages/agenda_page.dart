import 'package:flutter/material.dart';
import 'package:tubes/pages/detail_agenda_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import this for locale initialization

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  // Filter state variables
  String _searchQuery = '';
  String _selectedFilter = 'Semua';
  bool _isLocaleInitialized = false;

  // List of filter options
  final List<String> _filterOptions = [
    'Semua',
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
  ];

  // Sample data - in a real app this would come from a database or API
  final List<Map<String, String>> _allAgendaItems = [
    {
      'title': 'Rapat Koordinasi Pembangunan',
      'date': '24-04-2025',
      'time': '12:00 WIB',
      'location': 'Balai Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Pelatihan Keterampilan Warga',
      'date': '25-03-2025',
      'time': '14:00 WIB',
      'location': 'Gedung Serba Guna Desa',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Posyandu Lansia',
      'date': '27-04-2025',
      'time': '09:00 WIB',
      'location': 'Puskesmas Pembantu Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Gotong Royong Desa',
      'date': '30-04-2025',
      'time': '07:00 WIB',
      'location': 'Lapangan Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Festival Kuliner Lokal',
      'date': '02-05-2025',
      'time': '10:00 WIB',
      'location': 'Pasar Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Pembagian Pupuk Subsidi',
      'date': '05-05-2025',
      'time': '13:00 WIB',
      'location': 'Gudang Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Penyuluhan Pertanian',
      'date': '10-03-2025',
      'time': '09:00 WIB',
      'location': 'Aula Pertemuan Desa',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Kelas Komputer untuk Lansia',
      'date': '15-04-2025',
      'time': '10:00 WIB',
      'location': 'Balai Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Vaksinasi Hewan Ternak',
      'date': '18-06-2025',
      'time': '08:00 WIB',
      'location': 'Lapangan Desa Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
    {
      'title': 'Kerja Bakti Bersih Sungai',
      'date': '24-02-2025',
      'time': '07:00 WIB',
      'location': 'Sungai Wareng',
      'imagePath': 'assets/informasi/activity-example.png',
    },
  ];

  // Filtered agenda items
  List<Map<String, String>> _filteredAgendaItems = [];

  @override
  void initState() {
    super.initState();
    _filteredAgendaItems = _allAgendaItems;

    // Initialize date formatting for Indonesian locale
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {
        _isLocaleInitialized = true;
      });
    });

    // Add listener to search field
    _searchController.addListener(_filterAgendaItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Method to filter agenda items based on search query and date filter
  void _filterAgendaItems() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _applyFilters();
    });
  }

  // Apply both search and date filters
  void _applyFilters() {
    setState(() {
      _filteredAgendaItems = _allAgendaItems.where((item) {
        // Apply search filter
        final matchesSearch = item['title']!.toLowerCase().contains(_searchQuery);

        // Apply date filter
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

  // Helper method to parse date string
  DateTime _parseDate(String dateStr) {
    // Parse date in format DD-MM-YYYY
    final parts = dateStr.split('-');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  // Helper method to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }

  // Helper method to get the start of the week (Monday)
  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Format date for display
  String _formatDate(String dateStr) {
    final date = _parseDate(dateStr);

    // If locale is not initialized yet, use a simple format
    if (!_isLocaleInitialized) {
      return "${date.day} ${_getMonthName(date.month)} ${date.year}";
    }

    // Use intl formatting when locale is initialized
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }

  // Fallback method to get month name if locale isn't initialized yet
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
      body: Column(
        children: [
          // Search and filter section
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                // Search field
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

                // Date filter
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

          // Results count
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

          // Agenda list
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
          // Navigate to DetailAgendaPage when the whole card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailAgendaPage(
                title: title,
                date: date,
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
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover
                ),
              ),
              SizedBox(width: 16), // Space between image and text

              // Column with title, date, time, and button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),

                    // Date and Time
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

                    // Location
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

                    // Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to DetailAgendaPage and pass the data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailAgendaPage(
                                title: title,
                                date: date,
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