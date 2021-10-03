package com.sulake.habbo.session.furniture
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class FurnitureDataParser extends EventDispatcher
   {
      
      public static const READY:String = "ready";
       
      
      private var var_992:Dictionary;
      
      private var _localization:ICoreLocalizationManager;
      
      private var var_993:Dictionary;
      
      public function FurnitureDataParser(param1:String, param2:Dictionary, param3:Dictionary, param4:ICoreLocalizationManager)
      {
         super();
         var_993 = param2;
         var_992 = param3;
         _localization = param4;
         var _loc5_:URLRequest = new URLRequest(param1);
         var _loc6_:URLLoader = new URLLoader();
         _loc6_.addEventListener(Event.COMPLETE,parseFurnitureData);
         configureListeners(_loc6_);
         _loc6_.load(_loc5_);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         Logger.log("[ProductParser] SecurityError: " + param1.text);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         Logger.log("[ProductParser] IOError: " + param1.text + " " + param1.type);
      }
      
      private function parseFurnitureData(param1:Event) : void
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = null;
         var _loc24_:* = null;
         var _loc25_:int = 0;
         var _loc26_:* = null;
         var _loc27_:* = null;
         var _loc28_:* = null;
         var _loc29_:* = null;
         var _loc2_:URLLoader = URLLoader(param1.target);
         var _loc3_:String = String(_loc2_.data);
         var _loc4_:Array = new Array();
         var _loc5_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc6_:RegExp = /^\s+|\s+$/g;
         var _loc7_:RegExp = /\[+?((.)*?)\]/g;
         var _loc8_:Array = _loc3_.split(_loc5_);
         var _loc9_:int = 0;
         for each(_loc10_ in _loc8_)
         {
            _loc11_ = _loc10_.match(_loc7_);
            for each(_loc12_ in _loc11_)
            {
               _loc12_ = _loc12_.replace(/\[{1,}/mg,"");
               _loc12_ = _loc12_.replace(/\]{1,}/mg,"");
               _loc13_ = _loc12_.split("\"");
               removePatternFrom(_loc13_,", ");
               removePatternFrom(_loc13_,",");
               _loc13_.splice(0,1);
               _loc13_.splice(_loc13_.length - 1,1);
               _loc14_ = _loc13_[0];
               _loc15_ = parseInt(_loc13_[1]);
               _loc16_ = String(_loc13_[2]).split("*");
               _loc17_ = _loc16_[0];
               _loc18_ = 0;
               if(_loc16_.length > 1)
               {
                  _loc18_ = parseInt(_loc16_[1]);
               }
               _loc19_ = parseInt(_loc13_[3]);
               _loc20_ = parseInt(_loc13_[4]);
               _loc21_ = parseInt(_loc13_[5]);
               _loc22_ = parseInt(_loc13_[6]);
               _loc23_ = new Array();
               _loc24_ = _loc13_[7].split(",");
               _loc25_ = 0;
               while(_loc25_ < _loc24_.length)
               {
                  _loc29_ = _loc24_[_loc25_];
                  if(_loc29_.charAt(0) == "#")
                  {
                     _loc29_ = _loc29_.replace("#","");
                     _loc23_.push(parseInt(_loc29_,16));
                  }
                  else
                  {
                     _loc23_.push(-parseInt(_loc29_));
                  }
                  _loc25_++;
               }
               _loc26_ = _loc13_[8];
               _loc27_ = _loc13_[9];
               if(_localization != null)
               {
                  _localization.updateKey("roomItem.name." + _loc15_,_loc26_);
                  _localization.updateKey("roomItem.desc." + _loc15_,_loc27_);
               }
               _loc28_ = new FurnitureData(_loc14_,_loc15_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc26_,_loc27_);
               var_993[String(_loc15_)] = _loc28_;
               var_992[_loc17_] = _loc15_;
            }
            _loc9_++;
         }
         dispatchEvent(new Event(READY));
      }
      
      private function removePatternFrom(param1:Array, param2:Object) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               param1.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         Logger.log("[ProductParser] HTTPStatus: " + param1.status + " " + param1.type);
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
