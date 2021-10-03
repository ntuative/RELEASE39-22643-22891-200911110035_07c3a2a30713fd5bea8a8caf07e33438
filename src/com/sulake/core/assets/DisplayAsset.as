package com.sulake.core.assets
{
   import flash.display.DisplayObject;
   
   public class DisplayAsset implements IAsset
   {
       
      
      protected var var_30:DisplayObject;
      
      protected var _disposed:Boolean = false;
      
      protected var var_816:String;
      
      protected var var_396:AssetTypeDeclaration;
      
      public function DisplayAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         var_396 = param1;
         var_816 = param2;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return var_396;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is DisplayAsset)
         {
            var_30 = DisplayAsset(param1).var_30;
            var_396 = DisplayAsset(param1).var_396;
            return;
         }
         throw new Error("Provided asset should be of type DisplayAsset!");
      }
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 is DisplayObject)
         {
            var_30 = param1 as DisplayObject;
            if(var_30 != null)
            {
               return;
            }
            throw new Error("Failed to convert DisplayObject to DisplayAsset!");
         }
         if(param1 is DisplayAsset)
         {
            var_30 = DisplayAsset(param1).var_30;
            var_396 = DisplayAsset(param1).var_396;
            if(var_30 == null)
            {
               throw new Error("Failed to read content from DisplayAsset!");
            }
         }
      }
      
      public function get content() : Object
      {
         return var_30;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(false)
            {
               if(var_30.loaderInfo.loader != null)
               {
                  var_30.loaderInfo.loader.unload();
               }
            }
            var_30 = null;
            var_396 = null;
            _disposed = true;
            var_816 = null;
         }
      }
   }
}
