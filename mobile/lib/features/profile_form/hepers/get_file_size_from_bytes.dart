import 'dart:math';

String getFileSizeFromBytes(int bytes) =>
    (bytes / pow(1024, 2)).toStringAsFixed(2) + ' MB';
