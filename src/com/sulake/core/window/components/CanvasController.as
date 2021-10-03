package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CanvasController extends WindowController implements ICanvasWindow
   {
       
      
      public function CanvasController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function retrieveDrawBuffer(param1:Point, param2:Rectangle) : BitmapData
      {
         getDrawRegion(param2);
         return fetchDrawBuffer() as BitmapData;
      }
   }
}
