package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FaqCategoryMessageParser implements IMessageParser
   {
       
      
      private var _data:Map;
      
      private var var_1165:int;
      
      private var var_1011:String;
      
      public function FaqCategoryMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _data = new Map();
         var_1165 = param1.readInteger();
         var_1011 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = param1.readInteger();
            _loc4_ = param1.readString();
            _data.add(_loc3_,_loc4_);
            _loc5_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         if(_data != null)
         {
            _data.dispose();
         }
         _data = null;
         var_1165 = -1;
         var_1011 = null;
         return true;
      }
      
      public function get data() : Map
      {
         return _data;
      }
      
      public function get categoryId() : int
      {
         return var_1165;
      }
      
      public function get description() : String
      {
         return var_1011;
      }
   }
}
