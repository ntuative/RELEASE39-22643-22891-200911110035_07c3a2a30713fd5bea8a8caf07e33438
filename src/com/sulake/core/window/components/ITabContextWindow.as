package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.utils.IIterable;
   
   public interface ITabContextWindow extends IWindow, IIterable
   {
       
      
      function getTabItemIndex(param1:ITabButtonWindow) : uint;
      
      function get numTabItems() : uint;
      
      function getTabItemByID(param1:uint) : ITabButtonWindow;
      
      function removeTabItem(param1:ITabButtonWindow) : void;
      
      function getTabItemAt(param1:uint) : ITabButtonWindow;
      
      function addTabItem(param1:ITabButtonWindow) : ITabButtonWindow;
      
      function get container() : IWindowContainer;
      
      function addTabItemAt(param1:ITabButtonWindow, param2:uint) : ITabButtonWindow;
      
      function getTabItemByName(param1:String) : ITabButtonWindow;
      
      function get selector() : ITabSelectorWindow;
   }
}
