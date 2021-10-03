package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogData;
   
   public class CfhChatlogMessageParser implements IMessageParser
   {
       
      
      private var _data:CfhChatlogData;
      
      public function CfhChatlogMessageParser()
      {
         super();
      }
      
      public function get data() : CfhChatlogData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new CfhChatlogData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
