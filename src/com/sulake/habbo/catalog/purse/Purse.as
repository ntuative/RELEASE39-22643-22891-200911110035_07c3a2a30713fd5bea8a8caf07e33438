package com.sulake.habbo.catalog.purse
{
   public class Purse implements IPurse
   {
       
      
      private var var_1573:int = 0;
      
      private var var_1570:int = 0;
      
      private var var_1572:int = 0;
      
      private var var_1571:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function get pixels() : int
      {
         return var_1570;
      }
      
      public function set pixels(param1:int) : void
      {
         var_1570 = param1;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1573 = param1;
      }
      
      public function get credits() : int
      {
         return var_1572;
      }
      
      public function get clubDays() : int
      {
         return var_1573;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1571 = param1;
      }
      
      public function set credits(param1:int) : void
      {
         var_1572 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return var_1571;
      }
   }
}
