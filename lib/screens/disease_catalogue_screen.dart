import 'package:flutter/material.dart';

import '../models/catalogue_item.dart';
import '../services/catalogue_service.dart';

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
      filteredItems = items.where((item) {
        final search = query.toLowerCase();

        return item.diseaseName.toLowerCase().contains(search) ||
            item.finding.toLowerCase().contains(search);
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

              const SizedBox(height: 10),

              Text(
                "Browse poultry disease images and findings.",

                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),

              const SizedBox(height: 25),

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

              const SizedBox(height: 25),

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
                          crossAxisCount: 2,

                          crossAxisSpacing: 12,

                          mainAxisSpacing: 12,

                          childAspectRatio: 0.72,
                        ),

                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      final imagePath =
                          "assets/dataset/${item.diseaseId}/${item.imageName}";

                      return Card(
                        elevation: 4,

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
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item.diseaseName,

                                    maxLines: 1,

                                    overflow: TextOverflow.ellipsis,

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    item.finding,

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
