package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   
   public class AchievementsMessageParser implements IMessageParser
   {
       
      
      private var var_327:Array;
      
      public function AchievementsMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         var_327 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new AchievementData();
            _loc4_.type = param1.readInteger();
            _loc4_.level = param1.readInteger();
            _loc4_.badgeId = param1.readString();
            var_327.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_327 = new Array();
         return true;
      }
      
      public function get achievements() : Array
      {
         return var_327;
      }
   }
}
