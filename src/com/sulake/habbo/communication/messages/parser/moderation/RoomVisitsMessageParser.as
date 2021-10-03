package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
   
   public class RoomVisitsMessageParser implements IMessageParser
   {
       
      
      private var _data:RoomVisitsData;
      
      public function RoomVisitsMessageParser()
      {
         super();
      }
      
      public function get data() : RoomVisitsData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new RoomVisitsData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
