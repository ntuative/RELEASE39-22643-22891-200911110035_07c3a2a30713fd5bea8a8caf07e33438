package com.sulake.habbo.catalog.navigation
{
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import flash.display.BitmapData;
   
   public class CatalogNode implements ICatalogNode
   {
      
      private static const ICON_PREFIX:String = "icon_";
      
      private static const const_955:Array = [4293190884,4293914607,4294957908,4289454682,4289431551,4285716709,4294016606,4293326172,4293694138,4285383659,4293082689,4288782753];
       
      
      private var var_789:int = 0;
      
      private var _pageId:int = -1;
      
      private var var_1513:Boolean = false;
      
      private var var_849:int = 0;
      
      private var var_23:ICatalogNode;
      
      private var _navigator:ICatalogNavigator;
      
      private var _children:Array;
      
      private var var_1099:Boolean = false;
      
      private var _color:uint = 0;
      
      private var _localization:String = "";
      
      public function CatalogNode(param1:ICatalogNavigator, param2:NodeData, param3:int)
      {
         _children = [];
         super();
         var_849 = param3;
         _navigator = param1;
         var_1513 = param2.navigateable;
         _localization = param2.localization;
         _pageId = param2.pageId;
         _color = const_955[param2.color];
         var_789 = param2.icon;
         var_1099 = param2.disabled;
         _children = [];
      }
      
      public function get icon() : BitmapData
      {
         return null;
      }
      
      public function get children() : Array
      {
         return _children;
      }
      
      public function close() : void
      {
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get isOpen() : Boolean
      {
         return false;
      }
      
      public function get isNavigateable() : Boolean
      {
         return var_1513;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _children)
         {
            _loc1_.dispose();
         }
         _children = null;
         _navigator = null;
         var_23 = null;
      }
      
      public function hasChild(param1:ICatalogNode) : Boolean
      {
         var _loc2_:* = null;
         for each(_loc2_ in _children)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function deActivate() : void
      {
      }
      
      protected function get iconName() : String
      {
         if(var_789 < 1)
         {
            return "";
         }
         return ICON_PREFIX + var_789.toString();
      }
      
      public function get parent() : ICatalogNode
      {
         return var_23;
      }
      
      public function get isLeaf() : Boolean
      {
         return false;
      }
      
      public function get depth() : int
      {
         return var_849;
      }
      
      public function open() : void
      {
      }
      
      public function set parent(param1:ICatalogNode) : void
      {
         var_23 = param1;
      }
      
      public function get navigator() : ICatalogNavigator
      {
         return _navigator;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get isBranch() : Boolean
      {
         return false;
      }
      
      public function activate() : void
      {
      }
      
      public function addChild(param1:ICatalogNode) : void
      {
         if(param1 == null)
         {
            return;
         }
         _children.push(param1);
         param1.parent = this;
      }
      
      public function get disabled() : Boolean
      {
         return var_1099;
      }
   }
}
