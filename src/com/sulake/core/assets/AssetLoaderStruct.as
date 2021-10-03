package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.IAssetLoader;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventDispatcher;
   
   public class AssetLoaderStruct extends EventDispatcher implements IDisposable
   {
       
      
      private var var_601:IAssetLoader;
      
      private var var_1183:String;
      
      public function AssetLoaderStruct(param1:String, param2:IAssetLoader)
      {
         super();
         var_1183 = param1;
         var_601 = param2;
      }
      
      public function get assetLoader() : IAssetLoader
      {
         return var_601;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_601 != null)
            {
               if(true)
               {
                  var_601.dispose();
                  var_601 = null;
               }
            }
            super.dispose();
         }
      }
      
      public function get assetName() : String
      {
         return var_1183;
      }
   }
}
