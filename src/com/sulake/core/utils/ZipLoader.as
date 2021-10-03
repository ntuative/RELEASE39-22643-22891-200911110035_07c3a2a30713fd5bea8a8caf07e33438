package com.sulake.core.utils
{
   import deng.fzip.FZip;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   
   public class ZipLoader extends LibraryLoader
   {
       
      
      private var _zip:FZip;
      
      private var var_1024:Array;
      
      private var var_1567:uint = 0;
      
      private var var_688:int = 0;
      
      private var var_2131:Array;
      
      public function ZipLoader(param1:Boolean)
      {
         super(param1);
         var_1024 = new Array();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         Logger.log(param1.text);
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,0));
      }
      
      public function get resources() : Array
      {
         return var_1024;
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:String = getQualifiedClassName(var_1.content);
         var_1024.push(var_1.contentLoaderInfo.applicationDomain.getDefinition(_loc3_));
         ++var_688;
         if(var_1024.length == var_1567)
         {
            var_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaderComplete);
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,0));
         }
         else
         {
            var_1.loadBytes(_zip.getFileAt(var_688).content);
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null, param3:int = 1) : void
      {
         var_338 = param1;
         _zip = new FZip();
         _zip.addEventListener(Event.COMPLETE,onComplete);
         _zip.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _zip.load(var_338);
      }
      
      private function onComplete(param1:Event) : void
      {
         var_688 = 0;
         var_1567 = _zip.getFileCount();
         removeEventListeners();
         var_1.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
         var_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         var_1.loadBytes(_zip.getFileAt(var_688).content);
      }
   }
}
