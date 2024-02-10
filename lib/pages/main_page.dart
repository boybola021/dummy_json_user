

import 'package:dummy_json_user/pages/user_detail_page.dart';
import 'package:dummy_json_user/pages/user_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../servise/network_servise.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int currentIndex = 0;
   PageController controller = PageController();
  void pressButton(int index) {
    currentIndex = index;
    controller.jumpToPage(currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index) => pressButton(index),
        children:  const [
          HomePage() ,
          SearchPage() ,
         UserDetailPage() ,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.cyan,
       backgroundColor: Colors.indigoAccent,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: currentIndex == 0
                  ? const Icon(Icons.home_outlined,size: 40,)
                  : const Icon(Icons.home_outlined,size: 30,),
          ),

          BottomNavigationBarItem(
            label: "Search",
            icon: currentIndex == 1
                ? const Icon(Icons.search,size: 40,)
                : const Icon(Icons.search,size: 30,),
          ),

          BottomNavigationBarItem(
              label: "Add User",
              icon: currentIndex == 2
                  ? const Icon(Icons.add,size: 40,)
                  : const Icon(Icons.add,size: 30,),),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController controllerText;
  late final user;
  bool come = false;
  @override
  void initState() {
    super.initState();
    //search();
  }
  void search()async{
    String username = controllerText.value.text.trim();
    if(username.isEmpty){
      return;
    }
    Future<void> searchMethod(Map<String, Object?> data) async {
       user = await Network.searchMethod(
        api: Network.apiUsers,
        query : {"q" : username},);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       title: const Text("Search User",style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            TextField(
             //controller: controllerText,
              onSubmitted: (String text){

              },
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Search"),
            ),
            const SizedBox(height: 20,),
            if(come)  ListTile(
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyan,
                    image:
                    DecorationImage(image: NetworkImage(user.image))),
              ),
              title: Text(
                user.firstName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                user.birthDate.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            CupertinoIcons.delete,
                          ),
                          Text("Delate"),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
