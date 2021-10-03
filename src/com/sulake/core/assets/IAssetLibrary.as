package com.sulake.core.assets
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.LibraryLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public interface IAssetLibrary extends IDisposable
   {
       
      
      function getAssetByIndex(param1:uint) : IAsset;
      
      function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration;
      
      function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration;
      
      function getAssetByContent(param1:Object) : IAsset;
      
      function get numAssets() : uint;
      
      function get name() : String;
      
      function loadFromFile(param1:URLRequest, param2:Boolean = true, param3:LoaderContext = null) : LibraryLoader;
      
      function get nameArray() : Array;
      
      function get url() : String;
      
      function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null) : AssetLoaderStruct;
      
      function loadFromArchive(param1:URLRequest, param2:LoaderContext = null) : LibraryLoader;
      
      function removeAsset(param1:IAsset) : IAsset;
      
      function createAsset(param1:String, param2:AssetTypeDeclaration) : IAsset;
      
      function setAsset(param1:String, param2:IAsset, param3:Boolean = true) : Boolean;
      
      function get manifest() : XML;
      
      function getAssetIndex(param1:IAsset) : int;
      
      function get isReady() : Boolean;
      
      function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean;
      
      function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration;
      
      function getAssetByName(param1:String) : IAsset;
      
      function hasAsset(param1:String) : Boolean;
      
      function loadFromResource(param1:XML, param2:Class) : Boolean;
      
      function unload() : void;
   }
}
