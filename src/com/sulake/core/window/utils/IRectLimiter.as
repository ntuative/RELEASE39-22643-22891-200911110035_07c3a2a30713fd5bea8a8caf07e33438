package com.sulake.core.window.utils
{
   public interface IRectLimiter
   {
       
      
      function set minHeight(param1:int) : void;
      
      function get maxWidth() : int;
      
      function set maxWidth(param1:int) : void;
      
      function get minWidth() : int;
      
      function set maxHeight(param1:int) : void;
      
      function set minWidth(param1:int) : void;
      
      function get minHeight() : int;
      
      function get isEmpty() : Boolean;
      
      function get maxHeight() : int;
      
      function setEmpty() : void;
   }
}
