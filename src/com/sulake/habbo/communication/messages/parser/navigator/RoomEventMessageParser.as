package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   
   public class RoomEventMessageParser implements IMessageParser
   {
       
      
      private var _data:RoomEventData;
      
      public function RoomEventMessageParser()
      {
         super();
      }
      
      public function get data() : RoomEventData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._data = new RoomEventData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
