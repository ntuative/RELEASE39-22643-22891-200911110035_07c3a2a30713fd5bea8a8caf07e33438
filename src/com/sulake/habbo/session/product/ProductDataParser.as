package com.sulake.habbo.session.product
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class ProductDataParser extends EventDispatcher
   {
      
      public static const READY:String = "ready";
       
      
      private var var_674:Dictionary;
      
      public function ProductDataParser(param1:String, param2:Dictionary)
      {
         super();
         var_674 = param2;
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:URLLoader = new URLLoader();
         _loc4_.addEventListener(Event.COMPLETE,parseProductsData);
         configureListeners(_loc4_);
         _loc4_.load(_loc3_);
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         Logger.log("[ProductParser] HTTPStatus: " + param1.status + " " + param1.type);
      }
      
      private function parseProductsData(param1:Event) : void
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc2_:URLLoader = URLLoader(param1.target);
         var _loc3_:String = String(_loc2_.data);
         var _loc4_:Array = new Array();
         var _loc5_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc6_:RegExp = /^\s+|\s+$/g;
         var _loc7_:RegExp = /\[+?((.)*?)\]/g;
         _loc3_ = _loc3_.replace(/"{1,}/mg,"");
         var _loc8_:Array = _loc3_.split(_loc5_);
         var _loc9_:int = 0;
         for each(_loc10_ in _loc8_)
         {
            _loc11_ = _loc10_.match(_loc7_);
            for each(_loc12_ in _loc11_)
            {
               _loc12_ = _loc12_.replace(/\[{1,}/mg,"");
               _loc12_ = _loc12_.replace(/\]{1,}/mg,"");
               _loc13_ = _loc12_.split(",");
               _loc14_ = _loc13_[0];
               _loc15_ = _loc13_[1];
               _loc16_ = _loc13_[2];
               _loc17_ = _loc13_[3];
               _loc18_ = new ProductData(_loc14_,_loc15_,_loc16_,_loc17_);
               var_674[_loc14_] = _loc18_;
            }
            _loc9_++;
         }
         dispatchEvent(new Event(READY));
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         Logger.log("[ProductParser] SecurityError: " + param1.text);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         Logger.log("[ProductParser] IOError: " + param1.text + " " + param1.type);
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         param1.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
      }
      
      private function removeListeners(param1:IEventDispatcher) : void
      {
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         param1.removeEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
      }
   }
}
