import 'package:flutter/material.dart';

import '../config/approutes.dart';
import '../models/login_model.dart';
import '../provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  TextEditingController countryCode = TextEditingController();
  TextEditingController phone = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Enter your phone number",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey),
                ),
                const SizedBox(height: 20),
                 Row(
                  children: [
                    buildCountryCode(),
                    const SizedBox(width: 10),
                    buildPhoneUI(),
                  ],
                ),
                const SizedBox(height: 20),
                Spacer(),
               buildLoginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// buildCountryCode
   Widget buildCountryCode(){
    return SizedBox(
      width: 80,
      child: TextFormField(
        controller: countryCode,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: "+91",
          border: OutlineInputBorder(),
        ),
      ),
    );
   }

   /// buildPhoneUI
  Widget buildPhoneUI(){
     return Expanded(
       child: TextFormField(
         controller: phone,
         style: const TextStyle(color: Colors.white),
         keyboardType: TextInputType.phone,
         decoration: const InputDecoration(
           labelText: "Phone",
           border: OutlineInputBorder(),
         ),
       ),
     );
  }

  ///buildLoginButton
  Widget buildLoginButton(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              final userModel = UserModel(countryCode: countryCode.text, phone: phone.text);
              await loginProvider.loginUser(userModel);
                Navigator.pushNamed(context, AppRoutes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade900,
            ),
            child: Text("Submit", style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        );
      },
    );
  }
}
