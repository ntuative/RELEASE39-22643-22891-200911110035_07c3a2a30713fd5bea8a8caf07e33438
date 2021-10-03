package com.sulake.habbo.avatar.structure.parts
{
   public class PartDefinition
   {
       
      
      private var _removeSetType:String;
      
      private var var_1344:int = -1;
      
      private var var_1090:Boolean;
      
      private var var_1091:String;
      
      private var var_1749:String;
      
      public function PartDefinition(param1:XML)
      {
         super();
         var_1749 = String(param1["set-type"]);
         var_1091 = String(param1["flipped-set-type"]);
         _removeSetType = String(param1["remove-set-type"]);
         var_1090 = false;
      }
      
      public function hasStaticId() : Boolean
      {
         return var_1344 >= 0;
      }
      
      public function get flippedSetType() : String
      {
         return var_1091;
      }
      
      public function get staticId() : int
      {
         return var_1344;
      }
      
      public function set staticId(param1:int) : void
      {
         var_1344 = param1;
      }
      
      public function get appendToFigure() : Boolean
      {
         return var_1090;
      }
      
      public function set appendToFigure(param1:Boolean) : void
      {
         var_1090 = param1;
      }
      
      public function set flippedSetType(param1:String) : void
      {
         var_1091 = param1;
      }
      
      public function get setType() : String
      {
         return var_1749;
      }
      
      public function get removeSetType() : String
      {
         return _removeSetType;
      }
   }
}
