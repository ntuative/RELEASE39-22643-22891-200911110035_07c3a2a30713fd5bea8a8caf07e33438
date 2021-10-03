package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomSettingsSaveErrorMessageParser implements IMessageParser
   {
      
      public static const const_1448:int = 9;
      
      public static const const_1480:int = 4;
      
      public static const const_1478:int = 1;
      
      public static const const_1065:int = 10;
      
      public static const const_1380:int = 2;
      
      public static const const_1269:int = 7;
      
      public static const const_1230:int = 11;
      
      public static const const_1393:int = 3;
      
      public static const const_1254:int = 8;
      
      public static const const_1180:int = 5;
      
      public static const const_1424:int = 6;
      
      public static const const_1085:int = 12;
       
      
      private var var_1594:String;
      
      private var _roomId:int;
      
      private var var_983:int;
      
      public function RoomSettingsSaveErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get info() : String
      {
         return var_1594;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         var_983 = param1.readInteger();
         var_1594 = param1.readString();
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_983;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
