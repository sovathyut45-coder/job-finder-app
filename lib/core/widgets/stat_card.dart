// import 'package:flutter/material.dart';

// class StatCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final Color color;

//   const StatCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         elevation: 4,
//         shadowColor: color.withOpacity(0.25),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 color.withOpacity(0.08),
//                 color.withOpacity(0.02),
//               ],
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Icon with background circle
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 26,
//                   color: color,
//                 ),
//               ),
//               const SizedBox(height: 14),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   color: color.withOpacity(0.9),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: color.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(
                  0.15,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: color,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
                color: color,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              title,
              textAlign:
                  TextAlign.center,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color:
                    Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}