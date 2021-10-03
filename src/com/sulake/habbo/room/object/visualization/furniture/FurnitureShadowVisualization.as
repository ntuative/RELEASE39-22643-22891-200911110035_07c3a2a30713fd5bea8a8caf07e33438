package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   
   public class FurnitureShadowVisualization extends RoomObjectSpriteVisualization
   {
       
      
      protected var _direction:int;
      
      protected var var_2037:Number = NaN;
      
      protected var _data:FurnitureVisualizationData = null;
      
      public function FurnitureShadowVisualization()
      {
         super();
         reset();
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
            var_177 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      private function updateSprites(param1:int, param2:Number) : void
      {
         var _loc6_:int = 0;
         if(_data == null)
         {
            return;
         }
         createSprites(1);
         var _loc3_:String = getSpriteAssetName(0,param1);
         var _loc4_:* = null;
         if(assetCollection != null)
         {
            _loc4_ = assetCollection.getAsset(_loc3_);
         }
         var _loc5_:IRoomObjectSprite = getSprite(0);
         if(_loc5_ != null)
         {
            if(_loc4_ != null)
            {
               _loc5_.visible = true;
               _loc5_.asset = _loc4_.asset;
               _loc5_.flipH = _loc4_.flipH;
               _loc5_.offsetX = _loc4_.offsetX;
               _loc5_.offsetY = _loc4_.offsetY;
               _loc6_ = 96;
               if(object != null && object.getModel() != null)
               {
                  _loc6_ *= object.getModel().getNumber(RoomObjectVariableEnum.const_158);
               }
               _loc5_.alpha = _loc6_;
               _loc5_.capturesMouse = false;
               _loc5_.relativeDepth = 1 * param2;
               _loc5_.assetName = _loc3_;
            }
            else
            {
               _loc5_.asset = null;
               _loc5_.assetName = "";
               _loc5_.flipH = false;
               _loc5_.offsetX = 0;
               _loc5_.offsetY = 0;
               _loc5_.relativeDepth = 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
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
      
      private function getSpriteAssetName(param1:int, param2:Number) : String
      {
         if(_data == null)
         {
            return "";
         }
         var _loc3_:int = _data.getSize(param2);
         var _loc4_:String = _data.getType();
         _loc4_ += "_" + _loc3_ + "_" + "sd" + "_" + _direction;
         return _loc4_ + "_0";
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
         return true;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc4_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         if(_data == null)
         {
            return;
         }
         var _loc2_:IVector3d = param1.directionAxis;
         var _loc3_:Boolean = false;
         if(updateObject(param1.scale,param1.direction.x))
         {
            _loc3_ = true;
         }
         if(updateModel(param1.scale))
         {
            _loc3_ = true;
         }
         if(_loc3_ || var_200 != param1.scale)
         {
            _loc4_ = Math.sqrt(0.5);
            updateSprites(param1.scale,_loc4_);
            var_200 = param1.scale;
         }
      }
   }
}
