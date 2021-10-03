package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FurnitureAliasesMessageParser implements IMessageParser
   {
       
      
      private var var_474:Map = null;
      
      public function FurnitureAliasesMessageParser()
      {
         super();
         var_474 = new Map();
      }
      
      public function getName(param1:int) : String
      {
         if(param1 < 0 || param1 >= aliasCount)
         {
            return null;
         }
         return var_474.getKey(param1);
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var_474.reset();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readString();
            _loc5_ = param1.readString();
            var_474.remove(_loc4_);
            var_474.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_474.reset();
         return true;
      }
      
      public function getAlias(param1:int) : String
      {
         if(param1 < 0 || param1 >= aliasCount)
         {
            return null;
         }
         return var_474.getWithIndex(param1);
      }
      
      public function get aliasCount() : int
      {
         return var_474.length;
      }
   }
}
