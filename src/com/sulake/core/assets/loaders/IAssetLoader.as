package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.IDisposable;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public interface IAssetLoader extends IEventDispatcher, IDisposable
   {
       
      
      function get bytesLoaded() : uint;
      
      function load(param1:URLRequest) : void;
      
      function get bytesTotal() : uint;
      
      function get content() : Object;
      
      function get mimeType() : String;
      
      function get url() : String;
   }
}
