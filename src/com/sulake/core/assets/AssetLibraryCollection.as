package com.sulake.core.assets
{
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AssetLibraryCollection extends EventDispatcher implements IAssetLibrary
   {
       
      
      protected var var_409:XML;
      
      protected var var_976:LoaderContext;
      
      protected var var_40:Array;
      
      protected var var_467:Array;
      
      private var var_548:uint = 0;
      
      protected var var_336:AssetLibrary;
      
      protected var _name:String;
      
      public function AssetLibraryCollection(param1:String)
      {
         super();
         _name = param1;
         var_409 = new XML();
         var_40 = new Array();
         var_467 = new Array();
         var_976 = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         var_336 = new AssetLibrary("lib-" + var_548++);
         var_40.push(var_336);
      }
      
      public function createAsset(param1:String, param2:AssetTypeDeclaration) : IAsset
      {
         return var_336.createAsset(param1,param2);
      }
      
      private function getNumAssets() : uint
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ += IAssetLibrary(var_40[_loc3_]).numAssets;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getAssetLibraryByName(param1:String) : IAssetLibrary
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_40[_loc4_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return var_336.getAssetTypeDeclarationByFileName(param1,true);
         }
         _loc3_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = var_40[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByFileName(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function unload() : void
      {
         while(false)
         {
            (var_467.pop() as IAssetLibrary).dispose();
         }
         while(false)
         {
            (var_40.pop() as IAssetLibrary).dispose();
         }
      }
      
      public function getAssetByContent(param1:Object) : IAsset
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = var_40[_loc5_];
            _loc4_ = _loc3_.getAssetByContent(param1);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean
      {
         return var_336.registerAssetTypeDeclaration(param1,param2);
      }
      
      public function get nameArray() : Array
      {
         return getAssetNameArray();
      }
      
      public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null) : AssetLoaderStruct
      {
         return var_336.loadAssetFromFile(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            super.dispose();
            _loc1_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = var_40.pop();
               _loc2_.dispose();
               _loc3_++;
            }
         }
      }
      
      public function get isReady() : Boolean
      {
         return false;
      }
      
      public function getAssetByIndex(param1:uint) : IAsset
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ += IAssetLibrary(var_40[_loc5_]).numAssets;
            if(_loc2_ <= param1)
            {
               return IAssetLibrary(var_40[_loc5_]).getAssetByIndex(param1 - _loc3_);
            }
            _loc3_ = uint(_loc2_);
            _loc5_++;
         }
         return null;
      }
      
      public function get loaderContext() : LoaderContext
      {
         return var_976;
      }
      
      public function get numAssets() : uint
      {
         return getNumAssets();
      }
      
      public function setAsset(param1:String, param2:IAsset, param3:Boolean = true) : Boolean
      {
         return var_336.setAsset(param1,param2,param3);
      }
      
      public function get manifest() : XML
      {
         return var_409;
      }
      
      public function set loaderContext(param1:LoaderContext) : void
      {
         var_976 = param1;
      }
      
      public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return var_336.getAssetTypeDeclarationByClass(param1,true);
         }
         _loc3_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = var_40[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByClass(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function getAssetIndex(param1:IAsset) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = var_40[_loc6_];
            _loc5_ = _loc3_.getAssetIndex(param1);
            if(_loc5_ != -1)
            {
               return _loc4_ + _loc5_;
            }
            _loc4_ += _loc3_.numAssets;
            _loc6_++;
         }
         return -1;
      }
      
      public function loadFromFile(param1:URLRequest, param2:Boolean = false, param3:LoaderContext = null) : LibraryLoader
      {
         var _loc5_:* = null;
         if(param3 == null)
         {
            param3 = var_976;
         }
         var _loc4_:IAssetLibrary = new AssetLibrary("lib-" + var_548++);
         var_467.push(_loc4_);
         _loc5_ = _loc4_.loadFromFile(param1,param2,param3);
         _loc5_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,loadEventHandler);
         _loc5_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,loadEventHandler);
         _loc5_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,loadEventHandler);
         return _loc5_;
      }
      
      private function loadEventHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)
         {
            _loc2_ = param1.target as LibraryLoader;
            _loc4_ = 0;
            while(_loc4_ < var_467.length)
            {
               _loc3_ = var_467[_loc4_] as IAssetLibrary;
               if(_loc3_.url == _loc2_.url)
               {
                  var_467.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            var_40.push(_loc3_);
            if(false)
            {
               dispatchEvent(new Event(AssetLibrary.const_381));
            }
         }
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = var_40[_loc5_];
            _loc4_ = _loc3_.getAssetByName(param1);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function loadFromResource(param1:XML, param2:Class) : Boolean
      {
         return var_336.loadFromResource(param1,param2);
      }
      
      public function removeAsset(param1:IAsset) : IAsset
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_40[_loc4_];
            if(_loc3_.removeAsset(param1) == param1)
            {
               return param1;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2)
         {
            return var_336.getAssetTypeDeclarationByMimeType(param1,true);
         }
         _loc3_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = var_40[_loc6_];
            _loc5_ = _loc4_.getAssetTypeDeclarationByMimeType(param1,false);
            if(_loc5_ != null)
            {
               return _loc5_;
            }
            _loc6_++;
         }
         return null;
      }
      
      public function hasAssetLibrary(param1:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_40[_loc4_];
            if(_loc3_.name == param1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function loadFromArchive(param1:URLRequest, param2:LoaderContext = null) : LibraryLoader
      {
         return var_336.loadFromArchive(param1,param2);
      }
      
      public function addAssetLibrary(param1:IAssetLibrary) : void
      {
         if(var_40.indexOf(param1) == -1)
         {
            var_40.push(param1);
         }
      }
      
      private function getAssetNameArray() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_.concat(IAssetLibrary(var_40[_loc3_]).nameArray);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get url() : String
      {
         return "";
      }
      
      public function getAssetLibraryByUrl(param1:String) : IAssetLibrary
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_40[_loc4_];
            if(_loc3_.url == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function hasAsset(param1:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_40[_loc4_];
            if(_loc3_.hasAsset(param1))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
   }
}
