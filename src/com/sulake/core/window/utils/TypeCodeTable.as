package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class TypeCodeTable extends WindowType
   {
       
      
      public function TypeCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["background"] = const_516;
         param1["bitmap"] = const_690;
         param1["border"] = const_689;
         param1["border_notify"] = const_1149;
         param1["button"] = const_446;
         param1["button_thick"] = const_495;
         param1["button_icon"] = const_1138;
         param1["button_group_left"] = const_587;
         param1["button_group_center"] = const_608;
         param1["button_group_right"] = const_681;
         param1["canvas"] = const_666;
         param1["checkbox"] = const_531;
         param1["closebutton"] = const_941;
         param1["container"] = const_272;
         param1["container_button"] = const_661;
         param1["display_object_wrapper"] = const_535;
         param1["dropmenu"] = const_366;
         param1["dropmenu_item"] = const_454;
         param1["frame"] = const_314;
         param1["frame_notify"] = const_1123;
         param1["header"] = const_677;
         param1["icon"] = const_900;
         param1["itemgrid"] = const_763;
         param1["itemgrid_horizontal"] = const_435;
         param1["itemgrid_vertical"] = const_591;
         param1["itemlist"] = const_780;
         param1["itemlist_horizontal"] = const_292;
         param1["itemlist_vertical"] = const_285;
         param1["maximizebox"] = const_1075;
         param1["menu"] = const_1155;
         param1["menu_item"] = WINDOW_TYPE_MENU_ITEM;
         param1["submenu"] = const_910;
         param1["minimizebox"] = const_1118;
         param1["notify"] = const_1121;
         param1["HabboWindowManagerCom_habbo_skin_button_tab_white_xml"] = const_447;
         param1["password"] = const_636;
         param1["radiobutton"] = const_507;
         param1["region"] = const_380;
         param1["restorebox"] = const_1223;
         param1["scaler"] = const_925;
         param1["scaler_horizontal"] = const_1139;
         param1["scaler_vertical"] = const_1219;
         param1["scrollbar_horizontal"] = const_433;
         param1["scrollbar_vertical"] = const_585;
         param1["scrollbar_slider_button_up"] = const_806;
         param1["scrollbar_slider_button_down"] = const_801;
         param1["scrollbar_slider_button_left"] = const_948;
         param1["scrollbar_slider_button_right"] = const_795;
         param1["scrollbar_slider_bar_horizontal"] = const_759;
         param1["scrollbar_slider_bar_vertical"] = const_854;
         param1["scrollbar_slider_track_horizontal"] = const_863;
         param1["scrollbar_slider_track_vertical"] = const_733;
         param1["scrollable_itemlist"] = const_1083;
         param1["scrollable_itemlist_vertical"] = const_349;
         param1["scrollable_itemlist_horizontal"] = const_819;
         param1["selector"] = const_632;
         param1["selector_list"] = const_490;
         param1["submenu"] = const_910;
         param1["tab_button"] = const_673;
         param1["tab_container_button"] = const_802;
         param1["tab_context"] = const_336;
         param1["tab_content"] = const_846;
         param1["tab_selector"] = WINDOW_TYPE_TAB_SELECTOR;
         param1["text"] = const_577;
         param1["input"] = const_645;
         param1["toolbar"] = const_1196;
         param1["tooltip"] = const_301;
         if(param2 != null)
         {
            for(_loc3_ in param1)
            {
               if(param2[param1[_loc3_]] != null)
               {
                  Logger.log("Overlapping window type code " + _loc3_ + "!");
               }
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}
