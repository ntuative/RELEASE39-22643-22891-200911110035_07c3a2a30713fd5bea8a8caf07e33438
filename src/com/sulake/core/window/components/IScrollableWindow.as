package com.sulake.core.window.components
{
   import com.sulake.core.runtime.IDisposable;
   import flash.geom.Rectangle;
   
   public interface IScrollableWindow extends IDisposable
   {
       
      
      function get scrollH() : Number;
      
      function get maxScrollV() : int;
      
      function get visibleRegion() : Rectangle;
      
      function get scrollV() : Number;
      
      function get scrollStepH() : Number;
      
      function set scrollV(param1:Number) : void;
      
      function set scrollH(param1:Number) : void;
      
      function get maxScrollH() : int;
      
      function set scrollStepV(param1:Number) : void;
      
      function get scrollableRegion() : Rectangle;
      
      function get scrollStepV() : Number;
      
      function set scrollStepH(param1:Number) : void;
   }
}
