package com.sulake.habbo.widget.events
{
   public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_898:String = "RWDUE_HIDE";
      
      public static const const_576:String = "RWDUE_PRESETS";
       
      
      private var _selectedPresetId:int = 0;
      
      private var _presets:Array;
      
      public function RoomWidgetDimmerUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         _presets = new Array();
         super(param1,param2,param3);
      }
      
      public function get presetCount() : int
      {
         return _presets.length;
      }
      
      public function set selectedPresetId(param1:int) : void
      {
         _selectedPresetId = param1;
      }
      
      public function storePreset(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(param1,param2,param3,param4);
         _presets[param1 - 1] = _loc5_;
      }
      
      public function get presets() : Array
      {
         return _presets;
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function getPreset(param1:int) : RoomWidgetDimmerUpdateEventPresetItem
      {
         if(param1 < 0 || param1 >= _presets.count)
         {
            return null;
         }
         return _presets[param1];
      }
   }
}
