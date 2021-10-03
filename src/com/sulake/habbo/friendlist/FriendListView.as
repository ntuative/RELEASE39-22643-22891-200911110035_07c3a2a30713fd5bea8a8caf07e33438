package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.utils.Dictionary;
   
   public class FriendListView
   {
      
      private static const const_1297:String = "noconvinfo";
      
      private static const const_1296:String = "messageinput";
       
      
      private var var_1291:int = -1;
      
      private var var_746:IWindowContainer;
      
      private var _friendList:HabboFriendList;
      
      private var var_1290:int = -1;
      
      private var var_1033:ITextWindow;
      
      private var var_1034:FriendListTabsView;
      
      private var var_35:IFrameWindow;
      
      private var var_234:IWindowContainer;
      
      private var var_1585:Boolean;
      
      public function FriendListView(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         var_1034 = new FriendListTabsView(_friendList);
      }
      
      private function prepare() : void
      {
         var_35 = IFrameWindow(_friendList.getXmlWindow("main_window"));
         var_35.findChildByTag("close").procedure = onWindowClose;
         var_746 = IWindowContainer(var_35.content.findChildByName("main_content"));
         var_234 = IWindowContainer(var_35.content.findChildByName("footer"));
         var_1034.prepare(var_746);
         var_35.procedure = onWindow;
         var_35.content.setParamFlag(HabboWindowParam.const_1271,false);
         var_35.content.setParamFlag(HabboWindowParam.const_1161,true);
         var_35.header.setParamFlag(HabboWindowParam.const_836,false);
         var_35.header.setParamFlag(HabboWindowParam.const_826,true);
         var_35.content.setParamFlag(HabboWindowParam.const_836,false);
         var_35.content.setParamFlag(HabboWindowParam.const_826,true);
         var_35.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
         var_1033 = ITextWindow(var_35.findChildByName("info_text"));
         var_1033.text = "";
         _friendList.refreshButton(var_35,"open_edit_ctgs",true,null,0);
         var_35.title.color = 4294623744;
         var_35.title.textColor = 4287851525;
         refresh("prepare");
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close window");
         var_35.visible = false;
         _friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
      }
      
      public function showInfo(param1:WindowEvent, param2:String) : void
      {
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.type == WindowMouseEvent.const_29)
         {
            var_1033.text = "";
         }
         else if(_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            var_1033.text = param2;
         }
      }
      
      public function openFriendList() : void
      {
         if(var_35 == null)
         {
            prepare();
            _friendList.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.FRIENDLIST,var_35));
         }
         else
         {
            var_35.visible = true;
            var_35.activate();
         }
      }
      
      private function getTitleBar() : IWindowContainer
      {
         return var_35.findChildByName("titlebar") as IWindowContainer;
      }
      
      public function get tabsView() : FriendListTabsView
      {
         return var_1034;
      }
      
      private function refreshWindowSize() : void
      {
         this.var_1585 = true;
         var_234.visible = false;
         var_234.y = Util.getLowestPoint(var_35.content);
         var_234.width = _friendList.tabs.windowWidth;
         var_234.visible = true;
         var_35.content.height = Util.getLowestPoint(var_35.content);
         var_35.content.width = _friendList.tabs.windowWidth - 10;
         var_35.header.width = _friendList.tabs.windowWidth - 10;
         var_35.height = var_35.content.height + 30;
         var_35.width = _friendList.tabs.windowWidth;
         this.var_1585 = false;
         var_35.scaler.setParamFlag(HabboWindowParam.const_533,false);
         var_35.scaler.setParamFlag(HabboWindowParam.const_758,this._friendList.tabs.findSelectedTab() != null);
         var_1290 = var_35.height;
         var_1291 = var_35.width;
         Logger.log("RESIZED: " + _friendList.tabs.windowWidth);
      }
      
      public function isFriendListOpen() : Boolean
      {
         return var_35 != null && false;
      }
      
      public function refresh(param1:String) : void
      {
         if(this.var_35 == null)
         {
            return;
         }
         var_1034.refresh(param1);
         refreshWindowSize();
      }
      
      public function get mainWindow() : IWindowContainer
      {
         return var_35;
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_46 || param2 != var_35)
         {
            return;
         }
         if(this.var_1585)
         {
            return;
         }
         var _loc3_:int = var_1290 == -1 ? 0 : int(0 - var_1290);
         var _loc4_:int = var_1291 == -1 ? 0 : int(0 - var_1291);
         _friendList.tabs.tabContentHeight = Math.max(100,_friendList.tabs.tabContentHeight + _loc3_);
         _friendList.tabs.windowWidth = Math.max(147,_friendList.tabs.windowWidth + _loc4_);
         refresh("resize: " + _loc3_);
      }
      
      private function onEditCategoriesButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.preferences}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Edit categories clicked");
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.friendlist.pref",new Dictionary(),_loc3_.stageX,_loc3_.stageY);
      }
      
      public function close() : void
      {
         if(this.var_35 != null)
         {
            this.var_35.visible = false;
         }
      }
   }
}
