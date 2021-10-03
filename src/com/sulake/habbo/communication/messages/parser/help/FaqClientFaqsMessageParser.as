package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FaqClientFaqsMessageParser implements IMessageParser
   {
       
      
      private var var_553:Map;
      
      private var var_554:Map;
      
      public function FaqClientFaqsMessageParser()
      {
         super();
      }
      
      public function get normalData() : Map
      {
         return var_553;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var_554 = new Map();
         var_553 = new Map();
         _loc5_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            var_554.add(_loc2_,_loc3_);
            _loc4_++;
         }
         _loc5_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            var_553.add(_loc2_,_loc3_);
            _loc4_++;
         }
         return true;
      }
      
      public function get urgentData() : Map
      {
         return var_554;
      }
      
      public function flush() : Boolean
      {
         if(var_554 != null)
         {
            var_554.dispose();
         }
         var_554 = null;
         if(var_553 != null)
         {
            var_553.dispose();
         }
         var_553 = null;
         return true;
      }
   }
}
