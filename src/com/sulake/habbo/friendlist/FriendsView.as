package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.friendlist.domain.Friend;
   import com.sulake.habbo.friendlist.domain.FriendCategory;
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FriendsView implements ITabView, IFriendsView
   {
      
      public static const const_589:String = "bg";
       
      
      private var var_1602:IContainerButtonWindow;
      
      private var var_1601:IContainerButtonWindow;
      
      private var var_1599:IContainerButtonWindow;
      
      private var var_1600:IContainerButtonWindow;
      
      private var var_333:AvatarPopupCtrl;
      
      private var _friendList:HabboFriendList;
      
      private var _list:IItemListWindow;
      
      public function FriendsView()
      {
         super();
      }
      
      private function isEnableInviteButton(param1:Array) : Boolean
      {
         var _loc2_:* = null;
         if(param1.length < 1)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(!_loc2_.online)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onCategoryClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Category clicked: " + param2.name + ", " + param2.tags[0]);
         if(param2.tags.length == 0)
         {
            param2 = param2.parent;
         }
         Logger.log("Category id: " + param2.name + ", " + param2.tags[0]);
         var _loc3_:int = param2.tags[0];
         Logger.log("Cat id: " + _loc3_);
         var _loc4_:FriendCategory = _friendList.categories.findCategory(_loc3_);
         _loc4_.setOpen(!_loc4_.open);
         this.refreshList();
         this._friendList.view.refresh("Cat open/closed");
      }
      
      private function isEnableMinimailButton(param1:Array) : Boolean
      {
         return _friendList.isEmbeddedMinimailEnabled() || param1.length == 1;
      }
      
      private function onInviteButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.invite}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         new RoomInviteView(_friendList).show();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
         var_333 = new AvatarPopupCtrl(_friendList);
      }
      
      private function refreshCatIcon(param1:IWindowContainer, param2:String, param3:Boolean, param4:int, param5:int) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         _friendList.refreshButton(param1,param2,param3,onCategoryClick,param4);
         if(param3)
         {
            _loc6_ = ITextWindow(param1.findChildByName("caption"));
            _loc7_ = IWindow(param1.findChildByName(param2));
            _loc7_.x = _loc6_.textWidth + param5;
         }
      }
      
      public function fillFooter(param1:IWindowContainer) : void
      {
         var_1601 = initButton("open_minimail",onMinimailButtonClick,param1);
         var_1599 = initButton("open_homepage",onHomeButtonClick,param1);
         var_1602 = initButton("room_invite",onInviteButtonClick,param1);
         var_1600 = initButton("remove_friend",onRemoveButtonClick,param1);
         refreshButtons();
      }
      
      private function refreshFriendEntry(param1:FriendCategory, param2:Friend) : void
      {
         var _loc3_:IWindowContainer = param2.view;
         _loc3_.id = param2.id;
         var _loc4_:IWindow = _loc3_.findChildByName(const_589);
         _loc4_.procedure = onFriendClick;
         _loc4_.visible = true;
         if(param2.selected)
         {
            _loc4_.color = _friendList.laf.getSelectedEntryBgColor();
         }
         ITextWindow(param2.view.findChildByName("name")).textColor = _friendList.laf.getFriendTextColor(param2.selected);
         _friendList.refreshText(_loc3_,"name",true,param2.name);
         _friendList.refreshButton(_loc3_,"start_chat",param2.online,onChatButtonClick,param2.id);
         _friendList.refreshButton(_loc3_,"follow_friend",param2.followingAllowed,onFollowButtonClick,param2.id);
         refreshFigure(_loc3_,param2);
      }
      
      private function isEnableHomeButton(param1:Array) : Boolean
      {
         return param1.length == 1;
      }
      
      private function refreshPageLink(param1:IWindowContainer, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc5_:String = "page." + param2;
         var _loc6_:ITextWindow = ITextWindow(param1.getChildByName(_loc5_));
         if(_loc6_ == null)
         {
            _loc6_ = ITextWindow(_friendList.getXmlWindow("pagelink"));
            _loc6_.name = _loc5_;
            param1.addChild(_loc6_);
         }
         _loc6_.underline = param2 != param3;
         _loc6_.text = "" + (param2 * 0 + 1) + "-" + ("" + (param2 + 1) * 0);
         _loc6_.id = param2;
         _loc6_.procedure = onPageLinkClick;
         _loc6_.width = _loc6_.textWidth + 5;
         _loc6_.color = _friendList.laf.getRowShadingColor(FriendListTab.const_79,param4);
         _loc6_.visible = true;
      }
      
      private function refreshFigure(param1:IWindowContainer, param2:Friend) : void
      {
         var _loc4_:* = null;
         var _loc3_:IBitmapWrapperWindow = param1.getChildByName(HabboFriendList.const_161) as IBitmapWrapperWindow;
         if(param2.figure == null || param2.figure == "")
         {
            _loc3_.visible = false;
         }
         else
         {
            if(param2.face == null)
            {
               param2.face = _friendList.getAvatarFaceBitmap(param2.figure);
            }
            if(_loc3_.bitmap == null)
            {
               _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height);
            }
            if(_loc3_.tags[0] != param2.figure)
            {
               _loc3_.tags.splice(0,_loc3_.tags.length);
               _loc3_.tags.push(param2.figure);
               _loc3_.bitmap.fillRect(_loc3_.bitmap.rect,0);
               _loc4_ = param2.face;
               _loc3_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(0,0),null,null,true);
            }
            else
            {
               Logger.log("Figure unchanged: " + _loc3_.tags[0]);
            }
            _loc3_.visible = true;
         }
      }
      
      public function refreshList() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         if(_list == null)
         {
            return;
         }
         _list.autoArrangeItems = false;
         var _loc1_:int = 0;
         for each(_loc2_ in _friendList.categories.getCategories())
         {
            refreshEntry(true,_loc1_,_loc2_,null);
            _loc1_++;
            if(_loc2_.open)
            {
               _loc3_ = _loc2_.getStartFriendIndex();
               _loc4_ = _loc2_.getEndFriendIndex();
               _loc5_ = _loc3_;
               while(_loc5_ < _loc4_)
               {
                  refreshEntry(true,_loc1_,_loc2_,_loc2_.friends[_loc5_]);
                  _loc1_++;
                  _loc5_++;
               }
            }
         }
         while(true)
         {
            _loc6_ = refreshEntry(false,_loc1_,null,null);
            if(_loc6_)
            {
               break;
            }
            _loc1_++;
         }
         _list.autoArrangeItems = true;
         refreshButtons();
      }
      
      private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.compose}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:Array = _friendList.categories.getSelectedFriends();
         if(_loc3_.length == 0)
         {
            Logger.log("No friend found when minimail clicked");
            if(_friendList.isEmbeddedMinimailEnabled())
            {
               if(false)
               {
                  ExternalInterface.call("FlashExternalInterface.openHabblet","minimail","#mail/inbox/");
               }
            }
            return;
         }
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length && _loc6_ < 50)
         {
            _loc5_.push(_loc3_[_loc6_].id);
            _loc6_++;
         }
         _loc4_["recipientid"] = _loc5_.join(",");
         _loc4_["random"] = "" + Math.round(Math.random() * 100000000);
         var _loc7_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_friendList.isEmbeddedMinimailEnabled())
         {
            if(false)
            {
               ExternalInterface.call("FlashExternalInterface.openHabblet","minimail","#mail/compose/" + _loc4_["recipientid"] + "/" + _loc4_["random"] + "/");
            }
         }
         else
         {
            _friendList.openHabboWebPage("link.format.mail.compose",_loc4_,_loc7_.stageX,_loc7_.stageY);
         }
      }
      
      private function onFriendClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2 == null)
         {
            return;
         }
         if(param2.id == 0)
         {
            param2 = param2.parent;
            if(param2 == null)
            {
               return;
            }
         }
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            _loc3_ = _friendList.categories.findFriend(param2.id);
            this.var_333.setData(_loc3_.online,_loc3_.name,_loc3_.motto,_loc3_.figure,_loc3_.lastAccess);
            this.var_333.showPopup(_friendList.view.mainWindow,_loc3_.view);
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            this.var_333.closePopup();
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK || param1.type == WindowMouseEvent.const_216)
         {
            _loc4_ = _friendList.categories.findFriend(param2.id);
            _loc4_.selected = !_loc4_.selected;
            refreshButtons();
            refreshList();
            if(param1.type == WindowMouseEvent.const_216 && _loc4_.online)
            {
               _friendList.messenger.startConversation(_loc4_.id);
            }
         }
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:Array = _friendList.categories.getSelectedFriends();
         setEnabled(var_1601,isEnableMinimailButton(_loc1_));
         setEnabled(var_1599,isEnableHomeButton(_loc1_));
         setEnabled(var_1602,isEnableInviteButton(_loc1_));
         setEnabled(var_1600,isEnableRemoveButton(_loc1_));
      }
      
      private function onChatButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.im}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("chat clicked: " + param2.name + ", " + param2.id);
         _friendList.messenger.startConversation(param2.id);
      }
      
      private function refreshPager(param1:FriendCategory, param2:Boolean) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.view.findChildByName("pager"));
         if(param1.getPageCount() < 2 || !param1.open)
         {
            Logger.log("PAGER NOT VISIBLE: " + param1.open + ", " + param1.getPageCount());
            _loc3_.visible = false;
            return;
         }
         _loc3_.visible = true;
         Util.hideChildren(_loc3_);
         var _loc4_:int = 0;
         while(_loc4_ < param1.getPageCount())
         {
            refreshPageLink(_loc3_,_loc4_,param1.pageIndex,param2);
            _loc4_++;
         }
         Util.layoutChildrenInArea(_loc3_,_loc3_.width,15);
         _loc3_.height = Util.getLowestPoint(_loc3_);
      }
      
      public function getEntryCount() : int
      {
         return _friendList.categories.getFriendCount(true);
      }
      
      private function onHomeButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.home}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:Friend = _friendList.categories.getSelectedFriend();
         if(_loc3_ == null)
         {
            Logger.log("No friend found when home clicked");
            return;
         }
         var _loc4_:Dictionary = new Dictionary();
         _loc4_["ID"] = "" + _loc3_.id;
         var _loc5_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.userpage",_loc4_,_loc5_.stageX,_loc5_.stageY);
      }
      
      private function onRemoveButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.remove}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         new FriendRemoveView(_friendList).show();
      }
      
      private function onPageLinkClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:ITextWindow = ITextWindow(param2);
         var _loc4_:int = _loc3_.parent.parent.tags[0];
         var _loc5_:int = _loc3_.id;
         Logger.log("Page link clicked: " + _loc4_ + ", " + _loc5_);
         var _loc6_:FriendCategory = _friendList.categories.findCategory(_loc4_);
         _loc6_.pageIndex = _loc5_;
         this.refreshList();
      }
      
      private function isEnableRemoveButton(param1:Array) : Boolean
      {
         return param1.length > 0;
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         _list = param1;
         this.refreshList();
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:FriendCategory, param4:Friend) : Boolean
      {
         var _loc5_:* = param2 % 2 == 1;
         var _loc6_:IWindowContainer = _list.getListItemAt(param2) as IWindowContainer;
         if(_loc6_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc6_ = IWindowContainer(_friendList.getXmlWindow("friend_entry"));
            _list.addListItem(_loc6_);
         }
         Util.hideChildren(_loc6_);
         if(!param1)
         {
            _loc6_.height = 0;
            _loc6_.visible = false;
            return false;
         }
         _loc6_.height = 20;
         _loc6_.visible = true;
         var _loc7_:IWindow = _loc6_.findChildByName(const_589);
         _loc7_.color = _friendList.laf.getRowShadingColor(FriendListTab.const_79,_loc5_);
         if(param4 == null)
         {
            param3.view = _loc6_;
            this.refreshCategoryEntry(param3,_loc5_);
         }
         else
         {
            param4.view = _loc6_;
            this.refreshFriendEntry(param3,param4);
         }
         return false;
      }
      
      public function tabClicked(param1:int) : void
      {
      }
      
      private function initButton(param1:String, param2:Function, param3:IWindowContainer) : IContainerButtonWindow
      {
         var _loc4_:IContainerButtonWindow = IContainerButtonWindow(param3.findChildByName("button_" + param1));
         _loc4_.procedure = param2;
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("icon"));
         _loc5_.bitmap = _friendList.getButtonImage(param1);
         _loc5_.width = _loc5_.bitmap.width;
         _loc5_.height = _loc5_.bitmap.height;
         return _loc4_;
      }
      
      public function setNewMessageArrived() : void
      {
         _friendList.tabs.findTab(FriendListTab.const_79).setNewMessageArrived(true);
      }
      
      private function onFollowButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.follow}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _friendList.send(new FollowFriendMessageComposer(param2.id));
      }
      
      private function getBgColor(param1:Boolean) : uint
      {
         return _friendList.laf.getRowShadingColor(FriendListTab.const_79,param1);
      }
      
      public function refreshCategoryEntry(param1:FriendCategory, param2:Boolean) : void
      {
         if(this._list == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = param1.view;
         _loc3_.tags.splice(0,_loc3_.tags.length);
         _loc3_.tags.push(param1.id);
         _friendList.refreshText(_loc3_,"caption",true,param1.name + " (" + param1.friends.length + ")");
         refreshCatIcon(_loc3_,"arrow_down_black",param1.open,param1.id,6);
         refreshCatIcon(_loc3_,"arrow_right_black",!param1.open,param1.id,9);
         var _loc4_:IWindow = _loc3_.findChildByName(const_589);
         _loc4_.procedure = onCategoryClick;
         _loc4_.visible = false;
         refreshPager(param1,param2);
         _loc3_.height = Math.max(Util.getLowestPoint(_loc3_),20);
         _loc4_.height = _loc3_.height;
         _loc4_.visible = true;
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
