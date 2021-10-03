package com.sulake.habbo.room.object.visualization.room.rasterizer
{
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   
   public interface IPlaneRasterizer
   {
       
      
      function getTextureIdentifier(param1:Number, param2:IVector3d) : String;
      
      function initializeDimensions(param1:int, param2:int) : Boolean;
      
      function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData;
   }
}
