package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.room.IRoomEngine;
   
   public interface IProductContainer
   {
       
      
      function activate() : void;
      
      function deActivate() : void;
      
      function dispose() : void;
      
      function initProductIcon(param1:IRoomEngine) : void;
      
      function set view(param1:IWindowContainer) : void;
      
      function get products() : Array;
      
      function set grid(param1:IItemGrid) : void;
      
      function get firstProduct() : IProduct;
   }
}
