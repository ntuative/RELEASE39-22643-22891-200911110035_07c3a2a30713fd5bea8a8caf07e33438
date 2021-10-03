package com.sulake.habbo.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      
      public static const const_665:String = "RWSDPM_SAVE_PRESET";
       
      
      private var _color:uint;
      
      private var var_1542:int;
      
      private var var_1543:int;
      
      private var var_1605:Boolean;
      
      private var var_878:int;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean)
      {
         super(const_665);
         var_1543 = param1;
         var_1542 = param2;
         _color = param3;
         var_878 = param4;
         var_1605 = param5;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get effectTypeId() : int
      {
         return var_1542;
      }
      
      public function get presetNumber() : int
      {
         return var_1543;
      }
      
      public function get brightness() : int
      {
         return var_878;
      }
      
      public function get apply() : Boolean
      {
         return var_1605;
      }
   }
}
