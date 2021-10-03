package com.sulake.core.window.components
{
   public interface ITextFieldWindow extends ITextWindow, IFocusWindow, IInteractiveWindow
   {
       
      
      function setSelection(param1:int, param2:int) : void;
      
      function get selectionEndIndex() : int;
      
      function get selectionBeginIndex() : int;
   }
}
