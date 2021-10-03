package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   
   public interface ITabView
   {
       
      
      function init(param1:HabboFriendList) : void;
      
      function fillList(param1:IItemListWindow) : void;
      
      function tabClicked(param1:int) : void;
      
      function getEntryCount() : int;
      
      function fillFooter(param1:IWindowContainer) : void;
   }
}
