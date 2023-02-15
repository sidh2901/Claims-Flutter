import 'dart:math';

import 'package:flutter/material.dart';
import 'package:web_admin/constants/dimens.dart';
import 'package:web_admin/generated/l10n.dart';
import 'package:web_admin/models/claims.dart';
import 'package:web_admin/services/remote_services.dart';
import 'package:web_admin/theme/theme_extensions/app_button_theme.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_admin/theme/theme_extensions/app_color_scheme.dart';
import 'package:web_admin/theme/theme_extensions/app_data_table_theme.dart';
import 'package:web_admin/views/widgets/card_elements.dart';
import 'package:web_admin/views/widgets/portal_master_layout/portal_master_layout.dart';

String stringResponse = '';
Map mapResponse = {};

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataTableHorizontalScrollController = ScrollController();
  List<Claims>? claims;
  var isLoaded = false;
  // Future apicall() async {
  //   http.Response response;
  //   response = await http.get(Uri.parse('http://20.62.171.46:9000/claims'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       stringResponse = response.body;
  //       mapResponse = json.decode(response.body);
  //     });
  //   }
  // }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    claims = await RemoteService().getClaims();
    if (claims != null) {
      setState() {
        isLoaded = true;
      }
    }
  }

  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = Theme.of(context).extension<AppColorScheme>()!;
    final appDataTableTheme = Theme.of(context).extension<AppDataTableTheme>()!;
    final size = MediaQuery.of(context).size;

    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);

    return PortalMasterLayout(
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          Text(
            lang.dashboard,
            style: themeData.textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final summaryCardWidth = ((constraints.maxWidth -
                        (kDefaultPadding * (summaryCardCrossAxisCount - 1))) /
                    summaryCardCrossAxisCount);

                return Wrap(
                  direction: Axis.horizontal,
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    SummaryCard(
                      title: 'Total Facilities',
                      value: '1001',
                      icon: Icons.shop_2,
                      backgroundColor: appColorScheme.buttonTextDisabled,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Total Customers',
                      value: '1000',
                      icon: Icons.person,
                      backgroundColor: appColorScheme.info,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Total Claims',
                      value: '999',
                      icon: Icons.shopping_cart_rounded,
                      backgroundColor: appColorScheme.primary,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Claim Amount',
                      value: '794,546.62',
                      icon: Icons.attach_money,
                      backgroundColor: appColorScheme.success,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Paid Amount',
                      value: '449,146.20',
                      icon: Icons.monetization_on,
                      backgroundColor: appColorScheme.warning,
                      textColor: appColorScheme.buttonTextBlack,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: lang.pendingIssues(2),
                      value: '0',
                      icon: Icons.report_gmailerrorred_rounded,
                      backgroundColor: appColorScheme.error,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardHeader(
                    title: lang.recentOrders(2),
                    showDivider: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double dataTableWidth =
                            max(kScreenWidthMd, constraints.maxWidth);

                        return Scrollbar(
                          controller: _dataTableHorizontalScrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _dataTableHorizontalScrollController,
                            child: SizedBox(
                              width: dataTableWidth,
                              child: Theme(
                                data: themeData.copyWith(
                                  cardTheme: appDataTableTheme.cardTheme,
                                  dataTableTheme:
                                      appDataTableTheme.dataTableThemeData,
                                ),
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  showBottomBorder: true,
                                  columns: const [
                                    DataColumn(
                                        label: Text('No.'), numeric: true),
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Item')),
                                    DataColumn(
                                        label: Text('Price'), numeric: true),
                                  ],
                                  rows: List.generate(5, (index) {
                                    return DataRow.byIndex(
                                      index: index,
                                      cells: [
                                        DataCell(Text('#${index + 1}')),
                                        const DataCell(Text('2022-06-30')),
                                        DataCell(Text('Item ${index + 1}')),
                                        DataCell(
                                            Text('${Random().nextInt(10000)}')),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: SizedBox(
                        height: 40.0,
                        width: 120.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: themeData
                              .extension<AppButtonTheme>()!
                              .infoElevated,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: kDefaultPadding * 0.5),
                                child: Icon(
                                  Icons.visibility_rounded,
                                  size: (themeData.textTheme.button!.fontSize! +
                                      4.0),
                                ),
                              ),
                              const Text('View All'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('20.62.171.46:9000/claims'));
}

class Album {
  final int claimId;
  final String claimStatus;
  final String claimType;
  final int claimedAmount;
  final String closedDate;
  final String createdDate;
  final String creatorId;
  final String customerId;
  final String documentType;
  final int facilityId;
  final String lastUpdateDate;
  final String lastUpdateId;
  final String paidAmount;
  final String masterAccount;
  final String palletQuantity;
  final String serviceProviderClaimId;
  final String userId;

  const Album({
    required this.claimId,
    required this.claimStatus,
    required this.claimType,
    required this.claimedAmount,
    required this.closedDate,
    required this.createdDate,
    required this.creatorId,
    required this.customerId,
    required this.documentType,
    required this.facilityId,
    required this.lastUpdateDate,
    required this.lastUpdateId,
    required this.masterAccount,
    required this.paidAmount,
    required this.palletQuantity,
    required this.serviceProviderClaimId,
    required this.userId,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      claimId: json['claimId'],
      claimStatus: json['claimStatus'],
      claimType: json['claimType'],
      claimedAmount: json['claimedAmount'],
      closedDate: json['closedDate'],
      createdDate: json['createdDate'],
      customerId: json['customerId'],
      creatorId: json['creatorId'],
      documentType: json['documentType'],
      facilityId: json['facilityId'],
      lastUpdateDate: json['lastUpdateDate'],
      lastUpdateId: json['lastUpdateId'],
      masterAccount: json['masterAccount'],
      paidAmount: json['paidAmount'],
      palletQuantity: json['palletQuantity'],
      serviceProviderClaimId: json['serviceProviderClaimId'],
    );
  }
}

List<Album> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

Future<List<Album>> fetchProducts() async {
  final response = await http.get(Uri.parse('20.62.171.46:9000/claims'));
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 120.0,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(
              top: kDefaultPadding * 0.5,
              right: kDefaultPadding * 0.5,
              child: Icon(
                icon,
                size: 80.0,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                    child: Text(
                      value,
                      style: textTheme.headlineMedium!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: textTheme.labelLarge!.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
