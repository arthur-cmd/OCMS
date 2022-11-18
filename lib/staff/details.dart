// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, depend_on_referenced_packages, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, body_might_complete_normally_nullable
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ocms/students/student.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';

class Detailst extends StatefulWidget {
  var fromm;
  var comment;
  var names;
  var designation;
  var college;
  var pay_roll;
  var reason;
  var date_departure;
  var date_return;
  var contact_address;
  var physical_address;
  var house_unit;
  var telephone_kin;
  Detailst({
    Key? key,
    required this.fromm,
    required this.names,
    required this.designation,
    required this.college,
    required this.pay_roll,
    required this.reason,
    required this.date_departure,
    required this.date_return,
    required this.contact_address,
    required this.physical_address,
    required this.house_unit,
    required this.telephone_kin,
    required this.comment,
  }) : super(key: key);

  @override
  State<Detailst> createState() => _DetailstState();
}

class _DetailstState extends State<Detailst> {
  Future accept() async {
    // 192.168.43.251
    // 192.168.43.251
    const url = 'http://192.168.43.132:8080/ocms/staff/submit.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['pay_roll'] = widget.pay_roll.toString();
    request.fields['fromm'] = widget.fromm.toString();
    var response = await request.send();

    try {
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Student('')));
        Fluttertoast.showToast(
          msg: 'Succefully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      } else {
        await done();
        Fluttertoast.showToast(
          msg: 'Input Fields contain an Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    } catch (e) {
      {
        await done();
        // Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
        Fluttertoast.showToast(
          msg: 'Could not connect',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    }
  }

  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  var unit_name;
  Future get_username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.get('status');
    setState(() {
      unit_name = name;
    });
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: HexColor('#013221'),
          actions: [
            IconButton(
                onPressed: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('username');
                  sharedPreferences.remove('status');
                  Navigator.of(context).pushAndRemoveUntil(
                      // the new route
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),

                      // this function should return true when we're done removing routes
                      // but because we want to remove all other screens, we make it
                      // always return false
                      (Route route) => false);
                },
                icon: Icon(Icons.person_off))
          ],
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Details for  ',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: '${widget.names}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
              ),
            )
          ]))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Full Name:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.names}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Staff Id:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.pay_roll}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Designation:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.designation}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'College:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.college}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Contact Address:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.contact_address}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Physical Address:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.physical_address}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'House Unit:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.house_unit}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Telephone of next to kin:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.telephone_kin}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Reason for departure:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.reason}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Date Departure:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.date_departure}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Date Return:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.date_return}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Comment:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.comment}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'From:  ',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${widget.fromm}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer(),
                InkWell(
                  onTap: () {
                    accept();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#013221'))),
                    child: Text('Resubmit'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
