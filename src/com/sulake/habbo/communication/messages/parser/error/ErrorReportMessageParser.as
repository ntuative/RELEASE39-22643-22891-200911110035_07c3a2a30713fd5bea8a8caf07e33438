package com.sulake.habbo.communication.messages.parser.error
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ErrorReportMessageParser implements IMessageParser
   {
       
      
      private var var_1087:int;
      
      private var var_983:int;
      
      private var var_1086:String;
      
      public function ErrorReportMessageParser()
      {
         super();
      }
      
      public function get messageId() : int
      {
         return var_1087;
      }
      
      public function flush() : Boolean
      {
         var_983 = 0;
         var_1087 = 0;
         var_1086 = null;
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_983;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_983 = param1.readInteger();
         var_1087 = param1.readInteger();
         var_1086 = param1.readString();
         return true;
      }
      
      public function get timestamp() : String
      {
         return var_1086;
      }
   }
}
