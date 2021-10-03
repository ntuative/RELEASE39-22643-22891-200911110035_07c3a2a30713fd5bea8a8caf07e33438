package com.sulake.core.runtime
{
   import com.sulake.core.utils.LibraryLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public interface IContext extends IUnknown
   {
       
      
      function prepareAssetLibrary(param1:XML, param2:Class) : Boolean;
      
      function removeUpdateReceiver(param1:ICoreUpdateReceiver) : void;
      
      function prepareComponent(param1:XML, param2:Class, param3:ApplicationDomain = null) : Boolean;
      
      function attachComponent(param1:Component, param2:Array) : void;
      
      function detachComponent(param1:Component) : void;
      
      function registerUpdateReceiver(param1:ICoreUpdateReceiver, param2:uint) : void;
      
      function loadFromFile(param1:URLRequest, param2:LoaderContext) : LibraryLoader;
      
      function toXMLString(param1:uint = 0) : String;
   }
}
