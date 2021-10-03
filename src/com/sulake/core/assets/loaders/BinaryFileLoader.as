package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   
   public class BinaryFileLoader extends AssetLoaderEventBroker implements IAssetLoader
   {
       
      
      protected var var_1:URLLoader;
      
      protected var var_816:String;
      
      protected var _type:String;
      
      public function BinaryFileLoader(param1:String, param2:URLRequest = null)
      {
         super();
         var_816 = param2 == null ? "" : param2.url;
         _type = param1;
         var_1 = new URLLoader();
         var_1.addEventListener(Event.COMPLETE,loadEventHandler);
         var_1.addEventListener(Event.UNLOAD,loadEventHandler);
         var_1.addEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
         var_1.addEventListener(ProgressEvent.PROGRESS,loadEventHandler);
         var_1.addEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
         var_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get bytesTotal() : uint
      {
         return var_1.bytesTotal;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_816 = param1.url;
         var_1.dataFormat = _type == "application/octet-stream" ? "null" : URLLoaderDataFormat.TEXT;
         var_1.load(param1);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_1.removeEventListener(Event.COMPLETE,loadEventHandler);
            var_1.removeEventListener(Event.UNLOAD,loadEventHandler);
            var_1.removeEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
            var_1.removeEventListener(ProgressEvent.PROGRESS,loadEventHandler);
            var_1.removeEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
            var_1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
            var_1.close();
            var_1 = null;
            _type = null;
            var_816 = null;
         }
      }
      
      public function get mimeType() : String
      {
         return _type;
      }
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_1.bytesLoaded;
      }
      
      public function get content() : Object
      {
         return var_1.data;
      }
   }
}
