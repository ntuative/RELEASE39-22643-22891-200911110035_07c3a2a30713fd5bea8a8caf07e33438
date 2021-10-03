package com.sulake.habbo.communication.messages.incoming.sound
{
   public class PlayListEntry
   {
       
      
      private var var_1496:int;
      
      private var var_1495:int = 0;
      
      private var var_1494:String;
      
      private var var_1498:int;
      
      private var var_1497:String;
      
      public function PlayListEntry(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         var_1496 = param1;
         var_1498 = param2;
         var_1497 = param3;
         var_1494 = param4;
      }
      
      public function get length() : int
      {
         return var_1498;
      }
      
      public function get name() : String
      {
         return var_1497;
      }
      
      public function get creator() : String
      {
         return var_1494;
      }
      
      public function get startPlayHeadPos() : int
      {
         return var_1495;
      }
      
      public function get id() : int
      {
         return var_1496;
      }
      
      public function set startPlayHeadPos(param1:int) : void
      {
         var_1495 = param1;
      }
   }
}
