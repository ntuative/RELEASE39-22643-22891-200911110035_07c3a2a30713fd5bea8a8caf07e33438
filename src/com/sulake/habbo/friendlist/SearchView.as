package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
   import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   public class SearchView implements ITabView, ISearchView
   {
       
      
      private var var_564:ITextFieldWindow;
      
      private var var_333:AvatarPopupCtrl;
      
      private var _friendList:HabboFriendList;
      
      private var _list:IItemListWindow;
      
      public function SearchView()
      {
         super();
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         _list = param1;
      }
      
      public function getEntryCount() : int
      {
         if(_friendList.searchResults.friends == null)
         {
            return 0;
         }
         return _friendList.searchResults.friends.length + _friendList.searchResults.others.length;
      }
      
      public function fillFooter(param1:IWindowContainer) : void
      {
         var_564 = ITextFieldWindow(param1.findChildByName("search_str"));
         var_564.procedure = onSearchInput;
         var_564.addEventListener(WindowKeyboardEvent.const_140,onSearchStrInput);
         param1.findChildByName("search_but").procedure = onSearchButtonClick;
         _friendList.refreshButton(param1,"search",true,null,0);
      }
      
      private function getFriendsCaption() : String
      {
         if(_friendList.searchResults.friends.length == 0)
         {
            return "${friendlist.search.nofriendsfound}";
         }
         _friendList.registerParameter("friendlist.search.friendscaption","cnt","" + _friendList.searchResults.friends.length);
         return "${friendlist.search.friendscaption}";
      }
      
      private function onSearchEntry(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param2.id < 1)
         {
            return;
         }
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            _loc3_ = this._friendList.searchResults.getResult(param2.id);
            if(_loc3_ == null)
            {
               return;
            }
            this.var_333.setData(_loc3_.isAvatarOnline,_loc3_.avatarName,_loc3_.avatarMotto,_loc3_.avatarFigure,_loc3_.lastOnlineDate);
            this.var_333.showPopup(_friendList.view.mainWindow,IWindowContainer(param2));
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            this.var_333.closePopup();
         }
      }
      
      private function getOthersCaption() : String
      {
         if(_friendList.searchResults.others.length == 0)
         {
            return "${friendlist.search.noothersfound}";
         }
         _friendList.registerParameter("friendlist.search.otherscaption","cnt","" + _friendList.searchResults.others.length);
         return "${friendlist.search.otherscaption}";
      }
      
      private function refreshShading() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _list.numListItems)
         {
            _list.getListItemAt(_loc1_).color = _friendList.laf.getRowShadingColor(FriendListTab.const_294,_loc1_ % 2 == 1);
            _loc1_++;
         }
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
         var_333 = new AvatarPopupCtrl(_friendList);
      }
      
      private function onSearchButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.search}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Search clicked: " + param2.name);
         searchAvatar();
      }
      
      public function refreshList() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         _list.autoArrangeItems = false;
         var _loc1_:AvatarSearchResults = _friendList.searchResults;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ == 0)
            {
               refreshEntry(true,_loc2_,null,null,getFriendsCaption(),false,false,false,0);
            }
            else if(_loc2_ <= _loc1_.friends.length)
            {
               _loc3_ = _loc1_.friends[_loc2_ - 1];
               refreshEntry(true,_loc2_,_loc3_.avatarFigure,_loc3_.avatarName,null,!_loc3_.isAvatarOnline,_loc3_.isAvatarOnline,false,_loc3_.avatarId);
            }
            else if(_loc2_ == _loc1_.friends.length + 1)
            {
               refreshEntry(true,_loc2_,null,null,getOthersCaption(),false,false,false,0);
            }
            else if(_loc2_ <= _loc1_.friends.length + _loc1_.others.length + 1)
            {
               _loc4_ = _loc1_.others[_loc2_ - 2 - _loc1_.friends.length];
               refreshEntry(true,_loc2_,_loc4_.avatarFigure,_loc4_.avatarName,null,false,false,_loc4_.avatarId != _friendList.avatarId && !_friendList.searchResults.isFriendRequestSent(_loc4_.avatarId),_loc4_.avatarId);
            }
            else
            {
               _loc5_ = refreshEntry(false,_loc2_,null,null,null,false,false,false,0);
               if(_loc5_)
               {
                  break;
               }
            }
            _loc2_++;
         }
         refreshShading();
         _list.autoArrangeItems = true;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean, param8:Boolean, param9:int) : Boolean
      {
         var _loc10_:IWindowContainer = _list.getListItemAt(param2) as IWindowContainer;
         if(_loc10_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc10_ = IWindowContainer(_friendList.getXmlWindow("search_entry"));
            _loc10_.procedure = onSearchEntry;
            _list.addListItem(_loc10_);
         }
         if(param1)
         {
            _loc10_.height = 20;
            _loc10_.visible = true;
         }
         else
         {
            _loc10_.height = 0;
            _loc10_.visible = false;
         }
         _loc10_.id = param9;
         refreshFigure(_loc10_,param3);
         _friendList.refreshText(_loc10_,"name",param4 != null,param4);
         _friendList.refreshText(_loc10_,"caption",param5 != null,param5);
         _friendList.refreshButton(_loc10_,"minimail",param6,onMinimailButtonClick,param9);
         _friendList.refreshButton(_loc10_,"start_chat",param7,onChatButtonClick,param9);
         _friendList.refreshButton(_loc10_,"ask_for_friend",param8,onAskForFriendButtonClick,param9);
         return false;
      }
      
      private function refreshFigure(param1:IWindowContainer, param2:String) : void
      {
         var _loc3_:IBitmapWrapperWindow = param1.getChildByName(HabboFriendList.const_161) as IBitmapWrapperWindow;
         if(param2 == null || param2 == "")
         {
            _loc3_.visible = false;
         }
         else
         {
            _loc3_.bitmap = _friendList.getAvatarFaceBitmap(param2);
            _loc3_.width = _loc3_.bitmap.width;
            _loc3_.height = _loc3_.bitmap.height;
            _loc3_.visible = true;
         }
      }
      
      public function tabClicked(param1:int) : void
      {
      }
      
      private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.mail}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
         if(_loc3_ == null)
         {
            Logger.log("No search result found with id: " + param2.id);
            return;
         }
         var _loc4_:Dictionary = new Dictionary();
         _loc4_["recipientid"] = "" + _loc3_.avatarId;
         _loc4_["random"] = "" + Math.round(Math.random() * 100000000);
         var _loc5_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_friendList.isEmbeddedMinimailEnabled())
         {
            if(false)
            {
               ExternalInterface.call("FlashExternalInterface.openHabblet","minimail","#mail/compose/" + _loc4_["recipientid"] + "/" + _loc4_["random"] + "/");
            }
         }
         else
         {
            _friendList.openHabboWebPage("link.format.mail.compose",_loc4_,_loc5_.stageX,_loc5_.stageY);
         }
      }
      
      private function onSearchInput(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.searchstr}");
      }
      
      private function onChatButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.im}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
         if(_loc3_ == null)
         {
            Logger.log("No search result found with id: " + param2.id);
            return;
         }
         _friendList.messenger.startConversation(_loc3_.avatarId);
      }
      
      public function setSearchStr(param1:String) : void
      {
         this.var_564.text = param1;
      }
      
      private function searchAvatar() : void
      {
         var _loc1_:String = "null";
         Logger.log("Search avatar: " + _loc1_);
         if(_loc1_ == "")
         {
            Logger.log("No text...");
            return;
         }
         _friendList.send(new HabboSearchMessageComposer(_loc1_));
      }
      
      private function onAskForFriendButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.addfriend}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Ask for friend clicked: " + param2.id);
         var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
         if(_loc3_ == null)
         {
            Logger.log("No search result found with id: " + param2.id);
            return;
         }
         Logger.log("Search result found: " + _loc3_.avatarName);
         var _loc4_:Boolean = this._friendList.askForAFriend(_loc3_.avatarId,_loc3_.avatarName);
         if(!_loc4_)
         {
            _friendList.showLimitReachedAlert();
         }
         else
         {
            showFriendRequestSentAlert(_loc3_.avatarName);
            refreshEntry(true,findIndexFor(_loc3_.avatarId),_loc3_.avatarFigure,_loc3_.avatarName,null,false,false,false,_loc3_.avatarId);
         }
      }
      
      private function onSearchStrInput(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc2_:IWindow = IWindow(param1.target);
         Logger.log("Test key event " + param1 + ", " + param1.type + " " + _loc2_.name);
         if(!(param1 is WindowKeyboardEvent))
         {
            return;
         }
         var _loc4_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc4_.charCode == Keyboard.ENTER)
         {
            searchAvatar();
         }
         else
         {
            _loc5_ = 25;
            _loc6_ = "null";
            if(_loc6_.length > _loc5_)
            {
               var_564.text = _loc6_.substring(0,_loc5_);
            }
         }
      }
      
      private function findIndexFor(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < _list.numListItems)
         {
            if(_list.getListItemAt(_loc2_).id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function showFriendRequestSentAlert(param1:String) : void
      {
         _friendList.registerParameter("friendlist.friendrequestsent.text","user_name",param1);
         new SimpleAlertView(_friendList,"${friendlist.friendrequestsent.title}","${friendlist.friendrequestsent.text}").show();
      }
   }
}
