package com.sulake.habbo.avatar.structure.figure
{
   import flash.utils.Dictionary;
   
   public interface ISetType
   {
       
      
      function get partSets() : Dictionary;
      
      function get paletteID() : int;
      
      function getPartSet(param1:int) : IFigurePartSet;
      
      function get type() : String;
      
      function get isMandatory() : Boolean;
   }
}
