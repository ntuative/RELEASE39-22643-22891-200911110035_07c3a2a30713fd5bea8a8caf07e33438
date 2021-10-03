package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class IssueDeletedMessageParser implements IMessageParser
   {
       
      
      private var var_1650:int;
      
      public function IssueDeletedMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1650 = parseInt(param1.readString());
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get issueId() : int
      {
         return var_1650;
      }
   }
}
