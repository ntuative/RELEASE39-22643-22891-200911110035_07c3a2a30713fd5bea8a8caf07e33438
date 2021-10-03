package com.sulake.habbo.inventory.purse
{
   public class Purse
   {
       
      
      private var var_2000:Boolean = false;
      
      private var var_1998:int = 0;
      
      private var var_1573:int = 0;
      
      private var var_1997:int = 0;
      
      private var var_1999:int = 0;
      
      private var var_1571:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function set creditBalance(param1:int) : void
      {
         var_1999 = Math.max(0,param1);
      }
      
      public function get clubPastPeriods() : int
      {
         return var_1998;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return var_2000;
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         var_2000 = param1;
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         var_1998 = Math.max(0,param1);
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1573 = Math.max(0,param1);
      }
      
      public function get creditBalance() : int
      {
         return var_1999;
      }
      
      public function set pixelBalance(param1:int) : void
      {
         var_1997 = Math.max(0,param1);
      }
      
      public function get clubDays() : int
      {
         return var_1573;
      }
      
      public function get pixelBalance() : int
      {
         return var_1997;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1571 = Math.max(0,param1);
      }
      
      public function get clubPeriods() : int
      {
         return var_1571;
      }
   }
}
