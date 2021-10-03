package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent
   {
      
      public static const const_340:String = "RSDPE_PRESETS";
       
      
      private var _selectedPresetId:int = 0;
      
      private var _presets:Array;
      
      public function RoomSessionDimmerPresetsEvent(param1:String, param2:IRoomSession, param3:Boolean = false, param4:Boolean = false)
      {
         _presets = new Array();
         super(param1,param2,param3,param4);
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
         var _loc5_:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(param1,param2,param3,param4);
         _presets[param1 - 1] = _loc5_;
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function getPreset(param1:int) : RoomSessionDimmerPresetsEventPresetItem
      {
         if(param1 < 0 || param1 >= _presets.count)
         {
            return null;
         }
         return _presets[param1];
      }
   }
}
