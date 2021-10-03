package com.sulake.habbo.avatar.alias
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import flash.utils.Dictionary;
   
   public class AssetAliasCollection
   {
       
      
      private var var_474:Dictionary;
      
      private var var_1298:AssetLibraryCollection;
      
      public function AssetAliasCollection(param1:AssetLibraryCollection, param2:Array)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         super();
         var_1298 = param1;
         var_474 = new Dictionary();
         for each(_loc3_ in param2)
         {
            _loc4_ = var_1298.getAssetLibraryByName(_loc3_);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.manifest;
               for each(_loc6_ in _loc5_.library.aliases.alias)
               {
                  _loc7_ = String(_loc6_.@name);
                  _loc8_ = new AssetAlias(_loc6_);
                  var_474[_loc7_] = _loc8_;
               }
            }
         }
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         var _loc2_:* = null;
         if(hasAlias(param1))
         {
            _loc2_ = var_474[param1] as AssetAlias;
            param1 = _loc2_.link;
         }
         return var_1298.getAssetByName(param1);
      }
      
      public function getAliasByName(param1:String) : AssetAlias
      {
         return var_474[param1] as AssetAlias;
      }
      
      public function hasAlias(param1:String) : Boolean
      {
         var _loc2_:AssetAlias = var_474[param1] as AssetAlias;
         return _loc2_ != null;
      }
      
      public function addAlias(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc5_:XML = <alias name="" link="" fliph="0" flipv="0"/>;
         _loc5_.@name = param1;
         _loc5_.@link = param2;
         var _loc6_:AssetAlias = new AssetAlias(_loc5_);
         var_474[param1] = _loc6_;
      }
   }
}
