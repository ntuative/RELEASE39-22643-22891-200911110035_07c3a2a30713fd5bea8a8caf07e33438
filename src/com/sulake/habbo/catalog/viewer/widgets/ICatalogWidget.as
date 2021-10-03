package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import flash.events.IEventDispatcher;
   
   public interface ICatalogWidget
   {
       
      
      function get window() : IWindowContainer;
      
      function set events(param1:IEventDispatcher) : void;
      
      function get page() : ICatalogPage;
      
      function init() : void;
      
      function get events() : IEventDispatcher;
      
      function set page(param1:ICatalogPage) : void;
      
      function dispose() : void;
   }
}
