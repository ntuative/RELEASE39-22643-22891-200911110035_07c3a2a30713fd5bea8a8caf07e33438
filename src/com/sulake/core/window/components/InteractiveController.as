package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.MouseCursorType;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class InteractiveController extends WindowController implements IInteractiveWindow
   {
      
      protected static var var_297:Array;
       
      
      protected var var_2038:uint = 0;
      
      protected var var_818:String = "";
      
      protected var var_393:Array;
      
      protected var var_817:uint = 500;
      
      public function InteractiveController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         param5 |= 0;
         var_393 = new Array();
         var_393[0] = MouseCursorType.const_280;
         var_393[1] = MouseCursorType.const_37;
         var_393[2] = MouseCursorType.const_280;
         var_393[3] = MouseCursorType.const_280;
         var_393[4] = MouseCursorType.const_37;
         var_393[5] = MouseCursorType.const_37;
         var_393[6] = MouseCursorType.const_280;
         if(var_297 == null)
         {
            var_297 = new Array();
            var_297[0] = WindowState.const_83;
            var_297[1] = WindowState.const_69;
            var_297[2] = WindowState.const_73;
            var_297[3] = WindowState.const_59;
            var_297[4] = WindowState.const_44;
            var_297[5] = WindowState.const_84;
            var_297[6] = WindowState.const_62;
         }
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public static function processInteractiveWindowEvents(param1:IInteractiveWindow, param2:Event) : void
      {
         if(param1.toolTipCaption != "")
         {
            if(param2.type == MouseEvent.MOUSE_OVER)
            {
               param1.context.getWindowServices().getToolTipAgentService().begin(param1);
            }
            else if(param2.type != MouseEvent.MOUSE_MOVE)
            {
               if(param2.type == MouseEvent.MOUSE_OUT)
               {
                  param1.context.getWindowServices().getToolTipAgentService().end(param1);
               }
            }
         }
      }
      
      public static function writeInteractiveWindowProperties(param1:IInteractiveWindow, param2:Array) : Array
      {
         param2.push(new PropertyStruct("tool_tip_caption",param1.toolTipCaption,"String",param1.toolTipCaption != ""));
         param2.push(new PropertyStruct("tool_tip_delay",param1.toolTipDelay,"uint",param1.toolTipDelay != 500));
         return param2;
      }
      
      public static function readInteractiveWindowProperties(param1:IInteractiveWindow, param2:Array) : void
      {
         var _loc4_:* = null;
         var _loc3_:uint = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param2[_loc5_] as PropertyStruct;
            switch(_loc4_.key)
            {
               case "tool_tip_caption":
                  param1.toolTipCaption = _loc4_.value as String;
                  break;
               case "tool_tip_delay":
                  param1.toolTipDelay = _loc4_.value as uint;
                  break;
               case "mouse_cursor_hovering":
                  param1.setMouseCursorByState(WindowState.const_73,_loc4_.value as uint);
                  break;
               case "mouse_cursor_pressed":
                  param1.setMouseCursorByState(WindowState.const_84,_loc4_.value as uint);
                  break;
               case "mouse_cursor_disabled":
                  param1.setMouseCursorByState(WindowState.const_62,_loc4_.value as uint);
                  break;
            }
            _loc5_++;
         }
      }
      
      public function set toolTipDelay(param1:uint) : void
      {
         var_817 = param1;
      }
      
      public function hideToolTip() : void
      {
      }
      
      override public function get properties() : Array
      {
         return writeInteractiveWindowProperties(this,super.properties);
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param1 == this)
         {
            processInteractiveWindowEvents(this,param2);
         }
         return super.update(param1,param2);
      }
      
      public function get toolTipCaption() : String
      {
         return var_818;
      }
      
      public function set toolTipCaption(param1:String) : void
      {
         var_818 = param1 == null ? "" : param1;
      }
      
      override public function set properties(param1:Array) : void
      {
         readInteractiveWindowProperties(this,param1);
         super.properties = param1;
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         var _loc2_:int = 0;
         while(_loc2_-- > 0)
         {
            if((param1 & 0) > 0)
            {
               return var_393[_loc2_];
            }
         }
         return MouseCursorType.const_37;
      }
      
      public function setMouseCursorByState(param1:uint, param2:uint) : void
      {
         var _loc3_:int = var_297.indexOf(param1);
         if(_loc3_ > -1)
         {
            var_393[_loc3_] = param2;
         }
      }
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
      }
      
      public function get toolTipDelay() : uint
      {
         return var_817;
      }
      
      public function set mouseCursorType(param1:uint) : void
      {
         var_2038 = param1;
      }
      
      public function get mouseCursorType() : uint
      {
         return var_2038;
      }
   }
}
