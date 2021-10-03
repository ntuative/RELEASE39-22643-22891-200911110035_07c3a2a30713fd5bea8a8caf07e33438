package com.sulake.habbo.avatar.animation
{
   public interface ISpriteDataContainer
   {
       
      
      function get animation() : IAnimation;
      
      function getDirectionOffsetZ(param1:int) : int;
      
      function get ink() : int;
      
      function get member() : String;
      
      function get id() : String;
      
      function getDirectionOffsetX(param1:int) : int;
      
      function getDirectionOffsetY(param1:int) : int;
      
      function get hasDirections() : Boolean;
   }
}
