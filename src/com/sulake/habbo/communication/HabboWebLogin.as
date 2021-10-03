package com.sulake.habbo.communication
{
   import com.sulake.habbo.communication.enum.HabboWeb;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class HabboWebLogin extends EventDispatcher implements IHabboWebLogin
   {
       
      
      private var var_1615:String;
      
      private var var_1614:String;
      
      private var var_1613:String;
      
      private var _name:String;
      
      private var var_1:URLLoader;
      
      private var _password:String;
      
      public function HabboWebLogin(param1:String, param2:String, param3:String, param4:IEventDispatcher = null)
      {
         super(param4);
         _name = param1;
         _password = param2;
         var_1613 = "https://" + param3 + "/account/submit";
         var_1615 = "https://" + param3 + "/security_check";
         var_1614 = "https://" + param3 + "/account/reauthenticate";
      }
      
      private function securityCheckComplete(param1:Event = null) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         var_1.removeEventListener(Event.COMPLETE,securityCheckComplete);
         removeListeners(var_1);
         var _loc3_:String = _loc2_.data;
         if(_loc3_.indexOf("Redirecting") > -1)
         {
            dispatchEvent(new Event(HabboWeb.const_211));
         }
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         Logger.log("[LoginToWeb] SecurityError: " + param1.text);
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         Logger.log("[LoginToWeb] HTTPStatus: " + param1.status + " " + param1.type);
      }
      
      private function credentialsComplete(param1:Event = null) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         var_1.removeEventListener(Event.COMPLETE,credentialsComplete);
         removeListeners(var_1);
         var _loc3_:String = _loc2_.data;
         if(_loc3_.indexOf("Redirecting") > -1)
         {
            requestSecurityCheck();
         }
         else if(_loc3_.indexOf("Habbo ~ Me") > -1)
         {
            dispatchEvent(new Event(HabboWeb.const_211));
         }
         else if(_loc3_.indexOf("Habbo ~ Home") > -1)
         {
            dispatchEvent(new Event(HabboWeb.const_211));
         }
         else if(_loc3_.indexOf("Habbo: Home") > -1)
         {
            dispatchEvent(new Event(HabboWeb.const_211));
         }
      }
      
      private function requestSecurityCheck() : void
      {
         var _loc1_:URLRequest = new URLRequest(var_1615);
         var_1 = new URLLoader();
         var_1.addEventListener(Event.COMPLETE,securityCheckComplete);
         configureListeners(var_1);
         var_1.load(_loc1_);
      }
      
      private function removeListeners(param1:IEventDispatcher) : void
      {
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         param1.removeEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
      }
      
      public function requestReAuthenticate() : void
      {
         var _loc1_:String = "page=%2Fclient&credentials.password=" + _password;
         var _loc2_:URLRequest = new URLRequest(var_1614);
         _loc2_.data = new URLVariables(_loc1_);
         _loc2_.method = URLRequestMethod.POST;
         var_1 = new URLLoader();
         var_1.addEventListener(Event.COMPLETE,reauthenticateComplete);
         configureListeners(var_1);
         var_1.load(_loc2_);
      }
      
      public function init() : void
      {
         requestCredentials();
      }
      
      private function reauthenticateComplete(param1:Event = null) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         var_1.removeEventListener(Event.COMPLETE,reauthenticateComplete);
         removeListeners(var_1);
         var _loc3_:String = _loc2_.data;
         if(_loc3_.indexOf("Redirecting") > -1)
         {
            dispatchEvent(new Event(HabboWeb.const_211));
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         Logger.log("[LoginToWeb] IOError: " + param1.text + " " + param1.type);
      }
      
      private function requestCredentials() : void
      {
         var _loc1_:String = "credentials.username=" + _name + "&credentials.password=" + _password;
         var _loc2_:URLRequest = new URLRequest(var_1613);
         _loc2_.data = new URLVariables(_loc1_);
         _loc2_.method = URLRequestMethod.POST;
         var_1 = new URLLoader();
         var_1.addEventListener(Event.COMPLETE,credentialsComplete);
         configureListeners(var_1);
         var_1.load(_loc2_);
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         param1.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
      }
   }
}
