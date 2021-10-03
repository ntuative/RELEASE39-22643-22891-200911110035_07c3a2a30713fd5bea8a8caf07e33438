package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   public class PetData
   {
       
      
      private var var_828:String;
      
      private var _name:String;
      
      private var _id:int;
      
      public function PetData()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
      
      public function set figure(param1:String) : void
      {
         var_828 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}
