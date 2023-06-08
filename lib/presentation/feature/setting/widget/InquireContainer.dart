import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subway_ody/presentation/ui/typography.dart';
import 'package:subway_ody/presentation/utils/Common.dart';
import 'package:subway_ody/presentation/utils/SnackBarUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class InquireContainer extends StatelessWidget {
  const InquireContainer({
    super.key,
  });

  final inquireLink = 'https://docs.google.com/forms/d/e/1FAIpQLSf85rvkphDEIWzUyb7y6el2TREfuKJzahX4gbi74YCA5snauA/viewform';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 4, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).settingMenuEtcInquiry,
            style: getTextTheme(context).bold.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 20),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                final url = Uri.parse(inquireLink);
                launchUrl(url, mode: LaunchMode.externalApplication);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getAppLocalizations(context).settingMenuEtcCS,
                        style: getTextTheme(context).regular.copyWith(
                              color: const Color(0xFF2F2F2F),
                              fontSize: 16,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: SvgPicture.asset(
                          'assets/imgs/icon_next_1_5_large.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF2F2F2F),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getAppLocalizations(context).settingMenuEtcCSDescription,
                    style: getTextTheme(context).regular.copyWith(
                          color: const Color(0xFFB1B1B1),
                          fontSize: 12,
                          height: 1.18,
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
