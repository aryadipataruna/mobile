import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

// Asumsi model Barang sudah ada di tempat lain atau disediakan oleh Anda
// class Barang {
//   final String id_barang;
//   final String nama_barang;
//   final String deskripsi_barang;
//   final String harga_barang;
//   final String kondisi;
//   final String gambar_barang;
//   final String kategori;
//
//   Barang({
//     required this.id_barang,
//     required this.nama_barang,
//     required this.deskripsi_barang,
//     required this.harga_barang,
//     required this.kondisi,
//     required this.gambar_barang,
//     required this.kategori,
//   });
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Dummy data untuk produk dan kategori (ganti dengan data dari controller Anda)
  List<Map<String, dynamic>> _dummyBarangData = [
    {
      'ID_BARANG': 'BRG001',
      'NAMA_BARANG': 'Laptop Gaming Bekas',
      'DESKRIPSI_BARANG':
          'Laptop gaming kondisi sangat baik, performa tinggi untuk game dan kerja.',
      'HARGA_BARANG': '10500000',
      'KONDISI_BARANG': 'Bekas',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/00aaff/ffffff?text=Laptop',
      'KATEGORI_BARANG': 'Elektronik',
    },
    {
      'ID_BARANG': 'BRG002',
      'NAMA_BARANG': 'Kursi Ergonomis',
      'DESKRIPSI_BARANG':
          'Kursi kantor nyaman, cocok untuk penggunaan jangka panjang.',
      'HARGA_BARANG': '800000',
      'KONDISI_BARANG': 'Baru',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/00ff88/000000?text=Kursi',
      'KATEGORI_BARANG': 'Furniture',
    },
    {
      'ID_BARANG': 'BRG003',
      'NAMA_BARANG': 'Sepeda Gunung',
      'DESKRIPSI_BARANG': 'Sepeda gunung robust, siap untuk petualangan.',
      'HARGA_BARANG': '2500000',
      'KONDISI_BARANG': 'Bekas',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/0a0a0a/ffffff?text=Sepeda',
      'KATEGORI_BARANG': 'Olahraga',
    },
    {
      'ID_BARANG': 'BRG004',
      'NAMA_BARANG': 'Smart TV 4K',
      'DESKRIPSI_BARANG': 'TV pintar dengan resolusi 4K, kondisi mulus.',
      'HARGA_BARANG': '3200000',
      'KONDISI_BARANG': 'Bekas',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/1a1a1a/ffffff?text=TV',
      'KATEGORI_BARANG': 'Elektronik',
    },
    {
      'ID_BARANG': 'BRG005',
      'NAMA_BARANG': 'Meja Kerja Kayu',
      'DESKRIPSI_BARANG': 'Meja kerja minimalis dari kayu jati solid.',
      'HARGA_BARANG': '1200000',
      'KONDISI_BARANG': 'Bekas',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/2a2a2a/ffffff?text=Meja',
      'KATEGORI_BARANG': 'Furniture',
    },
    {
      'ID_BARANG': 'BRG006',
      'NAMA_BARANG': 'Konsol Game PS5',
      'DESKRIPSI_BARANG': 'Konsol game generasi terbaru, siap dimainkan.',
      'HARGA_BARANG': '7000000',
      'KONDISI_BARANG': 'Baru',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/00aaff/ffffff?text=PS5',
      'KATEGORI_BARANG': 'Elektronik',
    },
    {
      'ID_BARANG': 'BRG007',
      'NAMA_BARANG': 'Kemeja Batik Pria',
      'DESKRIPSI_BARANG': 'Kemeja batik lengan panjang, motif modern.',
      'HARGA_BARANG': '150000',
      'KONDISI_BARANG': 'Baru',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/00ff88/000000?text=Batik',
      'KATEGORI_BARANG': 'Fashion',
    },
    {
      'ID_BARANG': 'BRG008',
      'NAMA_BARANG': 'Sepatu Lari Wanita',
      'DESKRIPSI_BARANG': 'Sepatu lari ringan dan nyaman, ukuran 38.',
      'HARGA_BARANG': '300000',
      'KONDISI_BARANG': 'Bekas',
      'GAMBAR_BARANG':
          'https://via.placeholder.com/400x250/0a0a0a/ffffff?text=Sepatu',
      'KATEGORI_BARANG': 'Olahraga',
    },
  ];

  List<Map<String, dynamic>> _filteredBarang = [];
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _filteredBarang =
        List.from(_dummyBarangData); // Inisialisasi dengan semua data dummy
    _searchController.addListener(_filterBarang);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBarang);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterBarang() {
    final String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredBarang = _dummyBarangData.where((barang) {
        final namaBarang = barang['NAMA_BARANG']?.toLowerCase() ?? '';
        final deskripsiBarang = barang['DESKRIPSI_BARANG']?.toLowerCase() ?? '';
        final kategoriBarang = barang['KATEGORI_BARANG']?.toLowerCase() ?? '';
        return namaBarang.contains(searchTerm) ||
            deskripsiBarang.contains(searchTerm) ||
            kategoriBarang.contains(searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the color scheme based on your HTML CSS variables
    const Color primaryDark = Color(0xFF0A0A0A);
    const Color secondaryDark = Color(0xFF1A1A1A);
    const Color cardDark = Color(0xFF2A2A2A);
    const Color accentGreen = Color(0xFF00FF88);
    const Color accentBlue = Color(0xFF00AAFF);
    const Color textLight = Color(0xFFF8F9FA);
    const Color textMuted = Color(0xFFADB5BD);

    return Scaffold(
      backgroundColor: primaryDark,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: AppBar(
          backgroundColor: secondaryDark.withOpacity(0.95),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.1), width: 1)),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'ReUse Mart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[accentGreen, accentBlue],
                          ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2), width: 2),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: textLight),
                          decoration: InputDecoration(
                            hintText: 'Cari barang bekas berkualitas...',
                            hintStyle: TextStyle(color: textMuted),
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.search, color: textMuted),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildNavLink(
                        context, 'Kategori', Icons.category, '#categories'),
                    _buildNavLink(
                        context, 'Produk', Icons.shopping_bag, '#products'),
                    _buildNavLink(
                        context, 'Keranjang', Icons.shopping_cart, '/cartPage'),
                    _buildNavLink(
                        context, 'History', Icons.history, '/historyPage'),
                    _buildNavLink(
                        context, 'Profile', Icons.person, '/ProfilePage'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentGreen.withOpacity(0.1),
                    accentBlue.withOpacity(0.1),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SlideTransition(
                      position: _animation,
                      child: Text(
                        '♻️ ReUse Mart',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: <Color>[accentGreen, accentBlue],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Marketplace Terpercaya untuk Barang Bekas Berkualitas',
                      style: TextStyle(fontSize: 18, color: textMuted),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildHeroFeature(
                              Icons.check_circle, 'Berkualitas', Colors.green),
                          _buildHeroFeature(
                              Icons.shield, 'Terpercaya', Colors.blue),
                          _buildHeroFeature(
                              Icons.sell, 'Harga Terjangkau', Colors.orange),
                          _buildHeroFeature(
                              Icons.eco, 'Ramah Lingkungan', Colors.green),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // About Us Section
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24.0),
              color: Colors.white.withOpacity(0.02),
              child: Column(
                children: [
                  Text(
                    'Tentang ReUse Mart',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[accentGreen, accentBlue],
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final List<Map<String, dynamic>> aboutCards = [
                        {
                          'icon': Icons.favorite,
                          'title': 'Misi Kami',
                          'description':
                              'Memberikan kehidupan kedua untuk barang-barang berkualitas dan mengurangi limbah dengan menciptakan marketplace yang terpercaya untuk jual-beli barang bekas.'
                        },
                        {
                          'icon': Icons.people,
                          'title': 'Komunitas',
                          'description':
                              'Bergabunglah dengan ribuan pengguna yang peduli lingkungan dan cerdas berbelanja. Bersama kita ciptakan gaya hidup berkelanjutan.'
                        },
                        {
                          'icon': Icons.star,
                          'title': 'Kualitas',
                          'description':
                              'Setiap produk melalui verifikasi ketat untuk memastikan kualitas terbaik. Garansi kepuasan pelanggan adalah prioritas utama kami.'
                        },
                      ];
                      return _buildAboutCard(
                        cardDark: cardDark,
                        accentGreen: accentGreen,
                        accentBlue: accentBlue,
                        textLight: textLight,
                        icon: aboutCards[index]['icon'] as IconData,
                        title: aboutCards[index]['title'] as String,
                        description: aboutCards[index]['description'] as String,
                      );
                    },
                  ),
                ],
              ),
            ),
            // Categories Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Kategori Produk',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[accentGreen, accentBlue],
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildCategoriesGrid(
                      cardDark, accentGreen, accentBlue, textLight),
                ],
              ),
            ),
            // Products Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    'Produk Terbaru',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[accentGreen, accentBlue],
                        ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildProductsGrid(
                      cardDark, accentGreen, accentBlue, textLight, textMuted),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement "Lihat Lebih Banyak" functionality
                      // e.g., navigate to a full products list page
                      print('Lihat Lebih Banyak clicked!');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: accentGreen, // Directly use accent green
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      shadowColor: accentGreen.withOpacity(0.4),
                      elevation: 10,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 20),
                        SizedBox(width: 8),
                        Text('Lihat Lebih Banyak'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
              color: secondaryDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ReUse Mart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Marketplace terpercaya untuk barang bekas berkualitas. Bersama kita ciptakan masa depan yang lebih berkelanjutan.',
                    style: TextStyle(color: textMuted),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: textLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.camera_fill,
                            color: textLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.tiktok,
                            color:
                                textLight), // Using generic icon for Twitter/TikTok
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.phone_circle,
                            color: textLight),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kategori',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textLight)),
                            _buildFooterLink('Elektronik', '#'),
                            _buildFooterLink('Furniture', '#'),
                            _buildFooterLink('Otomotif', '#'),
                            _buildFooterLink('Fashion', '#'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bantuan',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textLight)),
                            _buildFooterLink('FAQ', '#'),
                            _buildFooterLink('Cara Beli', '#'),
                            _buildFooterLink('Cara Jual', '#'),
                            _buildFooterLink('Kontak', '#'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(
      BuildContext context, String title, IconData icon, String route) {
    const Color accentGreen = Color(0xFF00FF88);
    const Color textLight = Color(0xFFF8F9FA);

    return TextButton.icon(
      onPressed: () {
        if (route.startsWith('/')) {
          Navigator.pushNamed(context, route); // Example: /cartPage
        } else {
          print(
              'Navigate to section: $route'); // Placeholder for scroll-to-section
        }
      },
      icon: Icon(icon, color: textLight, size: 18),
      label: Text(
        title,
        style: const TextStyle(color: textLight),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return accentGreen.withOpacity(0.1);
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildHeroFeature(IconData icon, String text, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildAboutCard({
    required Color cardDark,
    required Color accentGreen,
    required Color accentBlue,
    required Color textLight,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [accentGreen, accentBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: textLight.withOpacity(0.8), fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(
      Color cardDark, Color accentGreen, Color accentBlue, Color textLight) {
    final List<String> uniqueCategories = _dummyBarangData
        .map((b) => b['KATEGORI_BARANG'] as String)
        .toSet()
        .toList();

    final Map<String, IconData> categoryIcons = {
      'Elektronik': Icons.devices_other,
      'Olahraga': Icons.sports_tennis,
      'Komputer': Icons.computer,
      'Furniture': Icons.chair,
      'Otomotif': Icons.directions_car,
      'Fashion': Icons.style,
      // Add more mappings as needed
    };

    if (uniqueCategories.isEmpty) {
      return const Text('Tidak ada kategori ditemukan.',
          style: TextStyle(color: Colors.white));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: uniqueCategories.length,
      itemBuilder: (context, index) {
        final category = uniqueCategories[index];
        final icon = categoryIcons[category] ?? Icons.category;

        return GestureDetector(
          onTap: () {
            print('Category tapped: $category');
            // TODO: Implement filtering by category or navigating to category page using your controller
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardDark,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [accentGreen, accentBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Icon(
                    icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  style: TextStyle(
                      color: textLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(Color cardDark, Color accentGreen, Color accentBlue,
      Color textLight, Color textMuted) {
    if (_filteredBarang.isEmpty) {
      return const Text('Tidak ada barang ditemukan.',
          style: TextStyle(color: Colors.white));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemCount: _filteredBarang.length,
      itemBuilder: (context, index) {
        final barang = _filteredBarang[index];
        final String imageUrl = barang['GAMBAR_BARANG'] != null &&
                Uri.tryParse(barang['GAMBAR_BARANG'])?.hasAbsolutePath == true
            ? barang['GAMBAR_BARANG'] as String
            : 'https://via.placeholder.com/400x250/2a2a2a/f8f9fa?text=No+Image';

        return GestureDetector(
          onTap: () {
            print(
                'Product tapped: ${barang['NAMA_BARANG']} (ID: ${barang['ID_BARANG']})');
            // TODO: Navigate to detail page using your controller
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(barangId: barang['ID_BARANG'])));
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardDark,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://via.placeholder.com/400x250/2a2a2a/f8f9fa?text=No+Image',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentGreen, accentBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            barang['KONDISI_BARANG'] as String,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barang['NAMA_BARANG'] as String,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textLight),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        barang['DESKRIPSI_BARANG'] as String,
                        style: TextStyle(color: textMuted, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${int.parse(barang['HARGA_BARANG'] as String).toLocaleString('id-ID')}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[accentGreen, accentBlue],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 100.0, 40.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterLink(String text, String route) {
    const Color textMuted = Color(0xFFADB5BD);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          print('Footer link tapped: $text ($route)');
          // TODO: Implement navigation
        },
        child: Text(
          text,
          style: const TextStyle(color: textMuted, fontSize: 14),
        ),
      ),
    );
  }
}

// Extension for number formatting
extension NumberExtension on num {
  String toLocaleString(String locale) {
    if (locale == 'id-ID') {
      final formatter =
          NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
      return formatter.format(this);
    }
    return toString();
  }
}
