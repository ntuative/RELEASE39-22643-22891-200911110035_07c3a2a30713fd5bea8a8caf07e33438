package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DesktopController extends ActivatorController implements IDesktopWindow, IDisplayObjectWrapper
   {
       
      
      public function DesktopController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9 != null ? param9 : defaultProcedure,null,null,0);
      }
      
      public function get mouseY() : int
      {
         return getDisplayObject().stage.mouseY;
      }
      
      override public function get host() : IWindow
      {
         return this;
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      override public function get desktop() : IDesktopWindow
      {
         return this;
      }
      
      override public function set procedure(param1:Function) : void
      {
         _procedure = param1 != null ? param1 : defaultProcedure;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getGraphicContext(true) as DisplayObject;
      }
      
      override public function set parent(param1:IWindow) : void
      {
         throw new Error("Desktop window doesn\'t have parent!");
      }
      
      private function defaultProcedure(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      public function get mouseX() : int
      {
         return getDisplayObject().stage.mouseX;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_31)
         {
            var_31 = new GraphicContext("GC {" + _name + "}",GraphicContext.GC_TYPE_DESKTOP,var_22);
         }
         return var_31;
      }
      
      public function setDisplayObject(param1:DisplayObject) : void
      {
         getGraphicContext(true).setDisplayObject(param1);
      }
   }
}
