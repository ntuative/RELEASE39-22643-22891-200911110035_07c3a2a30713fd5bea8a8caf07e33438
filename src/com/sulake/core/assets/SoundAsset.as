package com.sulake.core.assets
{
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class SoundAsset implements IAsset
   {
       
      
      private var var_30:Sound = null;
      
      private var _disposed:Boolean = false;
      
      private var var_1018:AssetTypeDeclaration;
      
      private var var_816:String;
      
      public function SoundAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         var_1018 = param1;
         var_816 = param2;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return var_1018;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 is Sound)
         {
            if(var_30)
            {
               var_30.close();
            }
            var_30 = param1 as Sound;
            return;
         }
         if(param1 is ByteArray)
         {
         }
         if(param1 is Class)
         {
            if(var_30)
            {
               var_30.close();
            }
            var_30 = new param1() as Sound;
            return;
         }
         if(param1 is SoundAsset)
         {
            if(var_30)
            {
               var_30.close();
            }
            var_30 = SoundAsset(param1).var_30;
            return;
         }
      }
      
      public function get content() : Object
      {
         return var_30 as Object;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is SoundAsset)
         {
            var_30 = SoundAsset(param1).var_30;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            var_30 = null;
            var_1018 = null;
            var_816 = null;
         }
      }
   }
}
