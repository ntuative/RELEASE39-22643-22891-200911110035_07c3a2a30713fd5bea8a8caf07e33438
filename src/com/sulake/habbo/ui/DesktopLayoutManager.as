package com.sulake.habbo.ui
{
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.geom.Rectangle;
   
   public class DesktopLayoutManager
   {
       
      
      private const const_1496:String = "room_widget";
      
      private const const_1498:String = "room_desktop_layout_container";
      
      private const const_1021:String = "room_view";
      
      private var var_606:int = 50;
      
      private var var_2079:XML = null;
      
      private var var_65:IWindowContainer;
      
      public function DesktopLayoutManager()
      {
         super();
      }
      
      public function addRoomView(param1:IWindow) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:IWindowContainer = var_65.getChildByTag(const_1021) as IWindowContainer;
         if(_loc2_ == null)
         {
            return false;
         }
         _loc2_.addChild(param1);
         return true;
      }
      
      public function get roomViewRect() : Rectangle
      {
         if(var_65 == null)
         {
            return null;
         }
         var _loc1_:IWindowContainer = var_65.findChildByTag(const_1021) as IWindowContainer;
         if(_loc1_ != null)
         {
            return _loc1_.rectangle.clone();
         }
         return null;
      }
      
      public function dispose() : void
      {
         if(var_65 != null)
         {
            var_65.dispose();
         }
      }
      
      public function set toolbarSize(param1:int) : void
      {
         var_606 = param1;
      }
      
      public function set toolbarOrientation(param1:String) : void
      {
         var _loc2_:Rectangle = new Rectangle();
         switch(param1)
         {
            case "LEFT":
               _loc2_.x = var_606;
               _loc2_.width = var_65.desktop.width - var_606;
               _loc2_.y = 0;
               _loc2_.height = var_65.desktop.height;
               break;
            case "RIGHT":
               _loc2_.x = 0;
               _loc2_.width = var_65.desktop.width - var_606;
               _loc2_.y = 0;
               _loc2_.height = var_65.desktop.height;
               break;
            case "TOP":
               _loc2_.x = 0;
               _loc2_.width = var_65.desktop.width;
               _loc2_.y = var_606;
               _loc2_.height = var_65.desktop.height - var_606;
               break;
            case "BOTTOM":
               _loc2_.x = 0;
               _loc2_.width = var_65.desktop.width;
               _loc2_.y = 0;
               _loc2_.height = var_65.desktop.height - var_606;
         }
         if(!_loc2_.isEmpty())
         {
            var_65.rectangle = _loc2_;
         }
      }
      
      public function setLayout(param1:XML, param2:IHabboWindowManager) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         if(param1 == null || param2 == null)
         {
            throw new Error("Unable to set room desktop layout.");
         }
         var_2079 = param1.copy();
         var_65 = (param2 as ICoreWindowManager).buildFromXML(param1,0) as IWindowContainer;
         if(var_65 == null)
         {
            throw new Error("Failed to build layout from XML.");
         }
         var_65.width = var_65.desktop.width;
         var_65.height = var_65.desktop.height;
         var _loc3_:IWindowContainer = var_65.desktop as IWindowContainer;
         _loc3_.addChildAt(var_65,0);
         var _loc5_:int = 0;
         while(_loc5_ < var_65.numChildren)
         {
            _loc4_ = var_65.getChildAt(_loc5_);
            _loc6_ = false || false;
            if(_loc4_.testParamFlag(_loc6_))
            {
               _loc4_.addEventListener(WindowEvent.const_319,trimContainer);
            }
            _loc5_++;
         }
      }
      
      private function trimContainer(param1:WindowEvent) : void
      {
         var _loc2_:IWindowContainer = param1.window as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.numChildren != 1)
         {
            return;
         }
         var _loc3_:IWindow = _loc2_.getChildAt(0);
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.width = _loc3_.width;
         _loc2_.height = _loc3_.height;
      }
      
      public function addWidgetWindow(param1:IWindow) : Boolean
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Array = param1.tags;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(String(_loc2_[_loc4_]).indexOf(const_1496) == 0)
            {
               _loc3_ = _loc2_[_loc4_] as String;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc5_:IWindowContainer = var_65.getChildByTag(_loc3_) as IWindowContainer;
         if(_loc5_ == null)
         {
            return false;
         }
         param1.x = 0;
         param1.y = 0;
         _loc5_.addChild(param1);
         _loc5_.width = param1.width;
         _loc5_.height = param1.height;
         return true;
      }
      
      public function getRoomView() : IWindow
      {
         if(var_65 == null)
         {
            return null;
         }
         var _loc1_:IWindowContainer = var_65.findChildByTag(const_1021) as IWindowContainer;
         if(_loc1_ != null && _loc1_.numChildren > 0)
         {
            return _loc1_.getChildAt(0);
         }
         return null;
      }
   }
}
