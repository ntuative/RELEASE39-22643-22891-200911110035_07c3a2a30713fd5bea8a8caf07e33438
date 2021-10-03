package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public class CatalogViewer implements ICatalogViewer
   {
       
      
      private var _container:IWindowContainer;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_658:ICatalogPage;
      
      private var var_84:IHabboCatalog;
      
      public function CatalogViewer(param1:IHabboCatalog, param2:IWindowContainer, param3:IRoomEngine)
      {
         super();
         var_84 = param1;
         _container = param2;
         _roomEngine = param3;
      }
      
      public function getCurrentLayoutCode() : String
      {
         if(var_658 == null)
         {
            return "";
         }
         return var_658.layoutCode;
      }
      
      public function showCatalogPage(param1:int, param2:String, param3:IPageLocalization, param4:Array) : void
      {
         Logger.log("[Catalog Viewer] Show Catalog Page: " + [param1,param2,param4.length]);
         if(var_658 != null)
         {
            _container.removeChild(var_658.window);
            var_658.dispose();
         }
         var _loc5_:ICatalogPage = new CatalogPage(this,param1,param2,param3,param4);
         var_658 = _loc5_;
         if(_loc5_.window != null)
         {
            _container.addChild(_loc5_.window);
         }
         else
         {
            Logger.log("[CatalogViewer] No window for page: " + param2);
         }
         _container.visible = true;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return var_84;
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return var_658.dispatchWidgetEvent(param1);
      }
      
      public function dispose() : void
      {
      }
   }
}
