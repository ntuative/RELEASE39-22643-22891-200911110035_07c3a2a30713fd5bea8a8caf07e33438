package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CallForHelpReplyMessageParser implements IMessageParser
   {
       
      
      private var _message:String;
      
      public function CallForHelpReplyMessageParser()
      {
         super();
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _message = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         _message = null;
         return true;
      }
   }
}
