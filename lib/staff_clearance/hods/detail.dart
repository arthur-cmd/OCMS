// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, depend_on_referenced_packages, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, body_might_complete_normally_nullable
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ocms/staff_clearance/coach_staff/claims.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../authentication/login.dart';

class Detailhods extends StatefulWidget {
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
  Detailhods({
    Key? key,
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
  }) : super(key: key);

  @override
  State<Detailhods> createState() => _DetailhodsState();
}

class _DetailhodsState extends State<Detailhods> {
  Future accept() async {
    const url = 'http://192.168.43.132:8080/ocms/staff/hod_accept.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['names'] = widget.names.toString();
    request.fields['pay_roll'] = widget.pay_roll.toString();
    request.fields['designation'] = widget.designation.toString();
    request.fields['college'] = widget.college.toString();
    request.fields['reason'] = widget.reason.toString();
    request.fields['date_departure'] = widget.date_departure.toString();
    request.fields['date_return'] = widget.date_return.toString();
    request.fields['contact_address'] = widget.contact_address.toString();
    request.fields['physical_address'] = widget.physical_address.toString();
    request.fields['house_unit'] = widget.house_unit.toString();
    request.fields['telephone_kin'] = widget.telephone_kin.toString();
    var response = await request.send();

    try {
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Coachs(
                    // u,
                    )));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    accept();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#013221'))),
                    child: Text('Accept'),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Text('Decline'),
                  ),
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    TextEditingController comment = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    bool isLoading = false;
    done() async {
      await Future.delayed(Duration(seconds: 5), () {
        setState(() {
          isLoading = false;
        });
      });
    }

    Future decline() async {
      // 192.168.43.251
      // 192.168.43.251
      var from = 'Head of department';
      const url =
          'http://192.168.43.132:8080/ocms/head_of_unit_staff/hods_decline.php';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['names'] = widget.names.toString();
      request.fields['pay_roll'] = widget.pay_roll.toString();
      request.fields['designation'] = widget.designation.toString();
      request.fields['college'] = widget.college.toString();
      request.fields['reason'] = widget.reason.toString();
      request.fields['date_departure'] = widget.date_departure.toString();
      request.fields['date_return'] = widget.date_return.toString();
      request.fields['contact_address'] = widget.contact_address.toString();
      request.fields['physical_address'] = widget.physical_address.toString();
      request.fields['house_unit'] = widget.house_unit.toString();
      request.fields['telephone_kin'] = widget.telephone_kin.toString();
      request.fields['fromm'] = from.toString();
      request.fields['comment'] = comment.text;
      var response = await request.send();

      try {
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => Coachs(
                      // u,
                      )));
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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 208, 208, 208),
      body: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Add some comment'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: HexColor('#013221')),
                  controller: comment,
                  cursorColor: HexColor('#013221'),
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor('#013221')),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: HexColor('#013221')),
                    ),
                    fillColor: HexColor("#f0f0f0"),
                    hoverColor: HexColor('#013221'),
                    focusColor: HexColor('#013221'),
                    hintText: 'Comment',
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: HexColor('#013221')),
                    prefixIcon: Icon(
                      Icons.map_outlined,
                      color: HexColor('#013221'),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else if (value.isEmpty) {
                      return 'Comment is Empty';
                    }
                  },
                ),
                isLoading
                    ? SpinKitCircle(
                        // duration: const Duration(seconds: 3),
                        // size: 100,
                        color: Theme.of(context).iconTheme.color,
                      )
                    : Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: HexColor('#013221'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      // color: HexColor('#cbdd33')
                                      ))),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            decline();
                          },
                          child: Text(
                            'Submit the comment',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: HexColor('#013221'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                          // color: HexColor('#cbdd33')
                          ))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
