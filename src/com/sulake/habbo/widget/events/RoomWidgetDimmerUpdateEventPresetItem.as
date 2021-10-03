package com.sulake.habbo.widget.events
{
   public class RoomWidgetDimmerUpdateEventPresetItem
   {
       
      
      private var _id:int = 0;
      
      private var _color:uint = 0;
      
      private var var_1213:uint = 0;
      
      private var _type:int = 0;
      
      public function RoomWidgetDimmerUpdateEventPresetItem(param1:int, param2:int, param3:uint, param4:uint)
      {
         super();
         _id = param1;
         _type = param2;
         _color = param3;
         var_1213 = param4;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get light() : int
      {
         return var_1213;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
