package com.sulake.habbo.avatar.structure.figure
{
   import flash.geom.ColorTransform;
   
   public interface IPartColor
   {
       
      
      function get isSelectable() : Boolean;
      
      function get index() : int;
      
      function get b() : uint;
      
      function get greenMultiplier() : Number;
      
      function get g() : uint;
      
      function get colorTransform() : ColorTransform;
      
      function get blueMultiplier() : Number;
      
      function get rgb() : uint;
      
      function get r() : uint;
      
      function get club() : int;
      
      function get redMultiplier() : Number;
      
      function get id() : int;
   }
}
