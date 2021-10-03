package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.Util;
   import flash.geom.Rectangle;
   
   public class ConfirmDialogView implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1335:Array;
      
      private var _window:IFrameWindow;
      
      private var var_1322:Object;
      
      private var var_1323:Function;
      
      public function ConfirmDialogView(param1:IFrameWindow, param2:Object, param3:Function, param4:Array)
      {
         super();
         this._window = param1;
         this.var_1323 = param3;
         this.var_1322 = param2;
         this.var_1335 = param4;
         _window.findChildByTag("close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onCancel);
         _window.findChildByName("cancel").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onCancel);
         _window.findChildByName("ok").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onOk);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set message(param1:String) : void
      {
         ITextWindow(_window.findChildByName("message")).text = param1;
      }
      
      private function onCancel(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         var_1323.apply(var_1322,[param1].concat(var_1335));
         dispose();
      }
      
      public function show() : void
      {
         var _loc1_:Rectangle = Util.getLocationRelativeTo(_window.desktop,_window.width,_window.height);
         _window.x = _loc1_.x;
         _window.y = _loc1_.y;
         _window.visible = true;
         _window.activate();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window != null)
         {
            _window.destroy();
            _window = null;
         }
         var_1322 = null;
         var_1323 = null;
      }
   }
}
