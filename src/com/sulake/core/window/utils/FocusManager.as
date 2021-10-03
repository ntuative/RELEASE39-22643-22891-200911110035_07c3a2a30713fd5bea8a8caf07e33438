package com.sulake.core.window.utils
{
   import com.sulake.core.window.components.IFocusWindow;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   
   public class FocusManager extends ChildEntityArrayReader implements IWindowFocusManagerService
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_192:Stage;
      
      public function FocusManager(param1:DisplayObject)
      {
         var_192 = Stage(param1);
         var_192.addEventListener(Event.ACTIVATE,onActivateEvent);
         var_192.addEventListener(FocusEvent.FOCUS_OUT,onFocusEvent);
         var_192.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,onFocusEvent);
         var_192.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,onFocusEvent);
         super();
      }
      
      private function onFocusEvent(param1:FocusEvent) : void
      {
         if(true)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function resolveNextFocusTarget() : IFocusWindow
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_-- != 0)
         {
            _loc2_ = var_39[_loc1_] as IFocusWindow;
            if(!_loc2_.disposed)
            {
               _loc2_.focus();
            }
            var_39.splice(_loc1_,1);
         }
         return _loc2_;
      }
      
      public function removeFocusWindow(param1:IFocusWindow) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = var_39.indexOf(param1);
            if(_loc2_ > -1)
            {
               var_39.splice(_loc2_,1);
            }
         }
         if(true)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function onActivateEvent(param1:Event) : void
      {
         if(true)
         {
            resolveNextFocusTarget();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function registerFocusWindow(param1:IFocusWindow) : void
      {
         if(param1 != null)
         {
            if(var_39.indexOf(param1) == -1)
            {
               var_39.push(param1);
               if(true)
               {
                  param1.focus();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_192.removeEventListener(Event.ACTIVATE,onActivateEvent);
            var_192.removeEventListener(FocusEvent.FOCUS_OUT,onFocusEvent);
            var_192.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,onFocusEvent);
            var_192.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,onFocusEvent);
            var_192 = null;
            _disposed = true;
            var_39 = null;
         }
      }
   }
}
