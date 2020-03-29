import 'package:flutter/material.dart';

/* Tabs are hard to style, I had to set them scrollable (I don't
 even using scrool on them!) and it allow to set them custom width. I can't
 use flex or something that get free space so I calculated width of each
 tab. Size is a part of free space eg 0.5 means that tab will get a half of space.
*/

const defaultTabPadding = 22;

getTabWidth(
    {BuildContext context,
    int tabPadding = defaultTabPadding,
    int numberOfTabs,
    double size}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final spaceTakenByPadding = numberOfTabs * 2 * tabPadding;
  final freeSpaceForTabs = screenWidth - spaceTakenByPadding;

  return freeSpaceForTabs * size;
}
