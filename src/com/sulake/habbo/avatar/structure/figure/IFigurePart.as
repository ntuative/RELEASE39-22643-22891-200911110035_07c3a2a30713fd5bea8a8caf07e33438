package com.sulake.habbo.avatar.structure.figure
{
   public interface IFigurePart
   {
       
      
      function get paletteMap() : int;
      
      function get index() : int;
      
      function get isColorable() : Boolean;
      
      function get type() : String;
      
      function get id() : int;
   }
}
