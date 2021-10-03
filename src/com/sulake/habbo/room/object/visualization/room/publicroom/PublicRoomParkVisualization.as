package com.sulake.habbo.room.object.visualization.room.publicroom
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class PublicRoomParkVisualization extends PublicRoomVisualization
   {
       
      
      private var var_1151:Boolean;
      
      public function PublicRoomParkVisualization()
      {
         super();
         var_1151 = false;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         super.update(param1);
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModel = object.getModel();
         var _loc4_:int = _loc3_.getNumber(RoomObjectVariableEnum.const_745);
         var _loc5_:Boolean = Boolean(_loc4_);
         if(data != null)
         {
            if(var_1151 != _loc5_)
            {
               _loc6_ = "";
               if(_loc5_)
               {
                  data.layoutRasterizer.changeElementAlpha("bus",0);
                  data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden",255);
               }
               else
               {
                  data.layoutRasterizer.changeElementAlpha("bus",255);
                  data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden",0);
               }
               var_1151 = _loc5_;
            }
            if(data.layoutRasterizer.graphicsChanged)
            {
               _loc7_ = 0;
               while(_loc7_ < data.layoutRasterizer.elementCount())
               {
                  data.layoutRasterizer.setElementToSprite(_loc7_,getSprite(_loc7_ + var_1225),param1);
                  _loc7_++;
               }
            }
         }
      }
   }
}
