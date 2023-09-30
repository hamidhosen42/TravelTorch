import 'package:flutter/material.dart';

progressDialog(context) => showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text("Processing"),
            ],
          ),
        ),
      ),
    );
