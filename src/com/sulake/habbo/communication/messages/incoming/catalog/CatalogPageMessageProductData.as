package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageProductData
   {
      
      public static const const_308:String = "e";
      
      public static const const_127:String = "i";
      
      public static const const_154:String = "s";
       
      
      private var var_863:String;
      
      private var var_1047:String;
      
      private var var_1046:int;
      
      private var var_1883:int;
      
      private var var_864:int;
      
      public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
      {
         super();
         var_1047 = param1.readString();
         var_1883 = param1.readInteger();
         var_863 = param1.readString();
         var_864 = param1.readInteger();
         var_1046 = param1.readInteger();
      }
      
      public function get productCount() : int
      {
         return var_864;
      }
      
      public function get productType() : String
      {
         return var_1047;
      }
      
      public function get expiration() : int
      {
         return var_1046;
      }
      
      public function get furniClassId() : int
      {
         return var_1883;
      }
      
      public function get extraParam() : String
      {
         return var_863;
      }
   }
}
