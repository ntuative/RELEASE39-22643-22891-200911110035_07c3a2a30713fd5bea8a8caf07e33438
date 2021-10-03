package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class RoomTileCursorVisualization extends FurnitureVisualization
   {
       
      
      public function RoomTileCursorVisualization()
      {
         super();
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc5_:* = null;
         super.update(param1);
         var _loc2_:IRoomObjectModel = object.getModel();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Boolean = Boolean(_loc2_.getNumber(RoomObjectVariableEnum.const_96));
         var _loc4_:int = spriteCount - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = getSprite(_loc4_);
            if(_loc5_ != null)
            {
               _loc5_.visible = _loc3_;
               _loc5_.varyingDepth = true;
            }
            _loc4_--;
         }
      }
   }
}
