package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FurniListRemoveParser implements IMessageParser
   {
       
      
      private var var_1052:int;
      
      public function FurniListRemoveParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1052 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get stripId() : int
      {
         return var_1052;
      }
   }
}
