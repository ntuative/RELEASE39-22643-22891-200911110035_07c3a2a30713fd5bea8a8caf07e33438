package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FaqCategoriesMessageParser implements IMessageParser
   {
       
      
      private var _data:Map;
      
      public function FaqCategoriesMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         _data = new Map();
         var _loc6_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc2_ = new Map();
            _loc3_ = param1.readInteger();
            _loc4_ = param1.readString();
            _loc5_ = param1.readInteger();
            _loc2_.add("name",_loc4_);
            _loc2_.add("count",_loc5_);
            _data.add(_loc3_,_loc2_);
            _loc7_++;
         }
         return true;
      }
      
      public function get data() : Map
      {
         return _data;
      }
      
      public function flush() : Boolean
      {
         if(_data != null)
         {
            _data.dispose();
         }
         _data = null;
         return true;
      }
   }
}
