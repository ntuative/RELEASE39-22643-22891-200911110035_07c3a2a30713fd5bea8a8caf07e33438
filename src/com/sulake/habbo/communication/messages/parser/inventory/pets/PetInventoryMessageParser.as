package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetInventoryMessageParser implements IMessageParser
   {
       
      
      private var var_876:Array;
      
      public function PetInventoryMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         var_876 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new PetData();
            _loc4_.id = param1.readInteger();
            _loc4_.name = param1.readString();
            _loc4_.figure = param1.readString();
            var_876.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_876 = [];
         return true;
      }
      
      public function get pets() : Array
      {
         return var_876;
      }
   }
}
