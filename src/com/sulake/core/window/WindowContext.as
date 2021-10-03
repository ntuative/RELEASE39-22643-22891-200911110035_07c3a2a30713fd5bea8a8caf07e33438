package com.sulake.core.window
{
   import com.sulake.core.Core;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.components.DesktopController;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.SubstituteParentController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.enum.WindowStyle;
   import com.sulake.core.window.enum.WindowType;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import com.sulake.core.window.utils.IInternalWindowServices;
   import com.sulake.core.window.utils.IMouseCursor;
   import com.sulake.core.window.utils.IWindowParser;
   import com.sulake.core.window.utils.InternalWindowServices;
   import com.sulake.core.window.utils.KeyboardEventQueue;
   import com.sulake.core.window.utils.MouseCursorControl;
   import com.sulake.core.window.utils.MouseEventQueue;
   import com.sulake.core.window.utils.WindowParser;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowContext implements IWindowContext, IDisposable, ICoreUpdateReceiver
   {
      
      public static const const_1322:uint = 2;
      
      private static var var_951:Factory;
      
      public static var var_1437:IMouseCursor;
      
      public static var var_1216:KeyboardEventQueue;
      
      public static const const_1327:uint = 1;
      
      private static var var_140:IWindowRenderer;
      
      public static const const_1436:uint = 0;
      
      public static const const_1404:uint = 3;
      
      public static var var_813:MouseEventQueue;
      
      public static const ERROR_UNKNOWN_WINDOW_TYPE:uint = 4;
       
      
      protected var var_2049:IWindowFactory;
      
      private var _disposed:Boolean = false;
      
      private var var_644:WindowController;
      
      private var var_569:Date;
      
      protected var var_2047:IWindowParser;
      
      protected var _lastError:Error;
      
      protected var var_2048:IInternalWindowServices;
      
      protected var var_68:WindowController;
      
      protected var var_2050:uint = 0;
      
      protected var _desktopWindow:IDesktopWindow;
      
      private var var_256:ErrorReportStorage;
      
      protected var var_2125:Boolean = true;
      
      protected var var_981:SubstituteParentController;
      
      private var var_2093:Point;
      
      protected var var_294:DisplayObjectContainer;
      
      private var _name:String;
      
      protected var _localization:ICoreLocalizationManager;
      
      private var var_529:Point;
      
      public function WindowContext(param1:String, param2:IWindowRenderer, param3:IWindowFactory, param4:ICoreLocalizationManager, param5:DisplayObjectContainer, param6:Rectangle)
      {
         var_529 = new Point();
         var_2093 = new Point();
         super();
         _name = param1;
         var_140 = param2;
         _localization = param4;
         var_294 = param5;
         var_2048 = new InternalWindowServices(this,param5);
         var_2049 = param3;
         var_2047 = new WindowParser(this);
         var_256 = Core.instance.stateStorage;
         var_569 = new Date();
         if(var_951 == null)
         {
            var_951 = new Factory();
         }
         if(var_813 == null)
         {
            var_813 = new MouseEventQueue(param5);
         }
         if(var_1216 == null)
         {
            var_1216 = new KeyboardEventQueue(param5);
         }
         if(param6 == null)
         {
            param6 = new Rectangle(0,0,800,600);
         }
         _desktopWindow = new DesktopController("_CONTEXT_DESKTOP_" + _name,"Desktop " + _name,WindowType.const_447,WindowStyle.const_223,WindowParam.const_94,this,param6,null,null);
         var_294.addChild(_desktopWindow.getDisplayObject());
         var_294.doubleClickEnabled = true;
         var_294.addEventListener(Event.RESIZE,stageResizedHandler);
         var_68 = WindowController(_desktopWindow);
         var_981 = new SubstituteParentController("WindowContext::SubstituteParent","",0,0,0,this,new Rectangle(0,0,0,0),null,null,null,null,0);
      }
      
      public function destroy(param1:IWindow) : Boolean
      {
         if(param1 == _desktopWindow)
         {
            _desktopWindow = null;
         }
         if(param1.state != WindowState.const_442)
         {
            param1.destroy();
         }
         var_140.removeRenderable(param1 as WindowController);
         return true;
      }
      
      public function getDesktopWindow() : IDesktopWindow
      {
         return _desktopWindow;
      }
      
      public function removeLocalizationListener(param1:String, param2:IWindow) : void
      {
         _localization.removeListener(param1,param2 as ILocalizable);
      }
      
      public function render(param1:uint) : void
      {
         var_140.update(param1);
      }
      
      public function dispose() : void
      {
         _disposed = true;
         var_294.removeEventListener(Event.RESIZE,stageResizedHandler);
         var_294.removeChild(IGraphicContextHost(_desktopWindow).getGraphicContext(true) as DisplayObject);
         _desktopWindow.destroy();
         _desktopWindow = null;
         var_981.destroy();
         var_981 = null;
         var_951 = null;
         var_140 = null;
         var_68 = null;
         var_256 = null;
         var_569 = null;
      }
      
      public function getWindowParser() : IWindowParser
      {
         return var_2047;
      }
      
      private function stageResizedHandler(param1:Event) : void
      {
         if(_desktopWindow != null && true)
         {
            if(var_294 is Stage)
            {
               _desktopWindow.width = Stage(var_294).stageWidth;
               _desktopWindow.height = Stage(var_294).stageHeight;
            }
            else
            {
               _desktopWindow.width = var_294.width;
               _desktopWindow.height = var_294.height;
            }
         }
      }
      
      public function registerLocalizationListener(param1:String, param2:IWindow) : void
      {
         _localization.registerListener(param1,param2 as ILocalizable);
      }
      
      public function invalidate(param1:IWindow, param2:Rectangle, param3:uint) : Boolean
      {
         var_140.addToRenderQueue(WindowController(param1),param2,param3);
         return true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getWindowFactory() : IWindowFactory
      {
         return var_2049;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Point = new Point();
         var _loc7_:MouseEventQueue = WindowContext.var_813;
         _loc7_.begin();
         var_529.x = -1;
         var_529.y = -1;
         while(true)
         {
            _loc2_ = _loc7_.next() as MouseEvent;
            if(_loc2_ == null)
            {
               break;
            }
            if(_loc2_.stageX != var_529.x || _loc2_.stageY != var_529.y)
            {
               var_529.x = _loc2_.stageX;
               var_529.y = _loc2_.stageY;
               _loc5_ = new Array();
               _desktopWindow.groupChildrenUnderPoint(var_529,_loc5_);
            }
            _loc3_ = _loc5_ != null ? int(_loc5_.length) : 0;
            if(_loc3_ == 1)
            {
               if(_loc2_.type == MouseEvent.MOUSE_MOVE)
               {
                  if(var_68 != _desktopWindow && true)
                  {
                     var_68.getGlobalPosition(_loc6_);
                     var_68.update(var_68,new MouseEvent(MouseEvent.MOUSE_OUT,false,false,_loc2_.stageX - _loc6_.x,_loc2_.stageY - _loc6_.y,null,_loc2_.altKey,_loc2_.ctrlKey,_loc2_.shiftKey,_loc2_.buttonDown,_loc2_.delta));
                     var_68 = WindowController(_desktopWindow);
                  }
               }
            }
            while(--_loc3_ > -1)
            {
               _loc4_ = passMouseEvent(WindowController(_loc5_[_loc3_]),_loc2_);
               if(_loc4_ != null && _loc4_.visible)
               {
                  if(_loc2_.type == MouseEvent.MOUSE_MOVE)
                  {
                     if(_loc4_ != var_68)
                     {
                        if(true)
                        {
                           var_68.getGlobalPosition(_loc6_);
                           var_68.update(var_68,new MouseEvent(MouseEvent.MOUSE_OUT,false,false,_loc2_.stageX - _loc6_.x,_loc2_.stageY - _loc6_.y,null,_loc2_.altKey,_loc2_.ctrlKey,_loc2_.shiftKey,_loc2_.buttonDown,_loc2_.delta));
                        }
                        if(!_loc4_.disposed)
                        {
                           _loc4_.getGlobalPosition(_loc6_);
                           _loc4_.update(_loc4_,new MouseEvent(MouseEvent.MOUSE_OVER,false,false,_loc2_.stageX - _loc6_.x,_loc2_.stageY - _loc6_.y,null,_loc2_.altKey,_loc2_.ctrlKey,_loc2_.shiftKey,_loc2_.buttonDown,_loc2_.delta));
                        }
                        if(!_loc4_.disposed)
                        {
                           var_68 = _loc4_;
                        }
                     }
                  }
                  else if(_loc2_.type == MouseEvent.MOUSE_UP)
                  {
                     if(var_68 && true)
                     {
                        var_256["last_mouse_click_time"] = new Date().getTime().toString();
                        var_256["last_mouse_click_target"] = "undefined: " + var_68.toString();
                     }
                  }
                  else if(_loc2_.type == MouseEvent.CLICK)
                  {
                     if(var_68 && true)
                     {
                        var_256["last_mouse_click_time"] = new Date().getTime().toString();
                        var_256["last_mouse_click_target"] = "undefined: " + var_68.toString();
                     }
                  }
                  if(_loc2_.altKey)
                  {
                     if(var_68)
                     {
                        Logger.log("HOVER: undefined");
                     }
                  }
                  if(_loc4_ != _desktopWindow)
                  {
                     _loc2_.stopPropagation();
                     _loc7_.remove();
                  }
                  break;
               }
            }
         }
         _loc7_.end();
      }
      
      protected function handleError(param1:uint, param2:Error) : void
      {
         _lastError = param2;
         var_2050 = param1;
         if(var_2125)
         {
            throw param2;
         }
      }
      
      public function getMouseCursor() : IMouseCursor
      {
         if(var_1437 == null)
         {
            var_1437 = new MouseCursorControl(var_294 as Stage);
         }
         return var_1437;
      }
      
      public function getLastError() : Error
      {
         return _lastError;
      }
      
      public function getWindowServices() : IInternalWindowServices
      {
         return var_2048;
      }
      
      private function passMouseEvent(param1:WindowController, param2:MouseEvent) : WindowController
      {
         if(param1.disposed)
         {
            return null;
         }
         if(!param1.testParamFlag(WindowParam.const_43))
         {
            return null;
         }
         if(param1.testStateFlag(WindowState.const_62))
         {
            return null;
         }
         var _loc3_:Point = new Point(param2.stageX,param2.stageY);
         param1.convertPointFromGlobalToLocalSpace(_loc3_);
         var _loc4_:BitmapData = var_140.getDrawBufferForRenderable(param1);
         if(!param1.validateLocalPointIntersection(_loc3_,_loc4_))
         {
            return null;
         }
         if(param1.testParamFlag(WindowParam.const_341))
         {
            if(param1.parent != null)
            {
               return passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         var _loc5_:Boolean = true;
         switch(param2.type)
         {
            case MouseEvent.MOUSE_DOWN:
               var_644 = param1;
               break;
            case MouseEvent.CLICK:
               if(var_644 != param1)
               {
                  _loc5_ = false;
               }
               else
               {
                  var_644 = null;
               }
               break;
            case MouseEvent.DOUBLE_CLICK:
               if(var_644 != param1)
               {
                  _loc5_ = false;
               }
               else
               {
                  var_644 = null;
               }
         }
         if(_loc5_)
         {
            if(!param1.update(param1,param2))
            {
               if(param1.parent)
               {
                  return passMouseEvent(WindowController(param1.parent),param2);
               }
            }
         }
         return param1;
      }
      
      public function getLastErrorCode() : uint
      {
         return var_2050;
      }
      
      public function findWindowByName(param1:String) : IWindow
      {
         return _desktopWindow.findChildByName(param1);
      }
      
      public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array = null, param11:Array = null) : IWindow
      {
         var _loc12_:Class = var_951.getWindowClassByType(param3);
         if(_loc12_ == null)
         {
            handleError(WindowContext.ERROR_UNKNOWN_WINDOW_TYPE,new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
            return null;
         }
         if(param8 == null)
         {
            if(param5 & 0)
            {
               param8 = var_981;
            }
         }
         return new _loc12_(param1,param2,param3,param4,param5,this,param6,param8 != null ? param8 : _desktopWindow,param7,param10,param11,param9);
      }
   }
}
