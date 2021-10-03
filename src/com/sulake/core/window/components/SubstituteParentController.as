package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.geom.Rectangle;
   
   public class SubstituteParentController extends WindowController
   {
       
      
      public function SubstituteParentController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         param5 |= 0;
         param7 = new Rectangle(0,0,2000,2000);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         var_292 = false;
      }
      
      override public function swapChildren(param1:IWindow, param2:IWindow) : void
      {
         _children.swapChildren(WindowController(param1),WindowController(param2));
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         return null;
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         _children.swapChildrenAt(param1,param2);
      }
      
      override public function setupGraphicsContext() : IGraphicContext
      {
         return null;
      }
      
      override public function removeChild(param1:IWindow) : IWindow
      {
         var _loc2_:WindowController = WindowController(param1);
         if(_children.removeChild(_loc2_) != null)
         {
            _loc2_.removeEventListener(WindowEvent.const_88,childParamUpdated);
            _loc2_.parent = null;
            return param1;
         }
         return null;
      }
      
      private function childParamUpdated(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.window;
         if(getChildIndex(_loc2_) == -1)
         {
            _loc2_.removeEventListener(WindowEvent.const_88,childParamUpdated);
         }
         else if(!_loc2_.testParamFlag(WindowParam.const_32))
         {
            _loc2_.desktop.addChild(_loc2_);
         }
      }
      
      override public function addChild(param1:IWindow) : IWindow
      {
         return addChildAt(param1,numChildren);
      }
      
      override public function addChildAt(param1:IWindow, param2:int) : IWindow
      {
         var _loc3_:WindowController = WindowController(param1);
         if(_loc3_.parent != null)
         {
            WindowController(_loc3_.parent).removeChild(_loc3_);
         }
         _children.addChildAt(_loc3_,param2);
         _loc3_.parent = this;
         _loc3_.addEventListener(WindowEvent.const_88,childParamUpdated);
         return param1;
      }
      
      override public function setChildIndex(param1:IWindow, param2:int) : void
      {
         _children.setChildIndex(WindowController(param1),param2);
      }
   }
}
