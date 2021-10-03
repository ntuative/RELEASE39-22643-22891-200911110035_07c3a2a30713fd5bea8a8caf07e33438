package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   
   public interface IInteractiveWindow extends IWindow
   {
       
      
      function set toolTipDelay(param1:uint) : void;
      
      function setMouseCursorByState(param1:uint, param2:uint) : void;
      
      function get toolTipCaption() : String;
      
      function get mouseCursorType() : uint;
      
      function set toolTipCaption(param1:String) : void;
      
      function get toolTipDelay() : uint;
      
      function hideToolTip() : void;
      
      function set mouseCursorType(param1:uint) : void;
      
      function getMouseCursorByState(param1:uint) : uint;
      
      function showToolTip(param1:IToolTipWindow) : void;
   }
}
