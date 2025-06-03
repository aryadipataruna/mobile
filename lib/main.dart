import 'package:flutter/material.dart';

// Data dummy untuk placeholder
final List<Map<String, String>> dummyBanners = [
  {
    'image':
        'https://placehold.co/600x300/A9DFBF/333333?text=Temukan+Harta+Karun',
    'title': 'Temukan Harta Karun Tersembunyi!',
    'subtitle': 'Barang bekas berkualitas dengan harga terbaik.',
    'buttonText': 'Lihat Koleksi',
  },
  {
    'image':
        'https://placehold.co/600x300/AED6F1/333333?text=Jual+Barang+Mudah',
    'title': 'Mudahnya Jual & Barter di ReUseMart!',
    'subtitle': 'Ubah barang tak terpakai jadi cuan.',
    'buttonText': 'Mulai Jual Sekarang',
  },
  {
    'image':
        'https://placehold.co/600x300/F5B7B1/333333?text=Kontribusi+Untuk+Bumi',
    'title': 'Kontribusimu Nyata untuk Bumi!',
    'subtitle': 'Setiap transaksi membantu mengurangi limbah.',
    'buttonText': 'Pelajari Lebih Lanjut',
  },
];

// Updated dummyCategories list
final List<Map<String, dynamic>> dummyCategories = [
  {
    'icon': Icons.devices,
    'name': 'Elektronik & Gadget',
    'color': Colors.blueGrey[600],
  },
  {
    'icon': Icons.checkroom,
    'name': 'Pakaian & Aksesori',
    'color': Colors.pinkAccent[100],
  },
  {
    'icon': Icons.weekend_outlined,
    'name': 'Perabotan Rumah',
    'color': Colors.brown[400],
  },
  {
    'icon': Icons.menu_book_outlined,
    'name': 'Buku & Alat Tulis',
    'color': Colors.indigo[300],
  },
  {
    'icon': Icons.sports_esports_outlined,
    'name': 'Hobi & Mainan',
    'color': Colors.purpleAccent[100],
  },
  {
    'icon': Icons.child_friendly_outlined,
    'name': 'Bayi & Anak',
    'color': Colors.lightBlue[300],
  },
  {
    'icon': Icons.directions_car_filled_outlined,
    'name': 'Otomotif',
    'color': Colors.deepOrange[300],
  },
  {
    'icon': Icons.park_outlined,
    'name': 'Taman & Outdoor',
    'color': Colors.green[400],
  },
  {
    'icon': Icons.business_center_outlined,
    'name': 'Kantor & Industri',
    'color': Colors.blue[700],
  },
  {
    'icon': Icons.spa_outlined,
    'name': 'Kosmetik & Perawatan',
    'color': Colors.redAccent[100],
  },
];

final List<Map<String, String>> dummyProducts = [
  {
    'image': 'https://placehold.co/200x200/D2B4DE/333333?text=Produk+A',
    'name': 'Kemeja Flanel Bekas',
    'price': 'Rp75.000',
    'condition': 'Baik',
    'location': 'Jakarta Selatan',
  },
  {
    'image': 'https://placehold.co/200x200/A9CCE3/333333?text=Produk+B',
    'name': 'Lampu Meja Antik',
    'price': 'Rp150.000',
    'condition': 'Seperti Baru',
    'location': 'Bandung',
  },
  {
    'image': 'https://placehold.co/200x200/ABEBC6/333333?text=Produk+C',
    'name': 'Novel Tere Liye (Bekas)',
    'price': 'Rp35.000',
    'condition': 'Cukup Baik',
    'location': 'Surabaya',
  },
  {
    'image': 'https://placehold.co/200x200/FAD7A0/333333?text=Produk+D',
    'name': 'Speaker Bluetooth Portable',
    'price': 'Rp200.000',
    'condition': 'Baik',
    'location': 'Yogyakarta',
  },
];

