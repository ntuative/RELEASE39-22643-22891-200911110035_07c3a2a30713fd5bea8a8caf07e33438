package com.sulake.room.object.visualization
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization
   {
       
      
      protected var var_200:int = -1;
      
      private var var_169:Array;
      
      protected var var_266:uint = 4.294967295E9;
      
      private var var_254:IRoomObject;
      
      protected var var_177:uint = 4.294967295E9;
      
      private var _assetCollection:IGraphicAssetCollection;
      
      public function RoomObjectSpriteVisualization()
      {
         super();
         var_169 = [];
         var_254 = null;
         _assetCollection = null;
      }
      
      public function update(param1:IRoomGeometry = null) : void
      {
      }
      
      public function get spriteCount() : int
      {
         return var_169.length;
      }
      
      public function getSprite(param1:uint) : IRoomObjectSprite
      {
         if(param1 < var_169.length)
         {
            return var_169[param1];
         }
         return null;
      }
      
      protected function reset() : void
      {
         var_266 = 4294967295;
         var_177 = 4294967295;
         var_200 = -1;
      }
      
      public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         return false;
      }
      
      public function get image() : BitmapData
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc1_:Rectangle = boundingRectangle;
         if(_loc1_.width * _loc1_.height == 0)
         {
            return null;
         }
         var _loc2_:int = spriteCount;
         var _loc3_:* = null;
         var _loc4_:* = [];
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = getSprite(_loc5_);
            if(_loc3_ != null && _loc3_.visible)
            {
               _loc6_ = _loc3_.asset;
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_.content as BitmapData;
                  if(_loc7_ != null)
                  {
                     _loc4_.push(_loc3_);
                  }
               }
            }
            _loc5_++;
         }
         _loc4_.sortOn("relativeDepth",0 | 0);
         var _loc8_:BitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_] as IRoomObjectSprite;
            _loc6_ = _loc3_.asset;
            _loc7_ = _loc6_.content as BitmapData;
            if(_loc7_ != null)
            {
               _loc12_ = uint(_loc3_.color);
               _loc13_ = uint(_loc12_ >> 16);
               _loc14_ = uint(_loc12_ >> 8 & 255);
               _loc15_ = uint(_loc12_ & 255);
               _loc16_ = null;
               if(_loc13_ < 255 || _loc14_ < 255 || _loc15_ < 255)
               {
                  _loc9_ = _loc13_ / 255;
                  _loc10_ = _loc14_ / 255;
                  _loc11_ = _loc15_ / 255;
                  _loc16_ = new ColorTransform(_loc9_,_loc10_,_loc11_,_loc3_.alpha / 255);
               }
               else if(_loc3_.alpha < 255)
               {
                  _loc16_ = new ColorTransform(1,1,1,_loc3_.alpha / 255);
               }
               if(_loc3_.blendMode == BlendMode.ADD)
               {
                  if(_loc16_ == null)
                  {
                     _loc16_ = new ColorTransform(1,1,1,0);
                  }
                  else
                  {
                     _loc16_.alphaMultiplier = 0;
                  }
               }
               _loc17_ = new Matrix();
               if(_loc3_.flipH)
               {
                  _loc17_.scale(-1,1);
                  _loc17_.translate(_loc7_.width,0);
               }
               _loc17_.translate(_loc3_.offsetX - _loc1_.left,_loc3_.offsetY - _loc1_.top);
               _loc8_.draw(_loc7_,_loc17_,_loc16_,_loc3_.blendMode,null,false);
            }
            _loc5_++;
         }
         return _loc8_;
      }
      
      public function set assetCollection(param1:IGraphicAssetCollection) : void
      {
         _assetCollection = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(var_169 != null)
         {
            while(false)
            {
               _loc1_ = var_169[0] as RoomObjectSprite;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               var_169.pop();
            }
            var_169 = null;
         }
         var_254 = null;
         _assetCollection = null;
      }
      
      protected function createSprites(param1:uint) : void
      {
         var _loc2_:* = null;
         while(var_169.length > param1)
         {
            _loc2_ = var_169["-1"] as RoomObjectSprite;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            var_169.pop();
         }
         while(var_169.length < param1)
         {
            _loc2_ = new RoomObjectSprite();
            var_169.push(_loc2_);
         }
      }
      
      public function get boundingRectangle() : Rectangle
      {
         var _loc7_:* = null;
         var _loc1_:int = spriteCount;
         var _loc2_:* = null;
         var _loc3_:Rectangle = new Rectangle();
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = getSprite(_loc4_);
            if(_loc2_ != null && _loc2_.visible)
            {
               _loc5_ = _loc2_.asset;
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.content as BitmapData;
                  if(_loc6_ != null)
                  {
                     _loc7_ = new Point(_loc2_.offsetX,_loc2_.offsetY);
                     if(_loc4_ == 0)
                     {
                        _loc3_.left = _loc7_.x;
                        _loc3_.top = _loc7_.y;
                        _loc3_.right = _loc7_.x + _loc2_.width;
                        _loc3_.bottom = _loc7_.y + _loc2_.height;
                     }
                     else
                     {
                        if(_loc7_.x < _loc3_.left)
                        {
                           _loc3_.left = _loc7_.x;
                        }
                        if(_loc7_.y < _loc3_.top)
                        {
                           _loc3_.top = _loc7_.y;
                        }
                        if(_loc7_.x + _loc2_.width > _loc3_.right)
                        {
                           _loc3_.right = _loc7_.x + _loc2_.width;
                        }
                        if(_loc7_.y + _loc2_.height > _loc3_.bottom)
                        {
                           _loc3_.bottom = _loc7_.y + _loc2_.height;
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function get assetCollection() : IGraphicAssetCollection
      {
         return _assetCollection;
      }
      
      public function set object(param1:IRoomObject) : void
      {
         var_254 = param1;
      }
      
      public function get object() : IRoomObject
      {
         return var_254;
      }
   }
}
