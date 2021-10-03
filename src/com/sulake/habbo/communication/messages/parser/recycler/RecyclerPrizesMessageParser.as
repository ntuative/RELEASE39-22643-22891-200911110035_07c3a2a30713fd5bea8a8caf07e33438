package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
   
   public class RecyclerPrizesMessageParser implements IMessageParser
   {
       
      
      private var var_1435:Array;
      
      public function RecyclerPrizesMessageParser()
      {
         super();
      }
      
      public function get prizeLevels() : Array
      {
         return var_1435;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var_1435 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_1435.push(new PrizeLevelMessageData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
