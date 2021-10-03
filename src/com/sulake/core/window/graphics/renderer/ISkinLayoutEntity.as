package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.utils.IChildEntity;
   import flash.geom.Rectangle;
   
   public interface ISkinLayoutEntity extends IChildEntity
   {
       
      
      function get blend() : uint;
      
      function get color() : uint;
      
      function get region() : Rectangle;
      
      function get scaleV() : uint;
      
      function get scaleH() : uint;
      
      function dispose() : void;
   }
}
