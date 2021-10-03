package com.sulake.habbo.catalog.navigation
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   
   public interface ICatalogNavigator
   {
       
      
      function get catalog() : IHabboCatalog;
      
      function activateNode(param1:ICatalogNode) : void;
      
      function buildCatalogIndex(param1:NodeData) : void;
      
      function openPage(param1:String) : void;
      
      function getNodeByName(param1:String) : ICatalogNode;
      
      function openFrontPage() : void;
      
      function dispose() : void;
   }
}