final List<Map<String, String>> dummyArticles = [
  {
    'image': 'https://placehold.co/300x150/F5CBA7/333333?text=Tips+Upcycle',
    'title': '5 Ide Kreatif Upcycle Jeans Bekasmu!',
  },
  {
    'image': 'https://placehold.co/300x150/BBDEFB/333333?text=Kisah+Pengguna',
    'title': 'Dari Garasi Penuh Barang Jadi Ruang Kreatif',
  },
];

void main() {
  runApp(const ReUseMartApp());
}

class ReUseMartApp extends StatelessWidget {
  const ReUseMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReUseMart',
      theme: ThemeData(
        primarySwatch: Colors
            .green, // Digunakan untuk fallback jika colorScheme tidak sepenuhnya mencakup
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green[700],
          elevation: 1.0,
          iconTheme: IconThemeData(color: Colors.green[700]),
          titleTextStyle: TextStyle(
            // Menambahkan style default untuk title AppBar
            color: Colors.green[700],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            // Style untuk judul besar (misal, judul halaman)
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[850],
          ),
          titleMedium: TextStyle(
            // Style untuk judul section
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ), // Style untuk teks body standar
          labelLarge: const TextStyle(
            // Style untuk teks pada tombol
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 6.0,
          ), // Margin default untuk card
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Tema default untuk ElevatedButton
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // Tema default untuk TextField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.green[700]!),
          ),
          hintStyle: TextStyle(color: Colors.grey[500]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
        // Menggunakan colorScheme untuk konsistensi warna yang lebih baik di Material 3
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
          secondary: Colors.orangeAccent, // Warna aksen
          surface: Colors.white, // Warna dasar untuk Card, Dialog, dll.
          onSurface: Colors.grey[850], // Warna teks di atas surface
          background: Colors.grey[100], // Warna latar belakang utama Scaffold
          onBackground: Colors.grey[850], // Warna teks di atas background
        ),
        useMaterial3: true, // Mengaktifkan Material 3
      ),
      home: const ReUseMartHomePage(), // Langsung ke ReUseMartHomePage
      debugShowCheckedModeBanner: false,
    );
  }
}

class ReUseMartHomePage extends StatefulWidget {
  const ReUseMartHomePage({super.key});

  @override
  State<ReUseMartHomePage> createState() => _ReUseMartHomePageState();
}

