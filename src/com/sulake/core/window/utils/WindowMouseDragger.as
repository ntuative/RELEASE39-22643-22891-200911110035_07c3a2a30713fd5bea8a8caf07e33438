package com.sulake.core.window.utils
{
   import flash.display.DisplayObject;
   
   public class WindowMouseDragger extends WindowMouseOperator implements IWindowMouseDraggingService
   {
       
      
      public function WindowMouseDragger(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         _mouse.x = param1;
         _mouse.y = param2;
         getMousePositionRelativeTo(_window,_mouse,var_472);
         _window.offset(0 - 0,0 - 0);
      }
   }
}
