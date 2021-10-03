package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.enum.WindowType;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ToolbarIcon
   {
       
      
      private var var_1411:ToolbarIconGroup;
      
      private var var_942:Boolean = false;
      
      private var var_1947:String;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_944:String = "-1";
      
      private var _window:IBitmapWrapperWindow;
      
      private var _state:String = "-1";
      
      private var var_100:IRegionWindow;
      
      private var var_789:String;
      
      private var var_1557:int;
      
      private var var_638:Timer;
      
      private var var_1412:Array;
      
      private var var_943:ToolbarIconBouncer;
      
      private var _windowManager:IHabboWindowManager;
      
      private var name_1:IEventDispatcher;
      
      private var var_2088:Array;
      
      private var var_328:ToolbarBarMenuAnimator;
      
      private var var_379:ToolbarIconAnimator;
      
      private var var_525:Array;
      
      private var var_790:Array;
      
      private var var_1178:Timer;
      
      private var var_2152:Boolean = true;
      
      private var var_941:Array;
      
      private var var_1946:int;
      
      private var var_788:String = "-1";
      
      private var var_88:Number = 0;
      
      private var _y:Number = 0;
      
      public function ToolbarIcon(param1:ToolbarIconGroup, param2:IHabboWindowManager, param3:IAssetLibrary, param4:String, param5:IEventDispatcher, param6:ToolbarBarMenuAnimator)
      {
         var_525 = new Array();
         var_790 = new Array();
         var_2088 = new Array();
         var_943 = new ToolbarIconBouncer(0.8,1);
         super();
         var_1411 = param1;
         _windowManager = param2;
         _assetLibrary = param3;
         var_789 = param4;
         name_1 = param5;
         var_328 = param6;
         var_1178 = new Timer(40,40);
         var_1178.addEventListener(TimerEvent.TIMER,updateBouncer);
         var_100 = param2.createWindow("TOOLBAR_ICON_" + param4 + "_REGION","",WindowType.const_380,HabboWindowStyle.const_38,0 | 0 | 0,new Rectangle(0,0,1,1),onMouseEvent) as IRegionWindow;
         var_100.background = true;
         var_100.alphaTreshold = 0;
         var_100.visible = false;
         _window = IBitmapWrapperWindow(param2.createWindow("TOOLBAR_ICON_" + param4,"",HabboWindowType.const_200,HabboWindowStyle.const_38,HabboWindowParam.const_38,new Rectangle(0,0,1,1),onMouseEvent,0));
         var_100.addChild(_window);
         _window.addEventListener(WindowEvent.const_46,onWindowResized);
      }
      
      private function getStateObject(param1:String) : StateItem
      {
         return var_1412[var_941.indexOf(param1)];
      }
      
      public function positionWindow(param1:String, param2:IWindowContainer, param3:Number, param4:String) : void
      {
         if(var_328 != null)
         {
            var_328.positionWindow(this,param1,param2,var_789,param3,getMenuYieldList(param1));
         }
      }
      
      private function onWindowResized(param1:WindowEvent) : void
      {
         var_100.width = _window.width;
         var_100.height = _window.height;
      }
      
      public function get windowOffsetFromIcon() : Number
      {
         return var_1946;
      }
      
      public function get iconId() : String
      {
         return var_789;
      }
      
      public function set state(param1:String) : void
      {
         _state = param1;
         exists = true;
         setAnimator();
         setTooltip();
      }
      
      public function setIcon(param1:Boolean = true) : void
      {
         exists = param1;
         setAnimator();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_100 != null)
         {
            var_100.dispose();
            var_100 = null;
         }
         var_525 = null;
         var_790 = null;
         exists = false;
         _windowManager = null;
         name_1 = null;
         var_328 = null;
         var_379 = null;
      }
      
      public function dockMenu(param1:String, param2:Array = null, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         if(var_525.indexOf(param1) < 0)
         {
            var_525.push(param1);
            _loc4_ = new MenuSettingsItem(param1,param2,param3);
            var_790.push(_loc4_);
         }
      }
      
      private function onMouseEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         if(!var_942)
         {
            return;
         }
         var _loc3_:StateItem = getCurrentStateObject();
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               if(name_1 != null)
               {
                  _loc4_ = new HabboToolbarEvent(HabboToolbarEvent.const_55);
                  _loc4_.iconId = var_789;
                  name_1.dispatchEvent(_loc4_);
               }
               break;
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
               if(false)
               {
                  if(_loc3_.hasStateOver)
                  {
                     state = _loc3_.stateOver;
                  }
                  else
                  {
                     state = var_944;
                  }
               }
               break;
            case WindowMouseEvent.const_29:
               if(false)
               {
                  if(_loc3_.hasDefaultState)
                  {
                     state = _loc3_.defaultState;
                  }
                  else
                  {
                     state = var_788;
                  }
               }
         }
      }
      
      public function docksMenu(param1:String) : Boolean
      {
         return var_525.indexOf(param1) > -1;
      }
      
      public function menuLockedToIcon(param1:String) : Boolean
      {
         if(!docksMenu(param1))
         {
            return false;
         }
         var _loc2_:MenuSettingsItem = var_790[var_525.indexOf(param1)];
         return _loc2_.lockToIcon;
      }
      
      public function set exists(param1:Boolean) : void
      {
         var_942 = param1;
         if(var_100 != null)
         {
            var_100.visible = var_942;
         }
      }
      
      private function setTooltip() : void
      {
         if(var_100 == null)
         {
            return;
         }
         var _loc1_:StateItem = getCurrentStateObject();
         if(_loc1_ != null && _loc1_.tooltip != null)
         {
            var_100.toolTipCaption = "${toolbar.icon.tooltip." + _loc1_.tooltip + "}";
         }
         else
         {
            var_100.toolTipCaption = "${toolbar.icon.tooltip." + var_1947.toLowerCase() + "}";
         }
         var_100.toolTipDelay = 100;
      }
      
      public function animateWindowIn(param1:String, param2:IWindowContainer, param3:Number, param4:String, param5:Point) : void
      {
         if(var_328 != null)
         {
            var_328.animateWindowIn(this,param1,param2,var_789,param3,param4,getMenuYieldList(param1));
         }
      }
      
      private function updateAnimator(param1:Event) : void
      {
         if(var_379 != null && _window != null)
         {
            var_379.update(_window);
            if(var_379.hasNextState())
            {
               state = var_379.nextState;
            }
         }
      }
      
      public function defineFromXML(param1:XML) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var_1412 = new Array();
         var_941 = new Array();
         var_1947 = param1.@id;
         var_1946 = int(param1.@window_offset_from_icon);
         var_1557 = int(param1.@window_margin);
         var _loc2_:XMLList = param1.elements("state");
         if(_loc2_.length() > 0)
         {
            if(param1.attribute("state_over").length() > 0)
            {
               var_944 = param1.@state_over;
            }
            if(param1.attribute("state_default").length() > 0)
            {
               var_788 = param1.@state_default;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length())
            {
               _loc4_ = _loc2_[_loc3_];
               _loc5_ = new StateItem(_loc4_,param1.@id.toLowerCase());
               var_941.push(_loc5_.id);
               var_1412.push(_loc5_);
               if(_loc3_ == 0)
               {
                  if(var_944 == "-1")
                  {
                     var_944 = _loc5_.id;
                  }
                  if(var_788 == "-1")
                  {
                     var_788 = _loc5_.id;
                  }
               }
               _loc3_++;
            }
         }
         _state = var_788;
      }
      
      public function setIconBitmapData(param1:BitmapData = null) : void
      {
         if(_window != null && param1 != null)
         {
            _window.width = param1.width;
            _window.height = param1.height;
            _window.bitmap = param1;
         }
         exists = true;
         if(param1 == null)
         {
            setAnimator();
         }
      }
      
      public function hideWindow(param1:String, param2:IWindowContainer, param3:Number, param4:String) : void
      {
         if(var_328 != null)
         {
            var_328.hideWindow(param1,param2,var_789,param3);
         }
      }
      
      public function changePosition(param1:Boolean, param2:Number, param3:int) : void
      {
         if(var_100 == null || _window == null)
         {
            return;
         }
         if(param1)
         {
            _y = param2 + (param3 - 0) / 2;
            var_100.y = _y;
         }
         else
         {
            var_88 = param2 + (param3 - 0) / 2;
            var_100.x = var_88;
         }
      }
      
      public function animateWindowOut(param1:String, param2:IWindowContainer, param3:String) : void
      {
         if(var_328 != null)
         {
            var_328.animateWindowOut(this,param1,param2,param3);
         }
      }
      
      private function updateBouncer(param1:Event) : void
      {
         if(var_943 != null && _window != null)
         {
            var_943.update();
            _window.y = var_943.location;
         }
      }
      
      public function get exists() : Boolean
      {
         return var_942;
      }
      
      private function setAnimator() : void
      {
         if(var_638 != null)
         {
            var_638.stop();
            var_638 = null;
         }
         var _loc1_:StateItem = getCurrentStateObject();
         if(_loc1_ != null && var_942)
         {
            if(_loc1_.frames == null)
            {
               return;
            }
            var_379 = new ToolbarIconAnimator(_loc1_,_assetLibrary,_window,var_88,_y);
            if(false)
            {
               var_638 = new Timer(_loc1_.timer);
               var_638.addEventListener(TimerEvent.TIMER,updateAnimator);
               var_638.start();
            }
            if(_loc1_.bounce)
            {
               var_943.reset(-7);
               var_1178.reset();
               var_1178.start();
            }
         }
         else
         {
            var_379 = null;
            _window.bitmap = null;
         }
      }
      
      public function get windowMargin() : Number
      {
         return var_1557 + var_1411.windowMargin;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      private function getCurrentStateObject() : StateItem
      {
         return getStateObject(_state);
      }
      
      public function get window() : IWindow
      {
         return var_100;
      }
      
      public function get x() : Number
      {
         return var_88;
      }
      
      private function getMenuYieldList(param1:String) : Array
      {
         if(!docksMenu(param1))
         {
            return null;
         }
         var _loc2_:MenuSettingsItem = var_790[var_525.indexOf(param1)];
         return _loc2_.yieldList;
      }
      
      public function get group() : ToolbarIconGroup
      {
         return var_1411;
      }
   }
}
