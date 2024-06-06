// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ColorsConfig {
  ColorsConfig._();

  /// p => Primary
  /// l => Light
  /// s => Secondary
  /// d => Dark

  // Main Application UI Colors
  static const p_l_color = Color(0xffD1D1D1);
  static const p_d_color = Colors.black;
  static const s_l_color = Colors.white;
  static const s_d_color = Colors.grey;

  static get p_color {
    return true ? p_l_color : p_d_color;
  }

  static get s_color {
    return true ? s_l_color : s_d_color;
  }


  //
  static const l_headingColor = Color(0xff06212e);
  static const d_headingColor = Colors.black;

  // Text Colors
  static const p_l_textColor = Colors.white;
  static const p_d_textColor = Colors.white;
  static const s_l_textColor = Colors.white;
  static const s_d_textColor = Colors.grey;
  static const captionColor = Colors.grey;
  static const deleteColor = Color(0xff690505);


  static get p_textColor {
    return true ? p_l_textColor : p_d_textColor;
  }

  static get s_textColor {
    return true ? s_l_textColor : s_d_textColor;
  }

  // Background Colors
  static const l_backgroundColor = Color(0xffffdb15);
  static const d_backgroundColor = Colors.grey;

  static get backgroundColor {
    return true ? l_backgroundColor : d_backgroundColor;
  }

  // Icon Colors
  static const l_s_iconColor = Colors.black;
  static const l_u_s_iconColor = Colors.black54;

  static const d_s_iconColor = Colors.white;
  static const d_u_s_iconColor = Colors.white;

  static get icon_s_color {
    return true ? l_s_iconColor : d_s_iconColor;
  }

  static get icon_u_s_color {
    return true ? l_u_s_iconColor : d_u_s_iconColor;
  }

  // Label Color
  static const l_labelColor = Colors.black;
  static const d_labelColor = Colors.white70;

  // Label Color
  static const l_hyperLinkColor = Colors.blue;
  static const d_hyperLinkColor = Colors.blue;


  // Border Colors
  static const p_l_borderColor = Colors.grey;
  static const p_d_borderColor = Colors.black;
  static const s_l_borderColor = Colors.black;
  static const s_d_borderColor = Colors.blue;

  static get p_borderColor {
    return true ? Color(0xffD1D1D1) : p_d_borderColor;
  }

  static get s_borderColor {
    return true ? s_l_borderColor : s_d_borderColor;
  }

  // Divider Colors
  static const l_dividerColor = Colors.black87;
  static const d_dividerColor = Colors.grey;

  static get dividerColor {
    return true ? l_dividerColor : d_dividerColor;
  }

  // overlapping Screens
  static const l_boxBackgroundColor = Colors.black;
  static const d_boxBackgroundColor = Colors.grey;
  static const l_boxTextColor = Colors.white;
  static const d_boxTextColor = Colors.white;

  // Buttons
  static const l_s_btn_backgroundColor = l_boxBackgroundColor;
  static const l_u_btn_backgroundColor = Colors.grey;
  static const d_s_btn_backgroundColor = Colors.white;
  static const d_u_btn_backgroundColor = Colors.white70;

  static get s_btn_backgroundColor {
    return true ? l_s_btn_backgroundColor : d_s_btn_backgroundColor;
  }

  static get u_btn_backgroundColor {
    return true ? l_u_btn_backgroundColor : d_u_btn_backgroundColor;
  }

  static const l_s_btn_textColor = Colors.white;
  static const l_u_btn_textColor = Colors.black;
  static const d_s_btn_textColor = Colors.black;
  static const d_u_btn_textColor = Colors.blue;

  static get s_btn_textColor {
    return true ? l_s_btn_textColor : d_s_btn_textColor;
  }

  static get u_btn_textColor {
    return true ? l_u_btn_textColor : d_u_btn_textColor;
  }

  // Tabs
  static const l_s_tab_backgroundColor = l_boxBackgroundColor;
  static const l_u_tab_backgroundColor = Colors.grey;
  static const d_s_tab_backgroundColor = Colors.white;
  static const d_u_tab_backgroundColor = Colors.white10;

  static get s_tab_backgroundColor {
    return true ? l_s_tab_backgroundColor : d_s_tab_backgroundColor;
  }

  static get u_tab_backgroundColor {
    return true ? l_u_tab_backgroundColor : d_u_tab_backgroundColor;
  }

  static const l_s_tab_textColor = Colors.white;
  static const l_u_tab_textColor = Colors.black;
  static const d_s_tab_textColor = Colors.black;
  static const d_u_tab_textColor = Colors.white;


  static get s_tab_textColor {
    return true ? l_s_tab_textColor : d_s_tab_textColor;
  }

  static get u_tab_textColor {
    return true ? l_u_tab_textColor : d_u_tab_textColor;
  }

  static get btn_backgroundColor {
    return true ? Color(0xffD1D1D1) : d_s_btn_backgroundColor;
  }

  static get btn_textColor {
    return true ? Color(0xffffffff) : d_s_btn_backgroundColor;
  }

  static get boxBackgroundColor {
    return true ? l_boxBackgroundColor : d_boxBackgroundColor;
  }

  static get boxTextColor {
    return true ? l_boxTextColor : d_boxTextColor;
  }

  static const Color danger = Color(0xffff3b30);
  static const Color success = Color(0xff63dc78);

}
