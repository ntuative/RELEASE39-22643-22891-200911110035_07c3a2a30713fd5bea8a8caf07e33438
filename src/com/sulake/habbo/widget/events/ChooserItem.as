package com.sulake.habbo.widget.events
{
   public class ChooserItem
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var _category:int;
      
      public function ChooserItem(param1:int, param2:int, param3:String)
      {
         super();
         _id = param1;
         _category = param2;
         _name = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get category() : int
      {
         return _category;
      }
   }
}
