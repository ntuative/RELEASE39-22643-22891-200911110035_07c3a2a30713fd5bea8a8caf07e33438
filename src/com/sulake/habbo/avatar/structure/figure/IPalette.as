package com.sulake.habbo.avatar.structure.figure
{
   import flash.utils.Dictionary;
   
   public interface IPalette
   {
       
      
      function get colors() : Dictionary;
      
      function get id() : int;
      
      function getColor(param1:int) : IPartColor;
   }
}
