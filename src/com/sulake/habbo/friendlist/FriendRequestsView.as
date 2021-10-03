package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptBuddyMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineBuddyMessageComposer;
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   import com.sulake.habbo.friendlist.domain.FriendRequest;
   
   public class FriendRequestsView implements ITabView, IFriendRequestsView
   {
      
      private static const const_1308:String = "no_reqs_info";
       
      
      private var var_1363:IContainerButtonWindow;
      
      private var _friendList:HabboFriendList;
      
      private var var_1362:IContainerButtonWindow;
      
      private var _list:IItemListWindow;
      
      public function FriendRequestsView()
      {
         super();
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         var _loc2_:* = null;
         _list = param1;
         for each(_loc2_ in _friendList.friendRequests.requests)
         {
            getRequestEntry(_loc2_);
            refreshRequestEntry(_loc2_);
            param1.addListItem(_loc2_.view);
         }
         _friendList.friendRequests.refreshShading();
      }
      
      private function onAcceptAllButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         _friendList.view.showInfo(param1,"${friendlist.tip.acceptall}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Accept all clicked");
         if(_friendList.categories.getFriendCount(false) + _friendList.friendRequests.requests.length > _friendList.friendRequests.limit)
         {
            _friendList.showLimitReachedAlert();
            return;
         }
         var _loc3_:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
         for each(_loc4_ in _friendList.friendRequests.requests)
         {
            if(_loc4_.state != FriendRequest.const_274 && _loc4_.state != FriendRequest.const_291)
            {
               _loc3_.addAcceptedRequest(_loc4_.requestId);
               _loc4_.state = FriendRequest.const_274;
               refreshRequestEntry(_loc4_);
            }
         }
         _friendList.send(_loc3_);
         refresh();
      }
      
      public function fillFooter(param1:IWindowContainer) : void
      {
         var_1363 = IContainerButtonWindow(param1.findChildByName("accept_all_but"));
         var_1362 = IContainerButtonWindow(param1.findChildByName("reject_all_but"));
         var_1362.procedure = onDismissAllButtonClick;
         var_1363.procedure = onAcceptAllButtonClick;
         refreshButtons();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
      }
      
      public function refreshShading(param1:FriendRequest, param2:Boolean) : void
      {
         if(_list == null)
         {
            return;
         }
         param1.view.color = _friendList.laf.getRowShadingColor(FriendListTab.const_90,param2);
         setButtonBg(param1.view,"reject");
         setButtonBg(param1.view,"accept");
      }
      
      private function setButtonBg(param1:IWindowContainer, param2:String) : void
      {
         var _loc3_:IWindow = param1.findChildByName(param2);
         if(_loc3_ != null)
         {
            _loc3_.color = param1.color;
         }
      }
      
      private function refresh() : void
      {
         refreshButtons();
         _friendList.refreshToolBarIcon();
      }
      
      private function onDeclineButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.decline}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("decline clicked: " + _loc3_);
         var _loc4_:FriendRequest = _friendList.friendRequests.getRequest(_loc3_);
         _loc4_.state = FriendRequest.const_291;
         var _loc5_:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
         _loc5_.addDeclinedRequest(_loc3_);
         _friendList.send(_loc5_);
         refreshRequestEntry(_loc4_);
         refresh();
      }
      
      private function getRequestEntry(param1:FriendRequest) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_friendList.getXmlWindow("friend_request_entry"));
         param1.view = _loc2_;
      }
      
      public function tabClicked(param1:int) : void
      {
         if(_list == null)
         {
            return;
         }
         _friendList.friendRequests.clearAndUpdateView(true);
      }
      
      public function refreshRequestEntry(param1:FriendRequest) : void
      {
         if(_list == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = param1.view;
         Util.hideChildren(_loc2_);
         _friendList.refreshText(_loc2_,"requester_name_text",true,param1.requesterName);
         if(param1.state == FriendRequest.const_126)
         {
            _friendList.refreshIcon(_loc2_,"accept",true,onAcceptButtonClick,param1.requestId);
            _friendList.refreshIcon(_loc2_,"reject",true,onDeclineButtonClick,param1.requestId);
         }
         else if(param1.state == FriendRequest.const_274)
         {
            _friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.accepted}");
         }
         else if(param1.state == FriendRequest.const_291)
         {
            _friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.declined}");
         }
         else if(param1.state == FriendRequest.const_746)
         {
            _friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.failed}");
         }
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:* = _friendList.friendRequests.getCountOfOpenRequests() > 0;
         setEnabled(var_1363,_loc1_);
         setEnabled(var_1362,_loc1_);
      }
      
      private function onDismissAllButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         _friendList.view.showInfo(param1,"${friendlist.tip.declineall}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Dismiss all clicked");
         var _loc3_:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
         _friendList.send(_loc3_);
         for each(_loc4_ in _friendList.friendRequests.requests)
         {
            if(_loc4_.state != FriendRequest.const_274 && _loc4_.state != FriendRequest.const_291)
            {
               _loc4_.state = FriendRequest.const_291;
               refreshRequestEntry(_loc4_);
            }
         }
         refresh();
      }
      
      public function removeRequest(param1:FriendRequest) : void
      {
         if(_list == null)
         {
            return;
         }
         _list.removeListItem(param1.view);
         refreshButtons();
      }
      
      public function addRequest(param1:FriendRequest) : void
      {
         if(_list == null)
         {
            return;
         }
         getRequestEntry(param1);
         refreshRequestEntry(param1);
         _list.addListItem(param1.view);
         _friendList.friendRequests.refreshShading();
         refreshButtons();
      }
      
      private function onAcceptButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.accept}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("accept clicked: " + _loc3_);
         var _loc4_:FriendRequest = _friendList.friendRequests.getRequest(_loc3_);
         _loc4_.state = FriendRequest.const_274;
         if(_friendList.categories.getFriendCount(false) >= _friendList.friendRequests.limit)
         {
            _friendList.showLimitReachedAlert();
            return;
         }
         var _loc5_:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
         _loc5_.addAcceptedRequest(_loc4_.requestId);
         _friendList.send(_loc5_);
         refreshRequestEntry(_loc4_);
         refresh();
      }
      
      public function getEntryCount() : int
      {
         return _friendList.friendRequests.getCountOfOpenRequests();
      }
      
      private function setEnabled(param1:IContainerButtonWindow, param2:Boolean) : void
      {
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
   }
}
