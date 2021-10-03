package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomReadyMessageParser implements IMessageParser
   {
       
      
      private var var_996:String = "";
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function RoomReadyMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_996 = "";
         _roomId = 0;
         _roomCategory = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_996 = param1.readString();
         _roomId = param1.readInteger();
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get roomType() : String
      {
         return var_996;
      }
   }
}