class _ReUseMartHomePageState extends State<ReUseMartHomePage> {
  int _currentIndex = 0; // Untuk BottomNavigationBar
  final PageController _bannerPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Widget untuk AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          'https://placehold.co/100x100/2ECC71/FFFFFF?text=RUM',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.store,
            size: 30,
          ), // Fallback jika gambar gagal dimuat
        ), // Placeholder Logo
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Cari barang bekas unik...',
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_outlined),
          onPressed: () {
            // Aksi ketika ikon notifikasi ditekan
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tombol Notifikasi Ditekan!')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {
            // Aksi ketika ikon pesan ditekan
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tombol Pesan Ditekan!')),
            );
          },
        ),
      ],
    );
  }

  // Widget untuk Body Utama
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerCarousel(),
          _buildQuickAccessMenu(),
          _buildSectionTitle('Kategori Barang'), // Updated section title
          _buildCategories(),
          _buildSectionTitle('Baru Ditambahkan di Sekitarmu'),
          _buildProductList(dummyProducts),
          _buildSectionTitle('Penawaran Spesial Untukmu!'),
          _buildProductList(
            dummyProducts.reversed.toList(),
          ), // Contoh data berbeda
          _buildSectionTitle('Rekomendasi Untukmu, Pengguna'),
          _buildProductList(
            dummyProducts.take(2).toList(),
          ), // Contoh data berbeda
          _buildSectionTitle('Tips ReUse & Kisah Komunitas'),
          _buildArticleList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget untuk Banner Carousel
  Widget _buildBannerCarousel() {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: _bannerPageController,
        itemCount: dummyBanners.length,
        itemBuilder: (context, index) {
          final banner = dummyBanners[index];
          return Card(
            // Menggunakan CardTheme default dari ThemeData
            clipBehavior: Clip.antiAlias, // Untuk rounded corners pada gambar
            child: Stack(
              children: [
                Image.network(
                  banner['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner['subtitle']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondary, // Menggunakan warna sekunder dari tema
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${banner['buttonText']} Ditekan!'),
                            ),
                          );
                        },
                        child: Text(
                          banner['buttonText']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget untuk Menu Akses Cepat
  Widget _buildQuickAccessMenu() {
    final items = [
      {'icon': Icons.add_circle_outline, 'label': 'Jual'},
      {'icon': Icons.favorite_border, 'label': 'Favorit'},
      {'icon': Icons.recycling_outlined, 'label': 'Daur Ulang'},
      {'icon': Icons.local_offer_outlined, 'label': 'Tawaranku'},
      {'icon': Icons.swap_horiz_outlined, 'label': 'Barter'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Expanded(
            child: InkWell(
              onTap: () {
                // Aksi ketika item menu ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menu ${item['label']} Ditekan!')),
                );
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label'] as String,
                      style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget untuk Judul Setiap Section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 20.0,
        bottom: 10.0,
      ),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  // Widget untuk Daftar Kategori
  Widget _buildCategories() {
    return SizedBox(
      height: 110.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: dummyCategories.length,
        itemBuilder: (context, index) {
          final category = dummyCategories[index];
          return InkWell(
            onTap: () {
              // Aksi ketika kategori ditekan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kategori ${category['name']} Ditekan!'),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width:
                  120.0, // Lebar card kategori sedikit diperbesar untuk nama yang lebih panjang
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ), // Margin antar card kategori
              child: Card(
                color: (category['color'] as Color?)?.withOpacity(0.85) ??
                    Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        category['name'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize:
                              11.0, // Ukuran font sedikit dikecilkan jika nama terlalu panjang
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2, // Izinkan dua baris untuk nama kategori
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget untuk Daftar Produk (digunakan untuk beberapa section)
  Widget _buildProductList(List<Map<String, String>> products) {
    return SizedBox(
      height: 260.0, // Tinggi disesuaikan agar konten terlihat baik
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 170.0, // Lebar kartu produk
            child: Card(
              // Menggunakan CardTheme default
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // Aksi ketika produk ditekan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produk ${product['name']} Ditekan!'),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3, // Proporsi untuk gambar
                      child: Image.network(
                        product['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey[400],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2, // Proporsi untuk detail teks
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Menyebar elemen secara vertikal
                          children: [
                            Text(
                              product['name']!,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.9),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['price']!,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${product['condition']} - ${product['location']}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget untuk Daftar Artikel
  Widget _buildArticleList() {
    return ListView.builder(
      shrinkWrap:
          true, // Agar ListView tidak mengambil tinggi tak terbatas di dalam Column
      physics:
          const NeverScrollableScrollPhysics(), // Agar tidak ada scroll di dalam ListView ini
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: dummyArticles.length,
      itemBuilder: (context, index) {
        final article = dummyArticles[index];
        return Card(
          // Menggunakan CardTheme default
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // Aksi ketika artikel ditekan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Artikel ${article['title']} Ditekan!')),
              );
            },
            child: Row(
              children: [
                Image.network(
                  article['image']!,
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    width: 120,
                    height: 80,
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      article['title']!,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget untuk Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          // Tambahkan logika navigasi di sini jika diperlukan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigasi ke item ke-${index + 1}')),
          );
        });
      },
      type: BottomNavigationBarType.fixed, // Agar semua item terlihat labelnya
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: 'Kategori',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline,
            size: 32,
          ), // Icon JUAL lebih besar
          activeIcon: Icon(Icons.add_circle, size: 32),
          label: 'JUAL',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Akun',
        ),
      ],
    );
  }
}
