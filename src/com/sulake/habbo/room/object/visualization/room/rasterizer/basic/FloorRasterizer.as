package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.BitmapData;
   
   public class FloorRasterizer extends PlaneRasterizer
   {
       
      
      private var var_313:Map = null;
      
      public function FloorRasterizer()
      {
         super();
         var_313 = new Map();
      }
      
      private function parseFloors(param1:XML) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.floor;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc3_];
            if(XMLValidator.checkRequiredAttributes(_loc4_,["id"]))
            {
               _loc5_ = _loc4_.@id;
               _loc6_ = _loc4_.visualization;
               _loc7_ = new FloorPlane();
               parseVisualizations(_loc7_,_loc6_);
               if(var_313.getValue(_loc5_) == null)
               {
                  var_313.add(_loc5_,_loc7_);
               }
               else
               {
                  _loc7_.dispose();
               }
            }
            _loc3_++;
         }
      }
      
      override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         var _loc13_:FloorPlane = var_313.getValue(param2);
         if(_loc13_ == null)
         {
            _loc13_ = var_313.getValue(const_691);
         }
         if(_loc13_ == null)
         {
            return null;
         }
         if(param1 != null)
         {
            param1.fillRect(param1.rect,16777215);
         }
         var _loc14_:BitmapData = _loc13_.render(param1,param3,param4,param5,param6,param7);
         if(_loc14_ != null && _loc14_ != param1)
         {
            _loc14_ = _loc14_.clone();
         }
         return new PlaneBitmapData(_loc14_,-1);
      }
      
      override public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         super.initializeAssetCollection(param1);
         if(data == null)
         {
            return;
         }
         var _loc2_:XMLList = data.floors;
         if(_loc2_.length() > 0)
         {
            parseFloors(_loc2_[0]);
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(var_313 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_313.length)
            {
               _loc2_ = var_313.getWithIndex(_loc1_) as FloorPlane;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_313.dispose();
            var_313 = null;
         }
         super.dispose();
      }
   }
}
