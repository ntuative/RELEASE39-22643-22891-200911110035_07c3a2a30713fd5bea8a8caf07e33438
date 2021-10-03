package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FaqSearchResultsMessageParser implements IMessageParser
   {
       
      
      private var _data:Map;
      
      public function FaqSearchResultsMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _data = new Map();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            _data.add(_loc2_,_loc3_);
            _loc5_++;
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
