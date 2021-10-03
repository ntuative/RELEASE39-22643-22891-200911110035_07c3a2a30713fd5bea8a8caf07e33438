package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
   
   public class ModeratorUserInfoMessageParser implements IMessageParser
   {
       
      
      private var _data:ModeratorUserInfoData;
      
      public function ModeratorUserInfoMessageParser()
      {
         super();
      }
      
      public function get data() : ModeratorUserInfoData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new ModeratorUserInfoData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
