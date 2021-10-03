package com.sulake.habbo.toolbar
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.IWindowContext;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class ToolbarBarMenuAnimator
   {
      
      private static const const_1039:Number = 90;
      
      private static const const_732:int = 50;
      
      private static const const_1038:Number = 25;
      
      private static const const_1053:int = 50;
      
      private static const const_171:Boolean = true;
       
      
      private var var_534:Timer;
      
      private var var_957:ToolbarView;
      
      private var var_462:Array;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _toolbarSize:Number;
      
      private var var_535:Object;
      
      private var var_287:Array;
      
      private var _itemList:Object;
      
      private var var_461:Array;
      
      public function ToolbarBarMenuAnimator(param1:IHabboWindowManager, param2:ToolbarView)
      {
         var_287 = new Array();
         _itemList = new Object();
         var_535 = new Object();
         var_461 = new Array();
         var_462 = new Array();
         super();
         _windowManager = param1;
         var_957 = param2;
         var_534 = new Timer(const_1038);
         var_534.addEventListener(TimerEvent.TIMER,animationUpdate);
      }
      
      private function prepareWindowForScrollIn(param1:MenuAnimatorItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindow = param1.window;
         var _loc3_:String = param1.iconId;
         var _loc4_:Point = getDesktopOffset(_loc2_);
         var _loc5_:IDesktopWindow = _loc2_.context.getDesktopWindow();
         if(_loc5_ == null)
         {
            return;
         }
         _loc2_.x = -_loc2_.width - _loc4_.x;
      }
      
      private function getWindowByName(param1:String) : IWindow
      {
         var _loc3_:* = null;
         if(_windowManager == null)
         {
            return null;
         }
         var _loc2_:IWindow = _windowManager.getWindowByName(param1);
         if(_loc2_ == null)
         {
            _loc3_ = _windowManager.getWindowContextLayer(0);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.findWindowByName(param1);
            }
         }
         return _loc2_;
      }
      
      private function alignWindowToIcon(param1:IWindow, param2:IDesktopWindow, param3:MenuAnimatorItem) : void
      {
         var _loc4_:Point = getIconLoc(param3);
         param1.y = Math.max(0,Math.min(_loc4_.y + param3.windowOffsetFromIcon,param2.height - param1.height - param3.bottomMargin));
      }
      
      private function getOffsetLocationForMenu(param1:String, param2:IWindowContainer, param3:Number) : Point
      {
         var _loc4_:Point = new Point();
         var _loc5_:Point = new Point();
         param2.getGlobalPosition(_loc5_);
         var _loc6_:Point = new Point();
         var _loc7_:Point = new Point();
         var _loc8_:IWindow = param2.findChildByTag("toolbar_anchor_horizontal");
         if(_loc8_ != null && _loc8_.visible)
         {
            _loc8_.getGlobalPosition(_loc7_);
            _loc6_.x = _loc7_.x - _loc5_.x;
         }
         _loc8_ = param2.findChildByTag("toolbar_anchor_vertical");
         if(_loc8_ != null && _loc8_.visible)
         {
            _loc8_.getGlobalPosition(_loc7_);
            _loc6_.y = _loc7_.y - _loc5_.y;
         }
         _loc4_.subtract(_loc6_);
         return _loc4_;
      }
      
      private function registerWindow(param1:IWindowContainer, param2:String) : void
      {
         var _loc3_:int = var_462.indexOf(param2);
         if(_loc3_ > -1)
         {
            var_462.splice(_loc3_,1);
            var_461.splice(_loc3_,1);
         }
         var_461.push(param1.name);
         var_462.push(param2);
         param1.addEventListener(WindowEvent.const_434,windowEventListener);
         param1.addEventListener(WindowEvent.const_178,windowEventListener);
      }
      
      private function getWindowMenuId(param1:String) : String
      {
         return var_462[var_461.indexOf(param1)];
      }
      
      private function createItemObject(param1:String, param2:ToolbarIcon) : MenuAnimatorItem
      {
         var _loc4_:* = null;
         var _loc3_:MenuAnimatorItem = getItemObject(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new MenuAnimatorItem(param1,param2);
            _loc4_ = var_957.getIconByMenuId(param1);
            if(_loc4_ == null)
            {
               return null;
            }
            _loc3_.iconId = _loc4_.iconId;
            _loc3_.lockToIcon = _loc4_.menuLockedToIcon(param1);
            _itemList[_loc3_.menuId] = _loc3_;
            var_287.push(_loc3_.menuId);
         }
         return _loc3_;
      }
      
      public function removeItem(param1:String) : void
      {
         if(var_287.indexOf(param1) > -1)
         {
            if(const_171)
            {
               _itemList[param1].active = false;
               _itemList[param1].window = null;
            }
            else
            {
               _itemList[param1] = null;
               var_287.splice(var_287.indexOf(param1),1);
            }
         }
      }
      
      private function getIconLoc(param1:MenuAnimatorItem) : Point
      {
         var _loc2_:Point = var_957.getIconLoc(param1.iconId);
         if(param1.offsetLoc != null)
         {
            _loc2_.add(param1.offsetLoc);
         }
         return _loc2_;
      }
      
      public function hideWindow(param1:String, param2:IWindowContainer, param3:String, param4:Number) : void
      {
         if(param2 == null)
         {
            return;
         }
         _toolbarSize = param4;
         removeItem(param1);
         var _loc5_:Point = getWindowTargetOut(param2);
         if(_loc5_ != null)
         {
            param2.x = _loc5_.x;
            param2.y = _loc5_.y;
         }
         param2.visible = false;
      }
      
      private function getWindowName(param1:String) : String
      {
         return var_461[var_462.indexOf(param1)];
      }
      
      private function getDesktopOffset(param1:IWindow) : Point
      {
         if(param1 == null)
         {
            return new Point();
         }
         var _loc2_:Point = new Point();
         var _loc3_:Point = param1.position;
         param1.getGlobalPosition(_loc3_);
         if(!_loc3_.equals(param1.position))
         {
            _loc2_ = _loc3_.subtract(param1.position);
         }
         return _loc2_;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < var_287.length)
         {
            repositionWindow(var_287[_loc1_],true);
            _loc1_++;
         }
      }
      
      private function getWindowTargetIn(param1:MenuAnimatorItem) : Point
      {
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IWindow = param1.window;
         var _loc3_:String = param1.iconId;
         var _loc4_:Array = param1.yieldList;
         if(_loc2_ == null)
         {
            _loc2_ = getWindowByName(getWindowName(param1.menuId));
         }
         if(_loc2_ == null || _loc2_.disposed)
         {
            return null;
         }
         var _loc5_:IDesktopWindow = _loc2_.context.getDesktopWindow();
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:Point = new Point();
         var _loc7_:Point = getDesktopOffset(_loc2_);
         alignWindowToIcon(_loc2_,_loc5_,param1);
         _loc6_.x = _toolbarSize + param1.margin;
         _loc6_.y = _loc2_.y;
         _loc6_ = _loc6_.subtract(_loc7_);
         if(const_171)
         {
            if(_loc4_ != null)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.length)
               {
                  _loc9_ = getWindowByName(getWindowName(_loc4_[_loc8_]));
                  if(_loc9_ != null && _loc9_.visible == true)
                  {
                     _loc10_ = getDesktopOffset(_loc9_);
                     if(_loc9_.rectangle.right + _loc10_.x > _loc6_.x)
                     {
                        _loc6_.x = _loc9_.rectangle.right + _loc10_.x;
                     }
                  }
                  _loc8_++;
               }
            }
         }
         return _loc6_;
      }
      
      public function animateWindowOut(param1:ToolbarIcon, param2:String, param3:IWindowContainer, param4:String) : void
      {
         if(param3 == null)
         {
            return;
         }
         registerWindow(param3,param2);
         var _loc5_:MenuAnimatorItem = createItemObject(param2,param1);
         _loc5_.window = param3;
         _loc5_.active = true;
         _loc5_.visible = false;
         var _loc6_:Point = getWindowTargetOut(param3);
         if(_loc6_ != null)
         {
            _loc5_.target = _loc6_;
            animateWindow(_loc5_);
         }
      }
      
      public function dispose() : void
      {
         if(var_534 != null)
         {
            var_534.stop();
            var_534 = null;
         }
         _itemList = new Object();
         var_287 = new Array();
         var_461 = null;
         var_462 = null;
         _windowManager = null;
         var_957 = null;
      }
      
      private function registerDependentMenu(param1:String, param2:Array) : void
      {
         var _loc3_:* = null;
         if(!const_171)
         {
            return;
         }
         if(param2 == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_];
            if(true)
            {
               var_535[_loc3_] = new Array();
            }
            if(var_535[_loc3_].indexOf(param1) < 0)
            {
               var_535[_loc3_].push(param1);
            }
            _loc4_++;
         }
      }
      
      private function windowShouldAnimate(param1:IWindowContainer, param2:Number, param3:int, param4:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc5_:Point = param1.rectangle.topLeft.subtract(getDesktopOffset(param1));
         if(_loc5_.x > param2 + param3)
         {
            return false;
         }
         return true;
      }
      
      private function isOutsideScreen(param1:IWindow) : Boolean
      {
         return param1.x + param1.width < const_732 + _toolbarSize || param1.y < 0 || param1.desktop.width - param1.x < const_732 || param1.desktop.height - param1.y < const_1053;
      }
      
      private function repositionWindow(param1:String, param2:Boolean) : void
      {
         var _loc3_:MenuAnimatorItem = getItemObject(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IWindow = getWindowByName(getWindowName(param1));
         if(_loc4_ == null || !_loc3_.visible || !_loc4_.visible)
         {
            return;
         }
         if(_loc3_.lockToIcon)
         {
            alignWindowToIcon(_loc4_,_loc4_.context.getDesktopWindow(),_loc3_);
         }
         if(param2 && !isOutsideScreen(_loc4_) && !_loc3_.lockToIcon)
         {
            return;
         }
         var _loc5_:Point = getWindowTargetIn(_loc3_);
         if(_loc5_ == null)
         {
            return;
         }
         _loc4_.x = _loc5_.x;
         _loc4_.y = _loc5_.y;
      }
      
      public function windowEventListener(param1:WindowEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_461.length)
         {
            if(var_461[_loc2_] == param1.window.name)
            {
               _loc3_ = "null";
               if(false)
               {
                  _loc4_ = 0;
                  while(_loc4_ < var_535[_loc3_].length)
                  {
                     repositionWindow(var_535[_loc3_][_loc4_],false);
                     _loc4_++;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function getItemObject(param1:String) : MenuAnimatorItem
      {
         return _itemList[param1];
      }
      
      private function animateWindow(param1:MenuAnimatorItem) : void
      {
         if(param1.window == null)
         {
            return;
         }
         param1.window.visible = true;
         var_534.start();
      }
      
      private function animationUpdate(param1:TimerEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(false)
         {
            var_534.stop();
         }
         var _loc7_:int = 0;
         while(_loc7_ < var_287.length)
         {
            _loc2_ = _itemList["null"];
            if(_loc2_.active)
            {
               _loc3_ = _loc2_.window;
               _loc4_ = _loc2_.target;
               if(_loc3_ == null || _loc3_.disposed || _loc4_ == null)
               {
                  removeItem(_loc2_.menuId);
               }
               else if(_loc4_ != null)
               {
                  if(!isNaN(_loc4_.x))
                  {
                     _loc5_ = (_loc4_.x - _loc3_.x) / 2;
                     if(Math.abs(_loc5_) < 1)
                     {
                        _loc3_.x = _loc4_.x;
                     }
                     else
                     {
                        _loc3_.x += _loc5_;
                     }
                  }
                  if(!isNaN(_loc4_.y))
                  {
                     _loc6_ = (_loc4_.y - _loc3_.y) / 2;
                     if(Math.abs(_loc6_) < 1)
                     {
                        _loc3_.y = _loc4_.y;
                     }
                     else
                     {
                        _loc3_.y += _loc6_;
                     }
                  }
                  if((isNaN(_loc4_.x) || _loc3_.x == _loc4_.x) && (isNaN(_loc4_.x) || _loc3_.y == _loc4_.y))
                  {
                     _loc3_.visible = _loc2_.visible;
                     removeItem(_loc2_.menuId);
                  }
               }
            }
            _loc7_++;
         }
      }
      
      public function animateWindowIn(param1:ToolbarIcon, param2:String, param3:IWindowContainer, param4:String, param5:Number, param6:String, param7:Array = null) : void
      {
         if(param3 == null)
         {
            return;
         }
         if(const_171)
         {
            registerWindow(param3,param2);
            registerDependentMenu(param2,param7);
         }
         _toolbarSize = param5;
         param3.visible = true;
         if(!windowShouldAnimate(param3,param5,param1.windowMargin,param6))
         {
            positionWindow(param1,param2,param3,param4,param5,param7);
            return;
         }
         var _loc8_:MenuAnimatorItem = createItemObject(param2,param1);
         _loc8_.window = param3;
         _loc8_.iconId = param4;
         _loc8_.offsetLoc = getOffsetLocationForMenu(param2,param3,param5);
         if(const_171)
         {
            _loc8_.yieldList = param7;
         }
         _loc8_.active = true;
         _loc8_.visible = true;
         prepareWindowForScrollIn(_loc8_);
         var _loc9_:Point = getWindowTargetIn(_loc8_);
         if(_loc9_ != null)
         {
            _loc8_.target = _loc9_;
            animateWindow(_loc8_);
         }
      }
      
      public function positionWindow(param1:ToolbarIcon, param2:String, param3:IWindowContainer, param4:String, param5:Number, param6:Array = null) : void
      {
         if(param3 == null)
         {
            return;
         }
         if(const_171)
         {
            registerWindow(param3,param2);
            registerDependentMenu(param2,param6);
         }
         _toolbarSize = param5;
         var _loc7_:MenuAnimatorItem = createItemObject(param2,param1);
         _loc7_.active = true;
         _loc7_.visible = true;
         _loc7_.window = param3;
         _loc7_.iconId = param4;
         _loc7_.offsetLoc = getOffsetLocationForMenu(param2,param3,param5);
         if(const_171)
         {
            _loc7_.yieldList = param6;
         }
         prepareWindowForScrollIn(_loc7_);
         var _loc8_:Point = getWindowTargetIn(_loc7_);
         if(_loc8_ != null)
         {
            _loc7_.target = null;
            param3.x = _loc8_.x;
            param3.y = _loc8_.y;
         }
         removeItem(param2);
      }
      
      private function getWindowTargetOut(param1:IWindowContainer) : Point
      {
         var _loc2_:IDesktopWindow = param1.context.getDesktopWindow();
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Point = new Point();
         _loc3_.x = -param1.width;
         _loc3_.y = param1.y;
         return _loc3_.subtract(getDesktopOffset(param1));
      }
   }
}
