package com.sulake.habbo.avatar.animation
{
   import flash.geom.ColorTransform;
   
   public interface IAvatarDataContainer
   {
       
      
      function get greens() : Array;
      
      function get reds() : Array;
      
      function get paletteIsGrayscale() : Boolean;
      
      function get alphas() : Array;
      
      function get ink() : int;
      
      function get blues() : Array;
      
      function get colorTransform() : ColorTransform;
   }
}
