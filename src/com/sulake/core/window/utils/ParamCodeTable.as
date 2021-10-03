package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowParam;
   import flash.utils.Dictionary;
   
   public class ParamCodeTable extends WindowParam
   {
       
      
      public function ParamCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["HabboWindowManagerCom_habbo_skin_button_tab_white_xml"] = const_94;
         param1["bound_to_parent_rect"] = const_81;
         param1["child_window"] = const_886;
         param1["embedded_controller"] = const_290;
         param1["resize_to_accommodate_children"] = const_54;
         param1["input_event_processor"] = const_43;
         param1["internal_event_handling"] = const_584;
         param1["mouse_dragging_target"] = const_175;
         param1["mouse_dragging_trigger"] = const_302;
         param1["mouse_scaling_target"] = const_221;
         param1["mouse_scaling_trigger"] = const_404;
         param1["horizontal_mouse_scaling_trigger"] = const_182;
         param1["vertical_mouse_scaling_trigger"] = const_204;
         param1["observe_parent_input_events"] = const_778;
         param1["optimize_region_to_layout_size"] = const_430;
         param1["parent_window"] = const_751;
         param1["relative_horizontal_scale_center"] = const_162;
         param1["relative_horizontal_scale_fixed"] = const_115;
         param1["relative_horizontal_scale_move"] = const_268;
         param1["relative_horizontal_scale_strech"] = const_218;
         param1["relative_scale_center"] = const_904;
         param1["relative_scale_fixed"] = const_527;
         param1["relative_scale_move"] = const_857;
         param1["relative_scale_strech"] = const_764;
         param1["relative_vertical_scale_center"] = const_157;
         param1["relative_vertical_scale_fixed"] = const_100;
         param1["relative_vertical_scale_move"] = const_279;
         param1["relative_vertical_scale_strech"] = const_247;
         param1["on_resize_align_left"] = const_620;
         param1["on_resize_align_right"] = const_360;
         param1["on_resize_align_center"] = const_402;
         param1["on_resize_align_top"] = const_580;
         param1["on_resize_align_bottom"] = const_445;
         param1["on_resize_align_middle"] = const_439;
         param1["on_accommodate_align_left"] = const_750;
         param1["on_accommodate_align_right"] = const_344;
         param1["on_accommodate_align_center"] = const_528;
         param1["on_accommodate_align_top"] = const_949;
         param1["on_accommodate_align_bottom"] = WINDOW_PARAM_ON_ACCOMMODATE_ALIGN_BOTTOM;
         param1["on_accommodate_align_middle"] = const_603;
         param1["route_input_events_to_parent"] = const_341;
         param1["use_parent_graphic_context"] = const_32;
         param1["draggable_with_mouse"] = const_793;
         param1["scalable_with_mouse"] = const_893;
         param1["reflect_horizontal_resize_to_parent"] = const_449;
         param1["reflect_vertical_resize_to_parent"] = const_375;
         param1["reflect_resize_to_parent"] = const_215;
         if(param2 != null)
         {
            for(_loc3_ in param1)
            {
               if(param2[param1[_loc3_]] != null)
               {
                  if(param1[_loc3_] != 0)
                  {
                     Logger.log("Conflictiong flags in window params: \"" + _loc3_ + "\"!");
                  }
               }
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}
