package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.habbo.communication.IHabboWebLogin;
   import com.sulake.habbo.communication.enum.HabboWeb;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class SSOTicket extends EventDispatcher
   {
      
      public static const const_231:String = "failure";
      
      public static const const_310:String = "success";
       
      
      private var _assets:IAssetLibrary;
      
      private var var_1095:String;
      
      private var var_1757:String;
      
      private var var_426:String;
      
      private var var_1096:IHabboWebLogin;
      
      private var var_1:URLLoader;
      
      private var var_2137:String;
      
      public function SSOTicket(param1:IAssetLibrary, param2:IHabboWebLogin, param3:String)
      {
         super();
         _assets = param1;
         var_1096 = param2;
         var_1095 = "http://" + param3 + "/shockwave_client";
         var_1096.init();
         var_1096.addEventListener(HabboWeb.const_211,requestClientURL);
      }
      
      public function get shockwaveClientUrl() : String
      {
         return var_1757;
      }
      
      private function requestClientURL(param1:Event = null) : void
      {
         var _loc2_:String = var_1095;
         if(_assets.hasAsset(_loc2_))
         {
            Logger.log("[CoreLocalizationManager] reload localization for url: " + var_1095);
         }
         var _loc3_:URLRequest = new URLRequest(var_1095);
         if(_assets.hasAsset(_loc2_))
         {
            _assets.removeAsset(_assets.getAssetByName(_loc2_));
         }
         var _loc4_:AssetLoaderStruct = _assets.loadAssetFromFile(_loc2_,_loc3_,"text/plain");
         _loc4_.addEventListener(AssetLoaderEvent.const_30,clientURLComplete);
      }
      
      public function get ticket() : String
      {
         return var_426;
      }
      
      private function clientURLComplete(param1:Event = null) : void
      {
         var event:Event = param1;
         var loaderStruct:AssetLoaderStruct = event.target as AssetLoaderStruct;
         if(loaderStruct == null)
         {
            return;
         }
         var data:String = loaderStruct.assetLoader.content as String;
         if(data.indexOf("account/reauthenticate\"") > -1)
         {
            var_1096.requestReAuthenticate();
         }
         else
         {
            try
            {
               var_426 = String(data.split(/[";]sso.ticket=/)[1]).split("\"")[0];
               var_426 = var_426.split(";")[0];
               var_426 = var_426.replace("\\","");
               var_1757 = data.split(/<param name="src" value="/)[1].split("habbo.dcr")[0];
               if(false)
               {
                  dispatchEvent(new Event(const_310));
               }
               else
               {
                  dispatchEvent(new Event(const_231));
               }
            }
            catch(e:Error)
            {
               dispatchEvent(new Event(const_231));
            }
         }
      }
   }
}
