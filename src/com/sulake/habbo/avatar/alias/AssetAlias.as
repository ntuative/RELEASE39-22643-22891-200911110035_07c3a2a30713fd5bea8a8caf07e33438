package com.sulake.habbo.avatar.alias
{
   public class AssetAlias
   {
       
      
      private var var_1367:Boolean;
      
      private var _name:String;
      
      private var var_1859:String;
      
      private var var_1368:Boolean;
      
      public function AssetAlias(param1:XML)
      {
         super();
         _name = String(param1.@name);
         var_1859 = String(param1.@link);
         var_1368 = Boolean(parseInt(param1.@fliph));
         var_1367 = Boolean(parseInt(param1.@flipv));
      }
      
      public function get flipH() : Boolean
      {
         return var_1368;
      }
      
      public function get flipV() : Boolean
      {
         return var_1367;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get link() : String
      {
         return var_1859;
      }
   }
}
