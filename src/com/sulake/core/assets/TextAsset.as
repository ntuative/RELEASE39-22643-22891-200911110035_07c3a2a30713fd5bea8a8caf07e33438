package com.sulake.core.assets
{
   import flash.utils.ByteArray;
   
   public class TextAsset implements IAsset
   {
       
      
      private var var_30:String = "";
      
      private var _disposed:Boolean = false;
      
      private var var_1018:AssetTypeDeclaration;
      
      private var var_816:String;
      
      public function TextAsset(param1:AssetTypeDeclaration, param2:String = null)
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
         var _loc2_:* = null;
         if(param1 is String)
         {
            var_30 = param1 as String;
            return;
         }
         if(param1 is Class)
         {
            _loc2_ = new param1() as ByteArray;
            var_30 = _loc2_.readUTFBytes(_loc2_.length);
            return;
         }
         if(param1 is ByteArray)
         {
            _loc2_ = param1 as ByteArray;
            var_30 = _loc2_.readUTFBytes(_loc2_.length);
            return;
         }
         if(param1 is TextAsset)
         {
            var_30 = TextAsset(param1).var_30;
            return;
         }
         var_30 = param1.toString();
      }
      
      public function get content() : Object
      {
         return var_30;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is TextAsset)
         {
            var_30 = TextAsset(param1).var_30;
            return;
         }
         throw Error("Provided asset is not of type TextAsset!");
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
