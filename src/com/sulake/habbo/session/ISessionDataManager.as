package com.sulake.habbo.session
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public interface ISessionDataManager extends IUnknown
   {
       
      
      function get gender() : String;
      
      function getProductData(param1:String) : IProductData;
      
      function get systemShutDown() : Boolean;
      
      function get userId() : int;
      
      function isIgnored(param1:String) : Boolean;
      
      function getFurnitureData(param1:int) : IFurnitureData;
      
      function showGroupBadgeInfo(param1:int) : void;
      
      function pickAllFurniture(param1:int, param2:int) : void;
      
      function getGroupBadgeId(param1:int) : String;
      
      function unignoreUser(param1:String) : void;
      
      function hasUserRight(param1:String) : Boolean;
      
      function get isAnyRoomController() : Boolean;
      
      function openHabboHomePage(param1:int) : void;
      
      function get systemOpen() : Boolean;
      
      function getGroupBadgeImage(param1:String) : BitmapData;
      
      function get figure() : String;
      
      function method_11(param1:String) : IFurnitureData;
      
      function get respectLeft() : int;
      
      function getBadgeImage(param1:String) : BitmapData;
      
      function get events() : IEventDispatcher;
      
      function giveRespect(param1:int) : void;
      
      function get userName() : String;
      
      function getUserTags(param1:int) : Array;
      
      function ignoreUser(param1:String) : void;
   }
}
