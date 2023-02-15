import 'package:flutter/material.dart';
import 'package:web_admin/models/claims.dart';
import 'package:web_admin/services/remote_services.dart';

class DataTable extends StatefulWidget {
  const DataTable({super.key});

  @override
  State<DataTable> createState() => _DataTableState();
}

class _DataTableState extends State<DataTable> {
  List<Claims>? claims;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getClaims();
  }

  getClaims() async {
    claims = await RemoteService().getClaims();
    if (claims != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Claims'),
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: claims?.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(claims![index].claimId),
              );
            },
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
