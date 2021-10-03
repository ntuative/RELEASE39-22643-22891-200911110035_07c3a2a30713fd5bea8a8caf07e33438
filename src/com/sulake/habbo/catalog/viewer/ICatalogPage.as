package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import flash.events.Event;
   
   public interface ICatalogPage
   {
       
      
      function get localization() : IPageLocalization;
      
      function dispose() : void;
      
      function get window() : IWindowContainer;
      
      function get pageId() : int;
      
      function init() : void;
      
      function get viewer() : ICatalogViewer;
      
      function get layoutCode() : String;
      
      function get links() : Array;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get offers() : Array;
      
      function get hasLinks() : Boolean;
   }
}
