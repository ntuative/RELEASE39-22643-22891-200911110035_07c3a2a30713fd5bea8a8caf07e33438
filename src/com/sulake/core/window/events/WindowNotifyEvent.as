package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   
   public class WindowNotifyEvent extends WindowEvent
   {
      
      public static const const_1222:String = "WN_CREATED";
      
      public static const const_929:String = "WN_DISABLE";
      
      public static const const_837:String = "WN_DEACTIVATED";
      
      public static const const_735:String = "WN_OPENED";
      
      public static const const_921:String = "WN_CLOSED";
      
      public static const const_888:String = "WN_DESTROY";
      
      public static const const_1459:String = "WN_ARRANGED";
      
      public static const const_406:String = "WN_PARENT_RESIZED";
      
      public static const const_843:String = "WN_ENABLE";
      
      public static const const_938:String = "WN_RELOCATE";
      
      public static const const_923:String = "WN_FOCUS";
      
      public static const const_753:String = "WN_PARENT_RELOCATED";
      
      public static const const_376:String = "WN_PARAM_UPDATED";
      
      public static const const_678:String = "WN_PARENT_ACTIVATED";
      
      public static const const_232:String = "WN_RESIZED";
      
      public static const const_932:String = "WN_CLOSE";
      
      public static const const_790:String = "WN_PARENT_REMOVED";
      
      public static const const_225:String = "WN_CHILD_RELOCATED";
      
      public static const const_883:String = "WN_ENABLED";
      
      public static const const_226:String = "WN_CHILD_RESIZED";
      
      public static const const_797:String = "WN_MINIMIZED";
      
      public static const const_815:String = "WN_DISABLED";
      
      public static const const_207:String = "WN_CHILD_ACTIVATED";
      
      public static const const_373:String = "WN_STATE_UPDATED";
      
      public static const const_646:String = "WN_UNSELECTED";
      
      public static const const_339:String = "WN_STYLE_UPDATED";
      
      public static const const_1481:String = "WN_UPDATE";
      
      public static const const_378:String = "WN_PARENT_ADDED";
      
      public static const const_557:String = "WN_RESIZE";
      
      public static const const_532:String = "WN_CHILD_REMOVED";
      
      public static const const_1472:String = "";
      
      public static const const_812:String = "WN_RESTORED";
      
      public static const const_288:String = "WN_SELECTED";
      
      public static const const_841:String = "WN_MINIMIZE";
      
      public static const const_741:String = "WN_FOCUSED";
      
      public static const const_1136:String = "WN_LOCK";
      
      public static const const_276:String = "WN_CHILD_ADDED";
      
      public static const const_798:String = "WN_UNFOCUSED";
      
      public static const const_354:String = "WN_RELOCATED";
      
      public static const const_939:String = "WN_DEACTIVATE";
      
      public static const const_1096:String = "WN_CRETAE";
      
      public static const const_831:String = "WN_RESTORE";
      
      public static const const_312:String = "WN_ACTVATED";
      
      public static const const_1220:String = "WN_LOCKED";
      
      public static const const_369:String = "WN_SELECT";
      
      public static const const_913:String = "WN_MAXIMIZE";
      
      public static const const_830:String = "WN_OPEN";
      
      public static const const_544:String = "WN_UNSELECT";
      
      public static const const_1359:String = "WN_ARRANGE";
      
      public static const const_1174:String = "WN_UNLOCKED";
      
      public static const const_1460:String = "WN_UPDATED";
      
      public static const const_736:String = "WN_ACTIVATE";
      
      public static const const_1100:String = "WN_UNLOCK";
      
      public static const const_820:String = "WN_MAXIMIZED";
      
      public static const const_849:String = "WN_DESTROYED";
      
      public static const const_906:String = "WN_UNFOCUS";
       
      
      public function WindowNotifyEvent(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false)
      {
         super(param1,param2,param3,false,param4);
      }
      
      override public function toString() : String
      {
         return formatToString("WindowNotifyEvent","type","cancelable");
      }
      
      override public function clone() : Event
      {
         return new WindowNotifyEvent(type,_window,var_1444,cancelable);
      }
   }
}
