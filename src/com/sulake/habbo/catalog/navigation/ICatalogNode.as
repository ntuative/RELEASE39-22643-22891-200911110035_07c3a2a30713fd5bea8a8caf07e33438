package com.sulake.habbo.catalog.navigation
{
   import flash.display.BitmapData;
   
   public interface ICatalogNode
   {
       
      
      function get localization() : String;
      
      function hasChild(param1:ICatalogNode) : Boolean;
      
      function get color() : uint;
      
      function dispose() : void;
      
      function get isLeaf() : Boolean;
      
      function get depth() : int;
      
      function get isBranch() : Boolean;
      
      function get parent() : ICatalogNode;
      
      function get pageId() : int;
      
      function activate() : void;
      
      function get isOpen() : Boolean;
      
      function get isNavigateable() : Boolean;
      
      function set parent(param1:ICatalogNode) : void;
      
      function open() : void;
      
      function close() : void;
      
      function get icon() : BitmapData;
      
      function deActivate() : void;
      
      function addChild(param1:ICatalogNode) : void;
      
      function get children() : Array;
   }
}
