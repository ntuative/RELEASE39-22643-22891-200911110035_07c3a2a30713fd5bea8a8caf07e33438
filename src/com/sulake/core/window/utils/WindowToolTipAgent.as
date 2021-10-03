package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IToolTipWindow;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowType;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class WindowToolTipAgent extends WindowMouseOperator implements IWindowToolTipAgentService
   {
       
      
      protected var var_293:Timer;
      
      protected var var_818:String;
      
      protected var var_817:uint;
      
      protected var var_972:Point;
      
      protected var var_228:IToolTipWindow;
      
      protected var var_971:Point;
      
      public function WindowToolTipAgent(param1:DisplayObject)
      {
         var_972 = new Point();
         var_971 = new Point(20,20);
         var_817 = 500;
         super(param1);
      }
      
      override public function end(param1:IWindow) : IWindow
      {
         if(var_293 != null)
         {
            var_293.stop();
            var_293.removeEventListener(TimerEvent.TIMER,showToolTip);
            var_293 = null;
         }
         hideToolTip();
         return super.end(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         if(_window && true)
         {
            _mouse.x = param1;
            _mouse.y = param2;
            getMousePositionRelativeTo(_window,_mouse,var_972);
            if(var_228 != null && true)
            {
               var_228.x = param1 + var_971.x;
               var_228.y = param2 + var_971.y;
            }
         }
      }
      
      protected function showToolTip(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         if(var_293 != null)
         {
            var_293.reset();
         }
         if(_window && true)
         {
            if(var_228 == null || false)
            {
               var_228 = _window.context.create("undefined::ToolTip",var_818,WindowType.const_301,_window.style,0 | 0,null,null,null,0,null,null) as IToolTipWindow;
            }
            _loc2_ = new Point();
            _window.getGlobalPosition(_loc2_);
            var_228.x = _loc2_.x + var_972.x + var_971.x;
            var_228.y = _loc2_.y + var_972.y + var_971.y;
         }
      }
      
      override public function begin(param1:IWindow, param2:uint = 0) : IWindow
      {
         if(param1 && !param1.disposed)
         {
            if(param1 is IInteractiveWindow)
            {
               var_818 = IInteractiveWindow(param1).toolTipCaption;
               var_817 = IInteractiveWindow(param1).toolTipDelay;
            }
            else
            {
               var_818 = param1.caption;
               var_817 = 500;
            }
            _mouse.x = var_119.mouseX;
            _mouse.y = var_119.mouseY;
            getMousePositionRelativeTo(param1,_mouse,var_972);
            if(var_818 != null && var_818 != "")
            {
               if(var_293 == null)
               {
                  var_293 = new Timer(var_817,1);
                  var_293.addEventListener(TimerEvent.TIMER,showToolTip);
               }
               var_293.reset();
               var_293.start();
            }
         }
         return super.begin(param1,param2);
      }
      
      protected function hideToolTip() : void
      {
         if(var_228 != null && true)
         {
            var_228.destroy();
            var_228 = null;
         }
      }
   }
}
