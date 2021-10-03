package com.sulake.core.assets
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IAsset extends IDisposable
   {
       
      
      function setParamsDesc(param1:XMLList) : void;
      
      function setUnknownContent(param1:Object) : void;
      
      function get content() : Object;
      
      function get declaration() : AssetTypeDeclaration;
      
      function setFromOtherAsset(param1:IAsset) : void;
      
      function get url() : String;
   }
}
