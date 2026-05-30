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
        const SnackBar(
          content: Text('الرجاء ملء جميع الحقول المطلوبة', textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
        ),
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
      if (e.code == 'wrong-password') message = 'كلمة المرور التي أدخلتها خاطئة';
      if (e.code == 'email-already-in-use') message = 'البريد الإلكتروني مستخدم بالفعل';
      if (e.code == 'weak-password') message = 'كلمة المرور ضعيفة جداً، اختر كلمة أقوى';
      if (e.code == 'invalid-email') message = 'صيغة البريد الإلكتروني غير صحيحة';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
        ),
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
                color: Colors.white, 
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
                    _isSignUp ? "إنشاء حساب جديد" : "تسجيل الدخول",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF8B5E3C)),
                  ),
                  const SizedBox(height: 30),
                  
                  // حقل البريد الإلكتروني مع دعم المحاذاة اليمينية
                  _buildTextField(
                    "البريد الإلكتروني", 
                    "أدخل بريدك الإلكتروني", 
                    _emailController,
                    textDirection: TextDirection.ltr, // ليبقى الإيميل يكتب بشكل صحيح من اليسار لليمين
                  ),
                  const SizedBox(height: 20),
                  
                  // حقل كلمة المرور
                  _buildTextField(
                    "كلمة المرور", 
                    "أدخل كلمة المرور الخاصة بك", 
                    _passwordController, 
                    isPass: true,
                    textDirection: TextDirection.ltr,
                  ),
                  
                  const SizedBox(height: 35), // مسافة إضافية منسقة لتعويض الجزء المحذوف
                  
                  _isLoading 
                  ? const CircularProgressIndicator(color: Color(0xFF8B5E3C))
                  : SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E3C), 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: Text(
                          _isSignUp ? "إنشاء حساب" : "دخول", 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                      });
                    },
                    child: Text(
                      _isSignUp ? "لديك حساب بالفعل؟ سجل دخولك" : "ليس لديك حساب؟ سجل معنا الآن",
                      style: const TextStyle(color: Color(0xFF8B5E3C), fontWeight: FontWeight.w600, fontSize: 14),
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

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isPass = false, TextDirection? textDirection}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // محاذاة النص التوضيحي لليمين ليتناسب مع اللغة العربية
        Align(
          alignment: Alignment.topRight,
          child: Text(label, style: const TextStyle(color: Color(0xFF8B5E3C), fontWeight: FontWeight.w600, fontSize: 14)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPass,
          textDirection: textDirection,
          textAlign: textDirection == TextDirection.ltr ? TextAlign.left : TextAlign.right,
          style: const TextStyle(color: Color(0xFF4A3428)), 
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: const Color(0xFF4A3428).withValues(alpha: 0.4), fontSize: 14), 
            hintTextDirection: TextDirection.rtl, // اتجاه التلميح الافتراضي عربي
            filled: true,
            fillColor: const Color(0xFFF5F2ED), 
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), 
              borderSide: const BorderSide(color: Color(0xFF8B5E3C), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}