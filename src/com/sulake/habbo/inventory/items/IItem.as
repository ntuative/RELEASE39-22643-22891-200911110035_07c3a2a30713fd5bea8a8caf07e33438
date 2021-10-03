package com.sulake.habbo.inventory.items
{
   public interface IItem
   {
       
      
      function get locked() : Boolean;
      
      function get extras() : String;
      
      function get ref() : int;
      
      function set locked(param1:Boolean) : void;
      
      function get tradeable() : Boolean;
      
      function get groupable() : Boolean;
      
      function get type() : int;
      
      function get id() : int;
      
      function get recyclable() : Boolean;
      
      function get category() : int;
   }
}
