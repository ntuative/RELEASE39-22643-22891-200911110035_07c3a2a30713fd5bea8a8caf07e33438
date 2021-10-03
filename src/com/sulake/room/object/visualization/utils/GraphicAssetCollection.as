package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class GraphicAssetCollection implements IGraphicAssetCollection
   {
       
      
      private var _assets:Dictionary;
      
      private var var_483:IAssetLibrary;
      
      public function GraphicAssetCollection()
      {
         super();
         _assets = new Dictionary();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for(_loc1_ in _assets)
         {
            _loc2_ = _assets[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            delete _assets[_loc1_];
         }
         _assets = null;
         var_483 = null;
      }
      
      public function define(param1:XML) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:Boolean = false;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.asset;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc3_].@name;
            if(_loc4_.length() > 0)
            {
               _loc5_ = _loc4_;
               _loc6_ = _loc5_;
               _loc7_ = false;
               _loc8_ = false;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc4_ = _loc2_[_loc3_].@x;
               if(_loc4_.length() > 0)
               {
                  _loc9_ = -int(_loc4_);
               }
               _loc4_ = _loc2_[_loc3_].@y;
               if(_loc4_.length() > 0)
               {
                  _loc10_ = -int(_loc4_);
               }
               _loc4_ = _loc2_[_loc3_].@source;
               if(_loc4_.length() > 0)
               {
                  _loc6_ = _loc4_;
               }
               _loc4_ = _loc2_[_loc3_].@flipH;
               if(_loc4_.length() > 0)
               {
                  if(int(_loc4_) > 0)
                  {
                     _loc4_ = _loc2_[_loc3_].@source;
                     if(_loc4_.length() > 0)
                     {
                        _loc6_ = _loc4_;
                        _loc7_ = true;
                     }
                  }
               }
               _loc4_ = _loc2_[_loc3_].@flipV;
               if(_loc4_.length() > 0)
               {
                  if(int(_loc4_) > 0)
                  {
                     _loc4_ = _loc2_[_loc3_].@source;
                     if(_loc4_.length() > 0)
                     {
                        _loc6_ = _loc4_;
                        _loc8_ = true;
                     }
                  }
               }
               _loc11_ = var_483.getAssetByName(_loc6_);
               _loc12_ = createAsset(_loc5_,_loc11_,_loc7_,_loc8_,_loc9_,_loc10_);
               if(_loc12_)
               {
               }
            }
            _loc3_++;
         }
         return true;
      }
      
      public function addAsset(param1:String, param2:BitmapData, param3:Boolean) : Boolean
      {
         var _loc5_:* = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(var_483 == null)
         {
            return false;
         }
         var _loc4_:BitmapDataAsset = var_483.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            _loc4_ = new BitmapDataAsset(var_483.getAssetTypeDeclarationByClass(BitmapDataAsset));
            var_483.setAsset(param1,_loc4_);
            _loc4_.setUnknownContent(param2);
            return createAsset(param1,_loc4_,false,false,0,0);
         }
         if(param3)
         {
            _loc5_ = _loc4_.content as BitmapData;
            if(_loc5_ != null && _loc5_ != param2)
            {
               _loc5_.dispose();
            }
            _loc4_.setUnknownContent(param2);
         }
         return false;
      }
      
      protected function createAsset(param1:String, param2:IAsset, param3:Boolean, param4:Boolean, param5:Number, param6:Number) : Boolean
      {
         if(false)
         {
            return false;
         }
         var _loc7_:GraphicAsset = new GraphicAsset(param1,param2,param3,param4,param5,param6);
         _assets[param1] = _loc7_;
         return true;
      }
      
      public function getAsset(param1:String) : IGraphicAsset
      {
         return _assets[param1];
      }
      
      public function set assetLibrary(param1:IAssetLibrary) : void
      {
         var_483 = param1;
      }
   }
}
