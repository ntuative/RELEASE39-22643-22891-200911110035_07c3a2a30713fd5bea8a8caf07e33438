package com.sulake.habbo.widget.messages
{
   public class RoomWidgetFurniToWidgetMessage extends RoomWidgetMessage
   {
      
      public static const const_555:String = "RWFWM_MESSAGE_REQUEST_CREDITFURNI";
      
      public static const const_501:String = "RWFWM_MESSAGE_REQUEST_ECOTRONBOX";
      
      public static const const_599:String = "RWFWM_MESSAGE_REQUEST_PRESENT";
      
      public static const const_672:String = "RWFWM_MESSAGE_REQUEST_DIMMER";
      
      public static const const_567:String = "RWFWM_MESSAGE_REQUEST_TROPHY";
      
      public static const const_856:String = "RWFWM_MESSAGE_REQUEST_PLACEHOLDER";
      
      public static const const_508:String = "RWFWM_MESSAGE_REQUEST_STICKIE";
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      public function RoomWidgetFurniToWidgetMessage(param1:String, param2:int, param3:int, param4:int, param5:int)
      {
         super(param1);
         _id = param2;
         _category = param3;
         _roomId = param4;
         _roomCategory = param5;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
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
