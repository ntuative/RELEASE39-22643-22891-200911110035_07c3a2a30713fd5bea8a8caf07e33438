package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class ActivatorController extends ContainerController
   {
       
      
      protected var var_662:IWindow;
      
      public function ActivatorController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function getActiveChild() : IWindow
      {
         return var_662;
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_207)
         {
            setActiveChild(param1 as IWindow);
         }
         else if(param2.type == WindowNotifyEvent.const_678)
         {
            return true;
         }
         return super.update(param1,param2);
      }
      
      public function setActiveChild(param1:IWindow) : IWindow
      {
         if(param1.parent != this)
         {
            while(true)
            {
               param1 = param1.parent;
               if(param1 == null)
               {
                  break;
               }
               if(param1.parent != this)
               {
                  continue;
               }
            }
            throw new Error("Window passed to activator is not a child!");
         }
         var _loc2_:IWindow = var_662;
         if(var_662 != param1)
         {
            if(var_662 != null)
            {
               if(true)
               {
                  var_662.deactivate();
               }
            }
            var_662 = param1;
            if(getChildIndex(param1) != numChildren - 1)
            {
               setChildIndex(param1,numChildren - 1);
            }
         }
         return _loc2_;
      }
   }
}
