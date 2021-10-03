package com.sulake.core.assets
{
   import flash.utils.getQualifiedClassName;
   
   public class UnknownAsset implements IAsset
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_1018:AssetTypeDeclaration;
      
      private var var_816:String;
      
      private var var_30:Object = null;
      
      public function UnknownAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         var_1018 = param1;
         var_816 = param2;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return var_1018;
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         var_30 = param1;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         var_30 = param1.content as Object;
      }
      
      public function get content() : Object
      {
         return var_30;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
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
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + ": " + var_30;
      }
   }
}
