package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomSettingsSavedMessageParser implements IMessageParser
   {
       
      
      private var _roomId:int;
      
      public function RoomSettingsSavedMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
