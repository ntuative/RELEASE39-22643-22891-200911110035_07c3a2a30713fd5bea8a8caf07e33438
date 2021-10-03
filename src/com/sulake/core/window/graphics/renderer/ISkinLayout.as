package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.utils.IChildEntityArray;
   import com.sulake.core.window.utils.IChildEntityArrayReader;
   import flash.geom.Rectangle;
   
   public interface ISkinLayout extends IChildEntityArray
   {
       
      
      function get placeholders() : IChildEntityArrayReader;
      
      function isFixedHeight() : Boolean;
      
      function get transparent() : Boolean;
      
      function get width() : uint;
      
      function get height() : uint;
      
      function get name() : String;
      
      function isFixedWidth() : Boolean;
      
      function getDefaultRegion(param1:String, param2:Rectangle) : void;
      
      function dispose() : void;
   }
}
