package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tabs;
   
   public class MyRoomsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var var_442:IDropMenuWindow;
      
      private var var_2148:IWindowContainer;
      
      private var _navigator:HabboNavigator;
      
      public function MyRoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function getSearchTypeForIndex(param1:int) : int
      {
         if(param1 == 1)
         {
            return Tabs.const_547;
         }
         if(param1 == 2)
         {
            return Tabs.const_680;
         }
         if(param1 == 3)
         {
            return Tabs.const_541;
         }
         if(param1 == 4)
         {
            return Tabs.const_498;
         }
         return Tabs.const_190;
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = var_442 == null ? 0 : int(var_442.selection);
         Logger.log("Me subNavi selection changed: " + _loc1_);
         _navigator.mainViewCtrl.startSearch(Tabs.const_214,getSearchTypeForIndex(_loc1_));
      }
      
      private function prepareSubNavi() : void
      {
         var _loc1_:Array = new Array();
         _loc1_.push(_navigator.getText("navigator.navisel.myrooms"));
         _loc1_.push(_navigator.getText("navigator.navisel.wherearemyfriends"));
         _loc1_.push(_navigator.getText("navigator.navisel.myfriendsrooms"));
         _loc1_.push(_navigator.getText("navigator.navisel.myfavourites"));
         _loc1_.push(_navigator.getText("navigator.navisel.visitedrooms"));
         var_442.populate(_loc1_);
         var_442.selection = 0;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc3_:IWindowContainer = param1.getChildByName("me_header") as IWindowContainer;
         if(var_442 == null)
         {
            var_442 = IDropMenuWindow(_loc3_.findChildByName("meSubNavi"));
            var_442.procedure = onChangeSubNavi;
            prepareSubNavi();
         }
         _loc3_.visible = true;
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
         var _loc3_:IWindowContainer = param1.getChildByName("me_footer") as IWindowContainer;
         Util.setProc(_loc3_,"create_room_but",onCreateRoomClick);
         _navigator.refreshButton(_loc3_,"create_room",true,null,0);
         _loc3_.visible = true;
      }
      
      private function onCreateRoomClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.send(new CanCreateRoomMessageComposer());
      }
      
      private function onChangeSubNavi(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_51)
         {
            return;
         }
         startSearch();
      }
      
      public function tabSelected() : void
      {
         if(this.var_442 != null)
         {
            this.var_442.selection = 0;
         }
      }
   }
}
