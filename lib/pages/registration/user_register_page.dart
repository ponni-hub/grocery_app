import 'package:flutter/material.dart';
import 'package:grocery_app/api/api_service.dart';
import 'package:grocery_app/models/customer_model.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  bool isAPICallProcess = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? fullName;
  String? password;
  String? confirmPassword;
  String? email;

  bool hidePassword = true, hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Form(
  key: _formkey,
  child: _registerUI(context),
),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: true,
      title: const Text("Registration"),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Center(
            child: Text(
              "Online Grocery",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInputField(
            context,
            "Full Name",
            const Icon(Icons.face),
            (val) => val!.isEmpty ? "Required" : null,
            (val) => fullName = val!.trim(),
          ),
          const SizedBox(height: 15),
          _buildInputField(
            context,
            "Email",
            const Icon(Icons.email_outlined),
            (val) {
              if (val!.isEmpty) return "Required";
              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(val)) {
                return "Invalid E-mail";
              }
              return null;
            },
            (val) => email = val!.trim(),
          ),
          const SizedBox(height: 15),
          _buildInputField(
            context,
            "Password",
            const Icon(Icons.lock_open),
            (val) => val!.isEmpty ? "Required" : null,
            (val) => password = val!.trim(),
            onChange: (val) => password = val,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
            obscureText: hidePassword,
          ),
          const SizedBox(height: 15),
          _buildInputField(
            context,
            "Confirm Password",
            const Icon(Icons.lock_open),
            (val) {
              if (val!.isEmpty) return "* Required";
              if (val != password) return "* Confirm password does not match";
              return null;
            },
            (val) => confirmPassword = val!.trim(),
            onChange: (val) => confirmPassword = val,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hideConfirmPassword = !hideConfirmPassword;
                });
              },
              icon: Icon(hideConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
            obscureText: hideConfirmPassword,
          ),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  setState(() {
                    isAPICallProcess = true;
                  });

                  CustomerModel customerModel = CustomerModel(
                    email: email,
                    fullName: fullName,
                    password: password,
                  );

                  ApiService.registerUser(customerModel).then((response) {
                    setState(() {
                      isAPICallProcess = false;
                    });

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Registration"),
                        content: Text(response
                            ? "Registration Successful"
                            : "Registration Failed"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  });
                }
              },
              child: const Text("Sign Up"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String label,
    Icon prefixIcon,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved, {
    Function(String)? onChange,
    Widget? suffixIcon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.grey.shade100,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
        onChanged: onChange,
      ),
    );
  }
}
