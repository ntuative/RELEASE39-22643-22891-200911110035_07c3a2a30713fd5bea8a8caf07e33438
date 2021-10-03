package com.sulake.room.renderer
{
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.DisplayObject;
   
   public interface IRoomRenderingCanvas
   {
       
      
      function initialize(param1:int, param2:int) : void;
      
      function get displayObject() : DisplayObject;
      
      function get geometry() : IRoomGeometry;
      
      function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean;
      
      function render(param1:int) : void;
      
      function get height() : int;
      
      function set mouseListener(param1:IRoomRenderingCanvasMouseListener) : void;
      
      function get width() : int;
   }
}
