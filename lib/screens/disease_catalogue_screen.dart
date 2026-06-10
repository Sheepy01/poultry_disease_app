import 'package:flutter/material.dart';

import '../models/catalogue_item.dart';
import '../services/catalogue_service.dart';
import '../utils/app_config.dart';
import 'disease_detail_screen.dart';

class DiseaseCatalogueScreen extends StatefulWidget {
  const DiseaseCatalogueScreen({super.key});

  @override
  State<DiseaseCatalogueScreen> createState() => _DiseaseCatalogueScreenState();
}

class _DiseaseCatalogueScreenState extends State<DiseaseCatalogueScreen> {
  final CatalogueService service = CatalogueService();

  final TextEditingController searchController = TextEditingController();

  List<CatalogueItem> items = [];

  List<CatalogueItem> filteredItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCatalogue();
  }

  Future<void> loadCatalogue() async {
    try {
      items = await service.loadCatalogueItems();

      filteredItems = List.from(items);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Catalogue Error: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  void filterItems(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredItems = List.from(items);

        return;
      }

      final search = query.toLowerCase();

      filteredItems = items.where((item) {
        return AppConfig.text(
              item.disease.displayName,
            ).toLowerCase().contains(search) ||
            AppConfig.text(item.finding).toLowerCase().contains(search);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              const Text(
                "Disease Catalogue",

                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Browse poultry disease images and findings.",

                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,

                onChanged: filterItems,

                decoration: InputDecoration(
                  hintText: "Search disease or finding...",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredItems.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,

                          crossAxisSpacing: 12,

                          mainAxisSpacing: 12,

                          childAspectRatio: 0.72,
                        ),

                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      final imagePath =
                          "assets/dataset/${item.disease.diseaseId}/${item.imageName}";

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => DiseaseDetailScreen(
                                disease: item.disease,

                                selectedImage: item.imageName,
                              ),
                            ),
                          );
                        },

                        child: Card(
                          elevation: 4,

                          shadowColor: Colors.black12,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),

                                  child: Image.asset(
                                    imagePath,

                                    width: double.infinity,

                                    fit: BoxFit.cover,

                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.shade200,

                                        child: const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 40,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      AppConfig.text(item.disease.displayName),

                                      maxLines: 1,

                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,

                                        fontSize: 14,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      AppConfig.text(item.finding),

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                        fontSize: 12,

                                        color: Colors.grey.shade700,
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
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
