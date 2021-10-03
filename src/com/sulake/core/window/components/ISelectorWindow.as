package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   
   public interface ISelectorWindow extends IWindow
   {
       
      
      function addSelectable(param1:ISelectableWindow) : ISelectableWindow;
      
      function addSelectableAt(param1:ISelectableWindow, param2:int) : ISelectableWindow;
      
      function getSelectableIndex(param1:ISelectableWindow) : int;
      
      function getSelectableByName(param1:String) : ISelectableWindow;
      
      function get numSelectables() : uint;
      
      function getSelected() : ISelectableWindow;
      
      function getSelectableByTag(param1:String) : ISelectableWindow;
      
      function removeSelectable(param1:ISelectableWindow) : ISelectableWindow;
      
      function setSelected(param1:ISelectableWindow) : void;
      
      function getSelectableByID(param1:uint) : ISelectableWindow;
      
      function getSelectableAt(param1:int) : ISelectableWindow;
   }
}
