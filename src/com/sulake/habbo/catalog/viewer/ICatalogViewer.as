package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public interface ICatalogViewer
   {
       
      
      function get catalog() : IHabboCatalog;
      
      function getCurrentLayoutCode() : String;
      
      function showCatalogPage(param1:int, param2:String, param3:IPageLocalization, param4:Array) : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get roomEngine() : IRoomEngine;
      
      function dispose() : void;
   }
}
