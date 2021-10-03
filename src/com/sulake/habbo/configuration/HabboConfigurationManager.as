package com.sulake.habbo.configuration
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.TextAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class HabboConfigurationManager extends Component implements IHabboConfigurationManager
   {
      
      private static var var_1238:String = "%";
       
      
      private var var_1789:Boolean = false;
      
      private var var_1788:String = "";
      
      private var var_676:Boolean = false;
      
      private var var_1355:Array;
      
      private var var_904:Dictionary;
      
      public function HabboConfigurationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var_1355 = [];
         super(param1,param2,param3);
         var_904 = new Dictionary();
         var _loc4_:TextAsset = _assets.getAssetByName("default_configuration") as TextAsset;
         parseConfiguration(_loc4_.content.toString());
         if(param1 is CoreComponent)
         {
            _loc5_ = (param1 as CoreComponent).root.stage;
            _loc6_ = _loc5_.loaderInfo.url;
            _loc7_ = _loc6_.lastIndexOf("/");
            _loc6_ = _loc6_.substring(0,_loc7_ + 1);
            setKey("flash.client.url",_loc6_);
            for(_loc8_ in _loc5_.loaderInfo.parameters)
            {
               _loc9_ = _loc5_.loaderInfo.parameters[_loc8_];
               _loc8_ = _loc8_.replace(/[_]/g,".");
               Logger.log("Habbo Configuration: Register HTML Parameter: " + _loc8_ + " = " + _loc9_);
               setKey(_loc8_,_loc9_);
               var_1355.push(_loc8_);
            }
            if(!keyExists("external.hash"))
            {
               _loc10_ = "";
               while(_loc11_ < 40)
               {
                  _loc10_ += int(Math.random() * 9).toString();
                  _loc11_++;
               }
               setKey("external.hash",_loc10_);
            }
            (param1 as CoreComponent).events.addEventListener(Component.COMPONENT_EVENT_RUNNING,onComponentsRunning);
         }
         init();
      }
      
      public function keyExists(param1:String) : Boolean
      {
         var _loc2_:String = var_904[param1] as String;
         return _loc2_ != null;
      }
      
      private function parseConfiguration(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc3_:RegExp = /^\s+|\s+$/g;
         var _loc4_:Array = param1.split(_loc2_);
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.substr(0,1) != "#")
            {
               _loc6_ = _loc5_.split("=");
               if(_loc6_[0].length > 0 && _loc6_[1].length > 0)
               {
                  _loc7_ = _loc6_.shift();
                  _loc8_ = _loc6_.join("=");
                  _loc7_ = _loc7_.replace(_loc3_,"");
                  _loc8_ = _loc8_.replace(_loc3_,"");
                  this.setKey(_loc7_,_loc8_);
               }
            }
         }
         var_1788 = getKey("url.prefix");
      }
      
      public function setKey(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(param3)
         {
            if(true)
            {
               Logger.log(param1 + "=" + param2);
            }
         }
         if(var_1355.indexOf(param1) < 0)
         {
            var_904[param1] = param2;
         }
      }
      
      private function onInitConfiguration(param1:Event = null) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.assetLoader.content as String;
         if(_loc3_ != null)
         {
            parseConfiguration(_loc3_);
         }
         Logger.log("Configuration check: " + this.getKey("connection.info.host"));
         var_676 = true;
         this.events.dispatchEvent(new Event(HabboConfigurationEvent.const_18));
         if(var_1789)
         {
            this.events.dispatchEvent(new Event(HabboConfigurationEvent.INIT));
         }
      }
      
      public function getKey(param1:String, param2:String = "", param3:Dictionary = null) : String
      {
         var _loc4_:String = var_904[param1] as String;
         if(_loc4_ == null)
         {
            _loc4_ = param2;
         }
         if(_loc4_ != null)
         {
            if(_loc4_.indexOf("%predefined%") > -1)
            {
               _loc4_ = _loc4_.replace("%predefined%",var_1788);
               _loc4_ = _loc4_.replace("http://http://","http://");
            }
         }
         if(param3 != null)
         {
            _loc4_ = this.fillParams(_loc4_,param3);
         }
         return _loc4_;
      }
      
      private function fillParams(param1:String, param2:Dictionary) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = param1.indexOf(var_1238);
            if(_loc4_ < 0)
            {
               break;
            }
            _loc5_ = param1.indexOf(var_1238,_loc4_ + 1);
            if(_loc5_ < 0)
            {
               break;
            }
            _loc6_ = param1.substring(_loc4_ + 1,_loc5_);
            _loc7_ = param2[_loc6_];
            param1 = param1.replace("%" + _loc6_ + "%",_loc7_);
            _loc3_++;
         }
         return param1;
      }
      
      private function init() : void
      {
         var _loc1_:String = this.getKey("external.variables.txt","external_variables.txt");
         Logger.log("Configuration External Variables: " + _loc1_);
         var _loc2_:String = _loc1_;
         if(assets.hasAsset(_loc2_))
         {
            Logger.log("[HabboConfigurationManager] reload configuration for url: " + _loc1_);
         }
         var _loc3_:URLRequest = new URLRequest(_loc1_);
         var _loc4_:AssetLoaderStruct = assets.loadAssetFromFile(_loc2_,_loc3_,"text/plain");
         _loc4_.addEventListener(AssetLoaderEvent.const_30,onInitConfiguration);
      }
      
      private function onComponentsRunning(param1:Event = null) : void
      {
         var_1789 = true;
         if(var_676)
         {
            this.events.dispatchEvent(new Event(HabboConfigurationEvent.INIT));
         }
      }
   }
}
