
import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../servise/network_servise.dart';

class UserDetailPage extends StatefulWidget {
  final User? user;
  const UserDetailPage({Key? key, this.user}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late final TextEditingController controllerUsername;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerPassword;
  Status status = Status.read;

  void pressFAB() {
    if(status == Status.read) {
      setState(() => status = Status.edit);
    } else {
      sendDataToServer();
    }
  }

  void sendDataToServer() async {
    String username = controllerUsername.value.text.trim();
    String email = controllerEmail.value.text.trim();
    String phone = controllerPhone.value.text.trim();
    String password = controllerPassword.value.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      return;
    }
    final createUserData = User(id: 007, firstName: username, lastName: username,
        maidenName: username, age: 23, gender: Gender.FEMALE, email: email, phone: phone,
        username: username, password: password, birthDate: "", image: widget.user!.image, bloodGroup: widget.user!.bloodGroup,
        height: widget.user!.height, weight:  widget.user!.weight, eyeColor: widget.user!.eyeColor, hair: Hair(color: widget.user!.hair.color, type: widget.user!.hair.type),
        domain: widget.user!.domain, ip: widget.user!.ip, address: Address(address: widget.user!.address.address, city: widget.user!.address.city, coordinates: Coordinates(lat: widget.user!.address.coordinates.lat, lng: widget.user!.address.coordinates.lng),
            postalCode: widget.user!.address.postalCode, state: widget.user!.address.state), macAddress: widget.user!.macAddress, university: widget.user!.university,
        bank: Bank(cardExpire: widget.user!.bank.cardExpire, cardNumber: widget.user!.bank.cardNumber, cardType: widget.user!.bank.cardType, currency: widget.user!.bank.currency, iban: widget.user!.bank.iban),
        company: Company(address: Address(address: widget.user!.company.address.address, city:  widget.user!.company.address.city, coordinates: Coordinates(lat:  widget.user!.company.address.coordinates.lat, lng: widget.user!.company.address.coordinates.lng),
            postalCode: widget.user!.company.address.postalCode, state: widget.user!.company.address.state), department: widget.user!.company.department, name: widget.user!.company.name, title: widget.user!.company.title),
        ein: widget.user!.ein, ssn: widget.user!.ssn, userAgent: widget.user!.userAgent);

    final data = createUserData.toJson();
    log("toJson => ====$data===");
    debugPrint(data.toString());
    if(status == Status.create){
      await createUser(data);
    } else if(status == Status.edit) {
      await editUser(data);
      //log("====$data===");
    }

    if(mounted) {
      Navigator.pop(context, "Done");
    }
  }

  Future<void> editUser(Map<String, Object?> data) async {
    await Network.putMethod(
      api: Network.apiUsers,
      id: widget.user!.id,
      data: data,
    );
  }

  Future<void> createUser(Map<String, Object?> data) async {
    await Network.postMethod(
      api: Network.apiAdd,
      data: data,
    );
  }


  void getOldUser() {
    if(widget.user == null) {
      status = Status.create;
    }
    controllerUsername = TextEditingController(text: widget.user?.firstName);
    controllerEmail = TextEditingController(text: widget.user?.email);
    controllerPhone = TextEditingController(text: widget.user?.phone);
    controllerPassword = TextEditingController(text: widget.user?.password);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOldUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(status.name.substring(0,1).toUpperCase() + status.name.substring(1))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controllerUsername,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Username"),
              readOnly: status == Status.read,),
           const SizedBox(height: 20,),
            TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Email"),
              readOnly: status == Status.read,),
            const SizedBox(height: 20,),
            TextField(
              controller: controllerPhone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Phone"),
              readOnly: status == Status.read,),
            const SizedBox(height: 20,),
            TextField(
              controller: controllerPassword,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Password"),
              readOnly: status == Status.read,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pressFAB,
        child: Icon(status == Status.read ? Icons.edit : Icons.check),
      ),
    );
  }
}

enum Status {
  read,
  create,
  edit
}