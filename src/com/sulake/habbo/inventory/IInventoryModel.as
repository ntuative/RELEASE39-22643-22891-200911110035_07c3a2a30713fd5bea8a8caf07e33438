package com.sulake.habbo.inventory
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   
   public interface IInventoryModel extends IDisposable
   {
       
      
      function subCategorySwitch(param1:String) : void;
      
      function categorySwitch(param1:String) : void;
      
      function getWindowContainer() : IWindowContainer;
      
      function closingInventoryView() : void;
      
      function requestInitialization(param1:int = 0) : void;
   }
}
