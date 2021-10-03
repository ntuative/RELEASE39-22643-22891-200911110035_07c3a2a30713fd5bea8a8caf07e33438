package com.sulake.habbo.widget.messages
{
   public class RoomWidgetRoomObjectMessage extends RoomWidgetMessage
   {
      
      public static const const_682:String = "RWROM_SELECT_OBJECT";
      
      public static const const_266:String = "RWROM_GET_OBJECT_INFO";
       
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      public function RoomWidgetRoomObjectMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         _id = param2;
         _category = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
   }
}
