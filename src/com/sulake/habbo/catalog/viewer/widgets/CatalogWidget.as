package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import flash.events.IEventDispatcher;
   
   public class CatalogWidget
   {
       
      
      private var var_658:ICatalogPage;
      
      protected var _window:IWindowContainer;
      
      private var name_1:IEventDispatcher;
      
      public function CatalogWidget(param1:IWindowContainer)
      {
         super();
         _window = param1;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         var_658 = param1;
      }
      
      public function init() : void
      {
      }
      
      public function get page() : ICatalogPage
      {
         return var_658;
      }
      
      public function set events(param1:IEventDispatcher) : void
      {
         name_1 = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function dispose() : void
      {
         name_1 = null;
      }
   }
}
