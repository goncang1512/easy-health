import 'package:easyhealth/models/docter_model.dart';
import 'package:flutter/material.dart';

class DocterProfile extends StatelessWidget {
  final DocterModel? docter;
  const DocterProfile({super.key, this.docter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // lingkaran
              border: Border.all(
                color: Colors.grey, // warna border
                width: 0.5, // ketebalan border
              ),
            ),

            child: ClipOval(
              child: Image.network(
                docter?.photoUrl ??
                    "https://i.pinimg.com/736x/51/6b/27/516b27678c97b8a5cfd5fe92c3dae7ed.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docter?.name ?? "uknown",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  docter?.specialits ?? "tidak terdaftar",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        docter?.hospital?.name ?? "uknown",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
