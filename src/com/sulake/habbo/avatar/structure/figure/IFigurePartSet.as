package com.sulake.habbo.avatar.structure.figure
{
   public interface IFigurePartSet
   {
       
      
      function get isSelectable() : Boolean;
      
      function get gender() : String;
      
      function get isColorable() : Boolean;
      
      function get isClub() : Boolean;
      
      function getPart(param1:String, param2:int) : IFigurePart;
      
      function get id() : int;
      
      function get hiddenLayers() : Array;
      
      function get parts() : Array;
   }
}
