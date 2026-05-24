import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isSignUp = false; 
  bool _isLoading = false; 

  void _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ ما، يرجى المحاولة لاحقاً';
      if (e.code == 'user-not-found') message = 'هذا الحساب غير موجود';
      if (e.code == 'wrong-password') message = 'كلمة المرور خاطئة';
      if (e.code == 'email-already-in-use') message = 'البريد الإلكتروني مستخدم بالفعل';
      if (e.code == 'weak-password') message = 'كلمة المرور ضعيفة جداً';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F2ED),
              Color(0xFFF5F2ED), 
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 360,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white, // 🌟 
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05), 
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xFF8B5E3C),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isSignUp ? Icons.person_add_alt_1_outlined : Icons.person_outline, 
                      color: Colors.white, 
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 25),
                  
                  Text(
                    _isSignUp ? "Create Account" : "Login",
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF8B5E3C)), // تعديل للون البني
                  ),
                  const SizedBox(height: 30),
                  
                  // حقل إدخال الإيميل
                  _buildTextField("Email ID", "Enter your email", _emailController),
                  const SizedBox(height: 20),
                  
                  // حقل إدخال كلمة المرور
                  _buildTextField("Password", "Enter your password", _passwordController, isPass: true),
                  const SizedBox(height: 15),
                  
                  // خيارات التذكر ونسيان كلمة السر (تظهر في حالة تسجيل الدخول فقط)
                  if (!_isSignUp)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              child: Checkbox(
                                value: true, 
                                onChanged: (v){}, 
                                activeColor: const Color(0xFF8B5E3C),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text("Remember me", style: TextStyle(color: Color(0xFF8B5E3C), fontSize: 12)), // تعديل للون البني
                          ],
                        ),
                        TextButton(
                          onPressed: (){}, 
                          child: const Text("Forgot Password?", style: TextStyle(color: Color(0xFF8B5E3C), fontSize: 12)), // تعديل للون البني
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 25),
                  
                  _isLoading 
                  ? const CircularProgressIndicator(color: Color(0xFF8B5E3C))
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E3C), 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: Text(
                          _isSignUp ? "Sign Up" : "Login", 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 15),
                  
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                      });
                    },
                    child: Text(
                      _isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up",
                      style: const TextStyle(color: Color(0xFF8B5E3C), fontWeight: FontWeight.w500), // تعديل للون البني
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isPass = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8B5E3C), fontWeight: FontWeight.w500, fontSize: 14)), // تعديل للون البني
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPass,
          style: const TextStyle(color: Color(0xFF4A3428)), // لون النص المكتوب بني غامق
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: const Color(0xFF4A3428).withValues(alpha: 0.4), fontSize: 14), // تعديل للون التلميح
            filled: true,
            fillColor: const Color(0xFFF5F2ED), // جعل خلفية الحقول بيج فاتح لتتناسق مع الخلفية العامة للموقع
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), 
              borderSide: const BorderSide(color: Color(0xFF8B5E3C)),
            ),
          ),
        ),
      ],
    );
  }
}