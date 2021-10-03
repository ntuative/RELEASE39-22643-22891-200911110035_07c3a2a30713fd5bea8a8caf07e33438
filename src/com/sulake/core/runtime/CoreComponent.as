package com.sulake.core.runtime
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.profiler.ProfilerViewer;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public final class CoreComponent extends ComponentContext implements ICore
   {
      
      private static const const_145:uint = 3;
      
      private static const const_959:String = "library";
      
      public static const const_1240:int = -3;
      
      public static const const_1173:int = -2;
      
      private static const const_961:String = "library";
      
      private static const const_960:String = "library";
      
      private static const const_964:String = "library";
      
      private static const const_962:String = "zip-libraries";
      
      public static const const_1387:int = -4;
      
      public static const const_1109:int = -99;
      
      private static const const_963:String = "service-libraries";
      
      private static const const_958:String = "asset-libraries";
      
      private static const const_965:String = "component-libraries";
       
      
      private var var_125:ICoreConfigStatusListener;
      
      private var var_359:uint;
      
      private var var_236:Array;
      
      private var var_237:uint;
      
      private var var_119:DisplayObjectContainer;
      
      private var var_692:Profiler;
      
      private var var_238:Array;
      
      private var var_239:Array;
      
      private var var_582:ErrorReportStorage;
      
      private var var_484:Array;
      
      private var var_581:Array;
      
      private var var_240:Array;
      
      private var var_583:ProfilerViewer;
      
      public function CoreComponent(param1:DisplayObjectContainer, param2:uint)
      {
         var_582 = new ErrorReportStorage();
         super(this,Component.COMPONENT_FLAG_CONTEXT,new AssetLibraryCollection("_core_assets"));
         var_814 = (param2 & 0) != 0;
         var_484 = new Array();
         var_581 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < CoreComponent.const_145)
         {
            var_484.push(new Array());
            var_581.push(0);
            _loc3_++;
         }
         var_359 = getTimer();
         attachComponent(this,[new IIDCore()]);
         var_119 = param1;
         switch(param2 & 0)
         {
            case Core.const_1097:
               debug("Core; using simple frame update handler");
               var_119.addEventListener(Event.ENTER_FRAME,simpleFrameUpdateHandler);
               break;
            case Core.const_755:
               debug("Core; using complex frame update handler");
               var_119.addEventListener(Event.ENTER_FRAME,complexFrameUpdateHandler);
               break;
            case Core.const_1090:
               debug("Core; using profiler frame update handler");
               var_119.addEventListener(Event.ENTER_FRAME,profilerFrameUpdateHandler);
               var_692 = new Profiler(this);
               attachComponent(var_692,[new IIDProfiler()]);
               var_583 = new ProfilerViewer();
               var_119.addChild(var_583);
         }
      }
      
      override public function removeUpdateReceiver(param1:ICoreUpdateReceiver) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < CoreComponent.const_145)
         {
            _loc3_ = var_484[_loc4_] as Array;
            _loc2_ = _loc3_.indexOf(param1);
            if(_loc2_ > -1)
            {
               _loc3_.splice(_loc2_,1);
               return;
            }
            _loc4_++;
         }
      }
      
      override protected function error(param1:String, param2:Boolean, param3:int = 0) : void
      {
         if(param2)
         {
            var_582["error_category_context"] = param3;
            var_582["error_description"] = param1;
         }
         super.error(param1,param2,param3);
         if(param2)
         {
            dispose();
         }
      }
      
      public function getLastErrorMessage() : String
      {
         return _lastError;
      }
      
      public function initialize() : void
      {
         name_1.dispatchEvent(new Event(Component.COMPONENT_EVENT_RUNNING));
         Logger.log(toXMLString());
      }
      
      private function profilerFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_359;
         var_359 = msCurrentTime;
         var_692.start();
         criticality = 0;
         while(criticality < CoreComponent.const_145)
         {
            var_581[criticality] = 0;
            receivers = var_484[criticality];
            index = 0;
            length = receivers.length;
            while(index != length)
            {
               receiver = ICoreUpdateReceiver(receivers[index]);
               if(receiver.disposed)
               {
                  receivers.splice(index,1);
                  length--;
               }
               else
               {
                  try
                  {
                     var_692.update(receiver,msSinceLastUpdate);
                  }
                  catch(e:Error)
                  {
                     var_582["error_data"] = String(e.getStackTrace());
                     error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID);
                     return;
                  }
                  index++;
               }
            }
            criticality++;
         }
         var_692.stop();
         var_583.refresh(var_692);
      }
      
      private function complexFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var skip:Boolean = false;
         var t:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_359;
         var maxTimePerFrame:uint = 1000 / DisplayObject(var_119).stage.frameRate;
         var isDebugBuild:Boolean = false;
         var_359 = msCurrentTime;
         criticality = 0;
         while(criticality < CoreComponent.const_145)
         {
            t = getTimer();
            skip = false;
            if(t - msCurrentTime > maxTimePerFrame)
            {
               if(var_581[criticality] < criticality)
               {
                  ++0;
                  skip = true;
               }
            }
            if(!skip)
            {
               var_581[criticality] = 0;
               receivers = var_484[criticality];
               index = 0;
               length = receivers.length;
               while(index != length)
               {
                  receiver = ICoreUpdateReceiver(receivers[index]);
                  if(receiver.disposed)
                  {
                     receivers.splice(index,1);
                     length--;
                  }
                  else
                  {
                     if(isDebugBuild)
                     {
                        receiver.update(msSinceLastUpdate);
                     }
                     else
                     {
                        try
                        {
                           receiver.update(msSinceLastUpdate);
                        }
                        catch(e:Error)
                        {
                           var_582["error_data"] = String(e.getStackTrace());
                           error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID);
                           return;
                        }
                     }
                     index++;
                  }
               }
            }
            criticality++;
         }
      }
      
      private function simpleFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_359;
         var_359 = msCurrentTime;
         criticality = 0;
         while(criticality < CoreComponent.const_145)
         {
            var_581[criticality] = 0;
            receivers = var_484[criticality];
            index = 0;
            length = receivers.length;
            while(index != length)
            {
               receiver = ICoreUpdateReceiver(receivers[index]);
               if(receiver.disposed)
               {
                  receivers.splice(index,1);
                  length--;
               }
               else
               {
                  try
                  {
                     receiver.update(msSinceLastUpdate);
                  }
                  catch(e:Error)
                  {
                     var_582["error_data"] = String(e.getStackTrace());
                     error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID);
                     return;
                  }
                  index++;
               }
            }
            criticality++;
         }
      }
      
      public function get stateStorage() : ErrorReportStorage
      {
         return var_582;
      }
      
      public function loadExternalConfigDocument(param1:URLRequest, param2:ICoreConfigStatusListener = null) : void
      {
         if(var_125)
         {
            if(var_125 != param2)
            {
               var_125.dispose();
            }
         }
         if(param2)
         {
            var_125 = param2;
         }
         var _loc3_:AssetLoaderStruct = _assets.loadAssetFromFile("config.xml",param1);
         debug("Loading config document \"" + _loc3_.assetLoader.url + "\"");
         _loc3_.addEventListener(AssetLoaderEvent.const_30,configLoadedHandler);
         _loc3_.addEventListener(AssetLoaderEvent.const_45,configLoadedHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            debug("Disposing core");
            var_119.removeEventListener(Event.ENTER_FRAME,simpleFrameUpdateHandler);
            var_119.removeEventListener(Event.ENTER_FRAME,complexFrameUpdateHandler);
            var_119.removeEventListener(Event.ENTER_FRAME,profilerFrameUpdateHandler);
            var_119 = null;
            _loc3_ = 0;
            while(_loc3_ < CoreComponent.const_145)
            {
               _loc2_ = var_484[_loc3_] as Array;
               _loc1_ = uint(_loc2_.length);
               while(_loc1_-- > 0)
               {
                  _loc2_.pop();
               }
               _loc3_++;
            }
            if(var_239 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_239.pop();
               }
            }
            if(var_240 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_240.pop();
               }
            }
            if(var_236 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_236.pop();
               }
            }
            if(var_238 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_238.pop();
               }
            }
            if(var_583 != null)
            {
               var_583.dispose();
               var_583 = null;
            }
            if(var_125)
            {
               var_125.dispose();
               var_125 = null;
            }
            super.dispose();
         }
      }
      
      public function readConfigDocument(param1:XML, param2:ICoreConfigStatusListener = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(var_125)
         {
            if(var_125 != param2)
            {
               var_125.dispose();
            }
         }
         if(param2)
         {
            var_125 = param2;
         }
         debug("Parsing config document");
         if(var_239 == null)
         {
            var_239 = new Array();
         }
         _loc3_ = param1.child(const_962)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_959);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url");
               var_239.push(_loc6_);
               ++var_237;
            }
         }
         if(var_240 == null)
         {
            var_240 = new Array();
         }
         _loc3_ = param1.child(const_958)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_961);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url");
               var_240.push(_loc6_);
               ++var_237;
            }
         }
         if(var_236 == null)
         {
            var_236 = new Array();
         }
         _loc3_ = param1.child(const_963)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_960);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url");
               var_236.push(_loc6_);
               ++var_237;
            }
         }
         if(var_238 == null)
         {
            var_238 = new Array();
         }
         _loc3_ = param1.child(const_965)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_964);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url");
               var_238.push(_loc6_);
               ++var_237;
            }
         }
         if(var_125)
         {
            var_125.percent = 0;
         }
         updateLoadingProcess();
      }
      
      private function updateLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1 != null)
         {
            if(param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE || param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR)
            {
               _loc2_ = param1.target as LibraryLoader;
               _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               _loc3_ = _loc2_.url;
               debug("Loading library \"" + _loc3_ + "\" " + (param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE ? "ready" : "failed\n" + _loc2_.getLastErrorMessage()));
               if(false)
               {
                  if(var_239[0] == _loc3_)
                  {
                     var_239.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_240[0] == _loc3_)
                  {
                     var_240.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_236[0] == _loc3_)
                  {
                     var_236.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_238[0] == _loc3_)
                  {
                     var_238.splice(0,1);
                  }
               }
            }
         }
         if(var_125)
         {
            _loc4_ = 0;
            var_125.percent = (var_237 - _loc4_) / var_237;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = _assets.loadFromArchive(new URLRequest(_loc3_),null);
            if(_loc2_.ready)
            {
               var_239.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading zip library " + _loc3_);
            }
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc5_ = new LoaderContext(false,new ApplicationDomain());
            _loc2_ = _assets.loadFromFile(new URLRequest(_loc3_),true,_loc5_);
            if(_loc2_.ready)
            {
               var_240.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading asset library " + _loc3_);
            }
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = loadFromFile(new URLRequest(_loc3_),new LoaderContext(false,ApplicationDomain.currentDomain,null));
            if(_loc2_.ready)
            {
               var_236.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading service library " + _loc3_);
            }
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = loadFromFile(new URLRequest(_loc3_),new LoaderContext(false,ApplicationDomain.currentDomain,null));
            if(_loc2_.ready)
            {
               var_238.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading component library " + _loc3_);
            }
            return;
         }
         debug("All libraries loaded, Core is now running");
      }
      
      private function errorInLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:LibraryLoader = LibraryLoader(param1.target);
         error("Failed to download library \"" + _loc2_.url + "\": " + _loc2_.getLastErrorMessage(),true,const_1240);
         updateLoadingProcess(param1);
      }
      
      public function getLastDebugMessage() : String
      {
         return var_2036;
      }
      
      override public function registerUpdateReceiver(param1:ICoreUpdateReceiver, param2:uint) : void
      {
         removeUpdateReceiver(param1);
         param2 = param2 >= CoreComponent.const_145 ? 4294967295 : uint(param2);
         var _loc3_:Array = var_484[param2] as Array;
         _loc3_.push(param1);
      }
      
      private function configLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _loc2_ = param1.target as AssetLoaderStruct;
         _loc2_.removeEventListener(AssetLoaderEvent.const_30,configLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_45,configLoadedHandler);
         if(param1.type == AssetLoaderEvent.const_30)
         {
            debug("Config document \"" + _loc2_.assetLoader.url + "\" loaded");
            _loc3_ = _assets.getAssetByName(_loc2_.assetName) as XmlAsset;
            _loc4_ = _loc3_.content as XML;
            readConfigDocument(_loc4_,var_125);
         }
         else
         {
            error("Failed to download external configuration document " + _loc2_.assetLoader.url + "!",true,const_1173);
            name_1.dispatchEvent(new Event(Component.COMPONENT_EVENT_ERROR));
         }
      }
      
      public function get root() : DisplayObjectContainer
      {
         return var_119;
      }
   }
}
