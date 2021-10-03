package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.visualization.furniture.data.ColorData;
   import com.sulake.habbo.room.object.visualization.furniture.data.LayerData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BlendMode;
   
   public class FurnitureVisualization extends RoomObjectSpriteVisualization
   {
       
      
      protected var _direction:int;
      
      protected var var_2039:int = -1;
      
      protected var _data:FurnitureVisualizationData = null;
      
      protected var _type:String = "";
      
      protected var var_2037:Number = NaN;
      
      public function FurnitureVisualization()
      {
         super();
         reset();
      }
      
      private function updateSprites(param1:int, param2:Number) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = NaN;
         var _loc9_:int = 0;
         if(_data == null)
         {
            return;
         }
         var _loc3_:int = _data.getLayerCount(param1) + 1;
         if(_loc3_ != spriteCount)
         {
            createSprites(_loc3_);
         }
         var _loc4_:int = spriteCount - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = getSpriteAssetName(_loc4_,param1);
            _loc6_ = getSprite(_loc4_);
            if(_loc6_ != null)
            {
               _loc7_ = null;
               if(assetCollection != null)
               {
                  _loc7_ = assetCollection.getAsset(_loc5_);
               }
               if(_loc7_ != null)
               {
                  _loc6_.visible = true;
                  _loc6_.asset = _loc7_.asset;
                  _loc6_.flipH = _loc7_.flipH;
                  _loc6_.flipV = _loc7_.flipV;
                  _loc6_.offsetX = _loc7_.offsetX;
                  _loc6_.offsetY = _loc7_.offsetY;
                  _loc8_ = 0;
                  if(_loc4_ < spriteCount - 1)
                  {
                     _loc6_.tag = _data.getTag(_loc4_,_direction,param1);
                     _loc6_.alpha = getSpriteAlpha(_loc4_,_direction,param1);
                     _loc6_.color = getSpriteColor(_loc4_,var_2039,param1);
                     _loc6_.offsetX += getSpriteXOffset(_loc4_,_direction,param1);
                     _loc6_.offsetY += getSpriteYOffset(_loc4_,_direction,param1);
                     _loc6_.capturesMouse = !_data.getIgnoreMouse(_loc4_,_direction,param1);
                     _loc6_.blendMode = getBlendMode(_data.getInk(_loc4_,_direction,param1));
                     _loc8_ = Number(getSpriteZOffset(_loc4_,_direction,param1));
                     _loc8_ -= _loc4_ * 0.001;
                  }
                  else
                  {
                     _loc9_ = 96;
                     if(object != null && object.getModel() != null)
                     {
                        _loc9_ *= object.getModel().getNumber(RoomObjectVariableEnum.const_158);
                     }
                     _loc6_.alpha = _loc9_;
                     _loc6_.capturesMouse = false;
                     _loc8_ = 1;
                  }
                  _loc8_ *= param2;
                  _loc6_.relativeDepth = _loc8_;
                  _loc6_.assetName = _loc5_;
               }
               else
               {
                  _loc6_.asset = null;
                  _loc6_.assetName = "";
                  _loc6_.tag = "";
                  _loc6_.flipH = false;
                  _loc6_.flipV = false;
                  _loc6_.offsetX = 0;
                  _loc6_.offsetY = 0;
                  _loc6_.relativeDepth = 0;
               }
            }
            _loc4_--;
         }
      }
      
      protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(_data == null)
         {
            return LayerData.const_432;
         }
         return _data.getZOffset(param1,param2,param3);
      }
      
      override protected function reset() : void
      {
         super.reset();
         _direction = -1;
         _data = null;
         this.createSprites(0);
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is FurnitureVisualizationData))
         {
            return false;
         }
         _data = param1 as FurnitureVisualizationData;
         _type = _data.getType();
         return true;
      }
      
      protected function getBlendMode(param1:int) : String
      {
         var _loc2_:String = "null";
         switch(param1)
         {
            case LayerData.const_748:
               _loc2_ = "null";
               break;
            case LayerData.INK_DARKEN:
               _loc2_ = "null";
               break;
            case LayerData.const_829:
               _loc2_ = "null";
         }
         return _loc2_;
      }
      
      protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         if(var_177 != _loc3_.getUpdateID())
         {
            var_2039 = _loc3_.getNumber(RoomObjectVariableEnum.const_201);
            var_177 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:* = NaN;
         if(_data == null || object == null)
         {
            return LayerData.const_356;
         }
         var _loc4_:int = _data.getAlpha(param1,param2,param3);
         var _loc5_:IRoomObjectModel = object.getModel();
         if(_loc5_ != null)
         {
            _loc6_ = Number(_loc5_.getNumber(RoomObjectVariableEnum.const_158));
            if(isNaN(_loc6_))
            {
               _loc6_ = 1;
            }
            _loc4_ *= _loc6_;
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
      }
      
      protected function getFrameNumber(param1:int, param2:int) : int
      {
         return 0;
      }
      
      protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = object;
         if(_loc3_ == null)
         {
            return false;
         }
         if(var_266 != _loc3_.getUpdateID() || param1 != var_200 || param2 != var_2037)
         {
            _loc4_ = _loc3_.getDirection().x - (param2 + 135);
            _loc4_ = (_loc4_ % 360 + 360) % 360;
            _loc5_ = _data.getDirectionValue(_loc4_,param1);
            _direction = _loc5_;
            var_266 = _loc3_.getUpdateID();
            var_2037 = param2;
            return true;
         }
         return false;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc3_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         if(_data == null)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(updateObject(param1.scale,param1.direction.x))
         {
            _loc2_ = true;
         }
         if(updateModel(param1.scale))
         {
            _loc2_ = true;
         }
         if(updateAnimation(param1.scale))
         {
            _loc2_ = true;
         }
         if(_loc2_ || var_200 != param1.scale)
         {
            _loc3_ = Math.sqrt(0.5);
            updateSprites(param1.scale,_loc3_);
            var_200 = param1.scale;
         }
      }
      
      private function getSpriteAssetName(param1:int, param2:Number) : String
      {
         var _loc6_:int = 0;
         if(_data == null)
         {
            return "";
         }
         var _loc3_:int = _data.getSize(param2);
         var _loc4_:String = _type;
         var _loc5_:String = "";
         if(param1 < spriteCount - 1)
         {
            _loc5_ = String.fromCharCode("a".charCodeAt() + param1);
         }
         else
         {
            _loc5_ = "sd";
         }
         if(_loc3_ == 1)
         {
            _loc4_ += "_icon_" + _loc5_;
         }
         else
         {
            _loc6_ = getFrameNumber(param1,param2);
            _loc4_ += "_" + _loc3_ + "_" + _loc5_ + "_" + _direction;
            _loc4_ += "_" + _loc6_;
         }
         return _loc4_;
      }
      
      protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(_data == null)
         {
            return LayerData.const_401;
         }
         return _data.getXOffset(param1,param2,param3);
      }
      
      protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(_data == null)
         {
            return LayerData.const_348;
         }
         return _data.getYOffset(param1,param2,param3);
      }
      
      protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(_data == null)
         {
            return ColorData.const_61;
         }
         return _data.getColor(param1,param2,param3);
      }
      
      protected function updateAnimation(param1:Number) : Boolean
      {
         return false;
      }
   }
}
