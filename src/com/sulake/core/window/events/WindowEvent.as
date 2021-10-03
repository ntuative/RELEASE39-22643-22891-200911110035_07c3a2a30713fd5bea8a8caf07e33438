package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   
   public class WindowEvent extends Event
   {
      
      public static const const_319:String = "WE_CHILD_RESIZED";
      
      public static const const_1117:String = "WE_CLOSE";
      
      public static const const_1070:String = "WE_DESTROY";
      
      public static const const_246:String = "WE_CHANGE";
      
      public static const const_1099:String = "WE_RESIZE";
      
      public static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
      
      public static const const_1348:String = "WE_PARENT_RESIZE";
      
      public static const const_88:String = "WE_UPDATE";
      
      public static const const_1279:String = "WE_MAXIMIZE";
      
      public static const const_372:String = "WE_DESTROYED";
      
      public static const const_914:String = "WE_UNSELECT";
      
      public static const const_1122:String = "WE_MAXIMIZED";
      
      public static const const_1426:String = "WE_UNLOCKED";
      
      public static const const_417:String = "WE_CHILD_REMOVED";
      
      public static const const_199:String = "WE_OK";
      
      public static const const_46:String = "WE_RESIZED";
      
      public static const const_1210:String = "WE_ACTIVATE";
      
      public static const const_241:String = "WE_ENABLED";
      
      public static const const_431:String = "WE_CHILD_RELOCATED";
      
      public static const const_1089:String = "WE_CREATE";
      
      public static const const_634:String = "WE_SELECT";
      
      public static const const_149:String = "";
      
      public static const const_1338:String = "WE_LOCKED";
      
      public static const const_1319:String = "WE_PARENT_RELOCATE";
      
      public static const const_1386:String = "WE_CHILD_REMOVE";
      
      public static const const_1364:String = "WE_CHILD_RELOCATE";
      
      public static const const_1344:String = "WE_LOCK";
      
      public static const const_278:String = "WE_FOCUSED";
      
      public static const const_679:String = "WE_UNSELECTED";
      
      public static const const_825:String = "WE_DEACTIVATED";
      
      public static const const_1215:String = "WE_MINIMIZED";
      
      public static const const_1449:String = "WE_ARRANGED";
      
      public static const const_1435:String = "WE_UNLOCK";
      
      public static const const_1482:String = "WE_ATTACH";
      
      public static const const_1103:String = "WE_OPEN";
      
      public static const const_1104:String = "WE_RESTORE";
      
      public static const const_1397:String = "WE_PARENT_RELOCATED";
      
      public static const const_1236:String = "WE_RELOCATE";
      
      public static const const_1318:String = "WE_CHILD_RESIZE";
      
      public static const const_1466:String = "WE_ARRANGE";
      
      public static const const_1157:String = "WE_OPENED";
      
      public static const const_1147:String = "WE_CLOSED";
      
      public static const const_1413:String = "WE_DETACHED";
      
      public static const const_1316:String = "WE_UPDATED";
      
      public static const const_1069:String = "WE_UNFOCUSED";
      
      public static const const_434:String = "WE_RELOCATED";
      
      public static const const_1152:String = "WE_DEACTIVATE";
      
      public static const const_178:String = "WE_DISABLED";
      
      public static const const_478:String = "WE_CANCEL";
      
      public static const const_578:String = "WE_ENABLE";
      
      public static const const_1129:String = "WE_ACTIVATED";
      
      public static const const_1260:String = "WE_FOCUS";
      
      public static const const_1412:String = "WE_DETACH";
      
      public static const const_1170:String = "WE_RESTORED";
      
      public static const const_1160:String = "WE_UNFOCUS";
      
      public static const const_51:String = "WE_SELECTED";
      
      public static const const_1266:String = "WE_PARENT_RESIZED";
      
      public static const const_1246:String = "WE_CREATED";
      
      public static const const_1421:String = "WE_ATTACHED";
      
      public static const const_1143:String = "WE_MINIMIZE";
      
      public static const WINDOW_EVENT_DISABLE:String = "WE_DISABLE";
       
      
      protected var _type:String = "";
      
      protected var var_1444:IWindow;
      
      protected var _window:IWindow;
      
      protected var var_1226:Boolean;
      
      public function WindowEvent(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false, param5:Boolean = false)
      {
         _type = param1;
         _window = param2;
         var_1444 = param3;
         var_1226 = false;
         super(param1,param4,param5);
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return var_1226;
      }
      
      public function get related() : IWindow
      {
         return var_1444;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      override public function get type() : String
      {
         return _type;
      }
      
      override public function toString() : String
      {
         return formatToString("WindowEvent","type","bubbles","cancelable","window");
      }
      
      override public function clone() : Event
      {
         return new WindowEvent(_type,window,related,bubbles,cancelable);
      }
      
      public function preventWindowOperation() : void
      {
         if(cancelable)
         {
            var_1226 = true;
            stopImmediatePropagation();
            return;
         }
         throw new Error("Attempted to prevent window operation that is not canceable!");
      }
   }
}
