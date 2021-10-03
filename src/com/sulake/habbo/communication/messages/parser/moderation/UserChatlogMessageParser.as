package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogData;
   
   public class UserChatlogMessageParser implements IMessageParser
   {
       
      
      private var _data:UserChatlogData;
      
      public function UserChatlogMessageParser()
      {
         super();
      }
      
      public function get data() : UserChatlogData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new UserChatlogData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
