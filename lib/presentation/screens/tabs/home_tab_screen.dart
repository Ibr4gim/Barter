import 'package:flutter/material.dart';
import 'package:my_project/presentation/widgets/custom_card.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Change brightness mode',
                      child: IconButton(
                        isSelected: isDark,
                        onPressed: () {
                          setState(() {
                            isDark = !isDark;
                          });
                        },
                        icon: const Icon(Icons.wb_sunny_outlined),
                        selectedIcon: const Icon(Icons.brightness_2_outlined),
                      ),
                    ),
                  ],
                );
              },
              suggestionsBuilder: (
                BuildContext context,
                SearchController controller,
              ) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
          ),
          Column(
            children: [
              ProductCard(
                imagePath: 'assets/images/duck.png',
                title: 'title',
                price: 100,
                onTap: () {},
                backgroundColor: const Color.fromARGB(255, 136, 234, 139),
                width: MediaQuery.of(context).size.width * 0.90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  ProductCard(
                    imagePath: 'assets/images/duck.png',
                    title: 'Product 1',
                    price: 29.99,
                    onTap: () {},
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                  ProductCard(
                    imagePath: 'assets/images/duck.png',
                    title: 'Product 2',
                    price: 39.99,
                    onTap: () {},
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  ProductCard(
                    imagePath: 'assets/images/duck.png',
                    title: 'Product 1',
                    price: 29.99,
                    onTap: () {},
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                  ProductCard(
                    imagePath: 'assets/images/duck.png',
                    title: 'Product 2',
                    price: 39.99,
                    onTap: () {},
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
