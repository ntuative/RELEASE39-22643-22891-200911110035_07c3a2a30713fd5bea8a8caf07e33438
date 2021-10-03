package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   public class AchievementData
   {
       
      
      private var var_1624:int;
      
      private var _type:int;
      
      private var var_1188:String;
      
      public function AchievementData()
      {
         super();
      }
      
      public function get level() : int
      {
         return var_1624;
      }
      
      public function set level(param1:int) : void
      {
         var_1624 = param1;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set badgeId(param1:String) : void
      {
         var_1188 = param1;
      }
      
      public function get badgeId() : String
      {
         return var_1188;
      }
   }
}
