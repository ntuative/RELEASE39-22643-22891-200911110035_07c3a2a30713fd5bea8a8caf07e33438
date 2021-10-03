package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
   
   public class RoomChatlogMessageParser implements IMessageParser
   {
       
      
      private var _data:RoomChatlogData;
      
      public function RoomChatlogMessageParser()
      {
         super();
      }
      
      public function get data() : RoomChatlogData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new RoomChatlogData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
