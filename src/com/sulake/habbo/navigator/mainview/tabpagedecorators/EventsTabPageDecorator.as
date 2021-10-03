package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.domain.Tabs;
   
   public class EventsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_403:IDropMenuWindow;
      
      public function EventsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      private function onChangeFilter(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_51)
         {
            return;
         }
         startSearch();
      }
      
      public function tabSelected() : void
      {
         if(this.var_403 != null)
         {
            this.var_403.selection = 0;
         }
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = var_403 == null ? 0 : int(var_403.selection);
         Logger.log("Event filter changed: " + _loc1_);
         _navigator.mainViewCtrl.startSearch(Tabs.const_300,Tabs.const_367,_loc1_ < 1 ? "-1" : _loc1_ + "");
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc3_:IWindowContainer = param1.getChildByName("events_header") as IWindowContainer;
         if(var_403 == null)
         {
            var_403 = IDropMenuWindow(_loc3_.findChildByName("eventCtgFilter"));
            var_403.procedure = onChangeFilter;
            prepareEventTypes();
         }
         _loc3_.visible = true;
      }
      
      private function prepareEventTypes() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:Array = new Array();
         _loc1_.push(_navigator.getText("navigator.navisel.alllatestevents"));
         var _loc3_:int = 1;
         while(_loc3_ < 100)
         {
            _loc4_ = "roomevent_type_" + _loc3_;
            _loc5_ = _navigator.getText(_loc4_);
            if(_loc5_ == null || _loc5_ == _loc4_)
            {
               break;
            }
            _loc1_.push(_loc5_);
            _loc3_++;
         }
         var_403.populate(_loc1_);
         var_403.selection = 0;
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
   }
}
