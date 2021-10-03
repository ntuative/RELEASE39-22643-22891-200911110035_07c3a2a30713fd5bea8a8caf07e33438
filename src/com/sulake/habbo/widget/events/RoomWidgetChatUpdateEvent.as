package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetChatUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_98:int = 1;
      
      public static const const_130:int = 3;
      
      public static const const_671:String = "RWCUE_EVENT_CHAT";
      
      public static const const_95:int = 2;
      
      public static const const_121:int = 0;
       
      
      private var var_1499:int;
      
      private var var_197:String = "";
      
      private var var_1503:BitmapData;
      
      private var _userName:String;
      
      private var var_637:int = 0;
      
      private var var_1501:uint;
      
      private var _userId:int = 0;
      
      private var _roomCategory:int;
      
      private var var_1502:Number;
      
      private var var_1500:Number;
      
      private var _roomId:int;
      
      public function RoomWidgetChatUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:int, param6:Number, param7:Number, param8:BitmapData, param9:uint, param10:int, param11:int, param12:int = 0, param13:Boolean = false, param14:Boolean = false)
      {
         super(param1,param13,param14);
         _userId = param2;
         var_197 = param3;
         var_637 = param12;
         _userName = param4;
         var_1499 = param5;
         var_1502 = param6;
         var_1500 = param7;
         var_1503 = param8;
         var_1501 = param9;
         _roomId = param10;
         _roomCategory = param11;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get userImage() : BitmapData
      {
         return var_1503;
      }
      
      public function get text() : String
      {
         return var_197;
      }
      
      public function get userX() : Number
      {
         return var_1502;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userCategory() : int
      {
         return var_1499;
      }
      
      public function get chatType() : int
      {
         return var_637;
      }
      
      public function get userColor() : uint
      {
         return var_1501;
      }
      
      public function get userY() : Number
      {
         return var_1500;
      }
   }
}
