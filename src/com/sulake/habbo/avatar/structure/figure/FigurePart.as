package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePart implements IFigurePart
   {
       
      
      private var _id:int;
      
      private var var_1623:int = -1;
      
      private var var_1619:Boolean;
      
      private var _type:String;
      
      private var _index:int;
      
      public function FigurePart(param1:XML)
      {
         super();
         _id = parseInt(param1.@id);
         _type = String(param1.@type);
         _index = parseInt(param1.@index);
         var_1619 = Boolean(parseInt(param1.@colorable));
         var _loc2_:String = param1.@palettemapid;
         if(_loc2_ != "")
         {
            var_1623 = int(_loc2_);
         }
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get isColorable() : Boolean
      {
         return var_1619;
      }
      
      public function get paletteMap() : int
      {
         return var_1623;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}
