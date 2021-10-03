package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FlatCatMessageParser implements IMessageParser
   {
       
      
      private var var_372:int;
      
      private var var_1049:int;
      
      public function FlatCatMessageParser()
      {
         super();
      }
      
      public function get flatId() : int
      {
         return var_372;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_372 = param1.readInteger();
         var_1049 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_372 = 0;
         var_1049 = 0;
         return true;
      }
      
      public function get nodeId() : int
      {
         return var_1049;
      }
   }
}
