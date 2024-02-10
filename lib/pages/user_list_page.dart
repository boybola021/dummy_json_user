import 'dart:async';
import 'dart:developer';

import 'package:dummy_json_user/pages/user_detail_page.dart';
import 'package:dummy_json_user/pages/user_enter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../servise/network_servise.dart';
import 'package:lottie/lottie.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  int page = 0;
  int limit = 20;
  int total = 100;
  bool isLoading = false;
  int exit = 0;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getAllUsers();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent
          && ((page + 1) * limit) == users.length) {
        page++;
        debugPrint("page: $page");
        getAllUsers(page: page);
      }
    });
  }

  void getAllUsers({int page = 0}) async {
    setState(() => isLoading = true);
    final query = {
      "limit": "$limit",
      "skip": "${page * limit}",
    };
    final response = await Network.getMethod(api: Network.apiUsers, query: query);
    users.addAll(Network.apiResponseParse(response!).users);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          Timer(const Duration(seconds:  1),(){
            exit = 0;
          });
          exit++;
          if(exit == 2){
            log("====User chiqib ketti====");
            return true;
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: ()async{
            users = [];
            page = 0;
            getAllUsers();
          },
          child: Stack(
            children: [
              ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(20),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserCard(user: user);
                },
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minLeadingWidth: 60,
        title: Text(user.username),
        subtitle: Text(user.email),
        trailing: Text(user.id.toString(), style: Theme.of(context).textTheme.headlineMedium,),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Image(
            image: NetworkImage(user.image),
            errorBuilder: (context, _, __) {
              return const SizedBox(
                width: 60,
                child: Icon(Icons.warning_rounded),
              );
            },
          ),
        ),
      ),
    );
  }
}

/*
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  bool isLoading = false;
  bool isSellectet = false;
  int currentIndex = 0;
  int paginatipon = 10;
  int page = 0;
  int limit = 20;
  final ScrollController controller = ScrollController();
  double offset = 0.0;
  static int total = 100;
  @override
  void initState() {
    super.initState();
    getAllUser();
    controller.addListener(() {
   if(controller.position.pixels >= controller.position.maxScrollExtent){
     page++;
     getAllUser(page: page);
   }
    });
  }

  void getAllUser({int page = 0}) async {
    final query = {
      "limit" : "20",
      "skip" : "${page * limit}"
    };
    setState(() => isLoading = false);
    final String? response = await Network.getMethod(
      api: Network.apiUsers,

    );
    users = Network.apiParse(response!).users;
    setState(() => isLoading = false);
  }
  void enterUser({required User user}) async{
   final msg = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserCabinet(users: user,)));
    if(msg == "Done")getAllUser();
  }
   void createdUser() async{
   final msg = await Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDetailPage()));
    if(msg == "Done")getAllUser();
  }
  void delateUser(Object id)async{
    setState(() => isLoading = true);
     await Network.delateMethod(api: Network.apiUsers, id: id);
    debugPrint("=======delate======");
    getAllUser();
  }
  void animatetPage(){
    controller.addListener(() {
      if(offset < controller.position.maxScrollExtent - 320){
        offset += 400;
      }
      controller.animateTo(offset, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
     setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Users",style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2.5),
              itemCount: users.length,
              controller: controller,
              itemBuilder: (context, i) {
                final user = users[i];
                return Card(
                  child: ListTile(
                    onTap: () => enterUser(user: user),
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.primaries[i % Colors.primaries.length],
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
                            PopupMenuItem(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  CupertinoIcons.delete,
                                ),
                                Text("Delate"),
                              ],
                            ),
                             onTap: () => delateUser(user.id),
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: (){
                  if(paginatipon > users.length) {
                    return;
                  }else if(paginatipon < users.length){
                    paginatipon += 10;
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  fixedSize:   Size(MediaQuery.sizeOf(context).width,60),
                ),
                child: const Text("Again",style: TextStyle(fontSize: 20),),
              ),
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }
}
*/