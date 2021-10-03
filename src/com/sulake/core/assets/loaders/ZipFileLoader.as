package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   
   public class ZipFileLoader extends AssetLoaderEventBroker implements IAssetLoader
   {
       
      
      protected var var_108:URLStream;
      
      protected var var_816:String;
      
      protected var _type:String;
      
      public function ZipFileLoader(param1:String, param2:URLRequest = null)
      {
         super();
         var_816 = param2 == null ? "" : param2.url;
         _type = param1;
         var_108 = new URLStream();
         var_108.addEventListener(Event.COMPLETE,loadEventHandler);
         var_108.addEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
         var_108.addEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
         var_108.addEventListener(Event.OPEN,loadEventHandler);
         var_108.addEventListener(ProgressEvent.PROGRESS,loadEventHandler);
         var_108.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get bytesTotal() : uint
      {
         return var_108.bytesAvailable;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_108.removeEventListener(Event.COMPLETE,loadEventHandler);
            var_108.removeEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
            var_108.removeEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
            var_108.removeEventListener(Event.OPEN,loadEventHandler);
            var_108.removeEventListener(ProgressEvent.PROGRESS,loadEventHandler);
            var_108.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
            var_108.close();
            var_108 = null;
            _type = null;
            var_816 = null;
         }
      }
      
      public function load(param1:URLRequest) : void
      {
         var_816 = param1.url;
         var_108.load(param1);
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
         return var_108.bytesAvailable;
      }
      
      public function get content() : Object
      {
         return var_108;
      }
   }
}
