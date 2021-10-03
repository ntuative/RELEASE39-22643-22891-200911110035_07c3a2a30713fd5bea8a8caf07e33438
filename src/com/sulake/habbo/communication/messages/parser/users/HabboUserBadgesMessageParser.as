package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class HabboUserBadgesMessageParser implements IMessageParser
   {
       
      
      private var _userId:int;
      
      private var var_164:Array;
      
      public function HabboUserBadgesMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         _userId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readString();
            var_164.push(_loc5_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _userId = -1;
         var_164 = [];
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get badges() : Array
      {
         return var_164;
      }
   }
}
