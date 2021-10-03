package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.RoomPopupCtrl;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.geom.Point;
   
   public class GuestRoomListCtrl implements IViewCtrl
   {
       
      
      private var var_1102:IWindowContainer;
      
      private var var_30:IWindowContainer;
      
      private var _navigator:HabboNavigator;
      
      private var _roomPopupCtrl:RoomPopupCtrl;
      
      private var var_1774:int;
      
      private var var_340:IScrollbarWindow;
      
      private var var_1720:UserCountRenderer;
      
      private var var_1773:Boolean;
      
      private var _list:IItemListWindow;
      
      public function GuestRoomListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         _roomPopupCtrl = new RoomPopupCtrl(_navigator,5,-5);
         var_1720 = new UserCountRenderer(_navigator);
      }
      
      public function get content() : IWindowContainer
      {
         return var_30;
      }
      
      private function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = int(param2.parent.tags[0]);
         var _loc4_:GuestRoomData = _navigator.data.guestRoomSearchResults.rooms[_loc3_];
         if(_loc4_ == null)
         {
            Logger.log("No room found " + _loc3_ + ", " + _navigator.data.guestRoomSearchResults.rooms.length);
            return;
         }
         _navigator.send(new DeleteFavouriteRoomMessageComposer(0,_loc4_.flatId));
      }
      
      private function hilite(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         if(var_1102 != null)
         {
            _loc2_ = var_1102.tags[0];
            var_1102.color = getBgColor(_loc2_);
         }
         var_1102 = param1;
         param1.color = 4288861930;
      }
      
      public function set content(param1:IWindowContainer) : void
      {
         var_30 = param1;
         _list = IItemListWindow(var_30.findChildByName("item_list"));
         var_340 = IScrollbarWindow(var_30.findChildByName("scroller"));
      }
      
      private function checkFastHorizontalMove(param1:WindowEvent) : void
      {
         var _loc2_:WindowMouseEvent = WindowMouseEvent(param1);
         var _loc3_:int = Math.abs(var_1774 - _loc2_.stageX);
         var_1774 = _loc2_.stageX;
         var_1773 = _loc3_ > 2;
      }
      
      private function getBgColor(param1:int) : uint
      {
         return param1 % 2 != 0 ? 4294967295 : uint(4292797682);
      }
      
      private function getVisibleEntryCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _list.numListItems)
         {
            if(_list.getListItemAt(_loc2_).visible)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function refresh() : void
      {
         var _loc4_:Boolean = false;
         var _loc1_:Array = _navigator.data.guestRoomSearchResults.rooms;
         var _loc2_:int = getVisibleEntryCount();
         _list.autoArrangeItems = false;
         var _loc3_:int = 0;
         while(true)
         {
            if(_loc3_ < _loc1_.length)
            {
               refreshEntry(true,_loc3_,_loc1_[_loc3_]);
            }
            else
            {
               _loc4_ = refreshEntry(false,_loc3_,null);
               if(_loc4_)
               {
                  break;
               }
            }
            _loc3_++;
         }
         _list.autoArrangeItems = true;
         if(getVisibleEntryCount() != _loc2_)
         {
            var_340.scrollV = 0;
         }
         var_30.findChildByName("no_rooms_found").visible = _loc1_.length < 1;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:GuestRoomData) : Boolean
      {
         var _loc4_:IWindowContainer = IWindowContainer(_list.getListItemAt(param2));
         var _loc5_:Boolean = false;
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = getListEntry(param2);
            _list.addListItem(_loc4_);
            _loc5_ = true;
         }
         Util.hideChildren(_loc4_);
         if(param1)
         {
            refreshEntryDetails(_loc4_,param3);
            _loc4_.visible = true;
            _loc4_.height = 17;
         }
         else
         {
            _loc4_.height = 0;
            _loc4_.visible = false;
         }
         if(_loc5_)
         {
            _navigator.mainViewCtrl.stretchNewEntryIfNeeded(this,_loc4_);
         }
         return false;
      }
      
      private function refreshRoomName(param1:IWindowContainer, param2:GuestRoomData) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
         _loc3_.visible = true;
         var _loc4_:Boolean = param1.findChildByName("home").visible || param1.findChildByName("favourite").visible || param1.findChildByName("make_favourite").visible;
         Util.cutTextToWidth(_loc3_,param2.roomName,!!_loc4_ ? int(_loc3_.width - 20) : int(_loc3_.width));
      }
      
      private function refreshFavouriteIcon(param1:IWindowContainer, param2:GuestRoomData) : void
      {
         var _loc3_:Boolean = _navigator.data.settings != null && _navigator.data.isRoomFavourite(param2.flatId);
         var _loc4_:Boolean = isHome(param2);
         refreshRegion(param1,"make_favourite",!_loc3_ && !_loc4_,onAddFavouriteClick);
         refreshRegion(param1,"favourite",_loc3_ && !_loc4_,onRemoveFavouriteClick);
      }
      
      private function isHome(param1:GuestRoomData) : Boolean
      {
         return _navigator.data.settings != null && param1.flatId == _navigator.data.settings.homeRoomId;
      }
      
      public function refreshEntryDetails(param1:IWindowContainer, param2:GuestRoomData) : void
      {
         param1.visible = true;
         Util.hideChildren(param1);
         refreshFavouriteIcon(param1,param2);
         _navigator.refreshButton(param1,"home",isHome(param2),null,0);
         _navigator.refreshButton(param1,"doormode_doorbell_small",param2.doorMode == RoomSettingsFlatInfo.const_150,null,0);
         _navigator.refreshButton(param1,"doormode_password_small",param2.doorMode == RoomSettingsFlatInfo.const_113,null,0);
         refreshRoomName(param1,param2);
         var_1720.refreshUserCount(param2.maxUserCount,param1,param2.userCount,"${navigator.usercounttooltip.users}",233,2);
      }
      
      private function onAddFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = int(param2.parent.tags[0]);
         var _loc4_:GuestRoomData = _navigator.data.guestRoomSearchResults.rooms[_loc3_];
         if(_loc4_ == null)
         {
            Logger.log("No room found " + _loc3_ + ", " + _navigator.data.guestRoomSearchResults.rooms.length);
            return;
         }
         _navigator.send(new AddFavouriteRoomMessageComposer(0,_loc4_.flatId));
      }
      
      private function refreshRegion(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function) : void
      {
         var _loc5_:IRegionWindow = param1.findChildByName(param2) as IRegionWindow;
         if(!param3)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.procedure = param4;
            _loc5_.visible = true;
            _navigator.refreshButton(_loc5_,param2,param3,null,0);
         }
      }
      
      private function onRow(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(param2 as IWindowContainer == null || param2.name != "details")
         {
            param2 = param2.parent as IWindowContainer;
            if(param2 == null || param2.name != "details")
            {
               return;
            }
         }
         if(param1.type == WindowMouseEvent.const_213)
         {
            this.checkFastHorizontalMove(param1);
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            if(false && var_1773)
            {
               return;
            }
            hilite(IWindowContainer(param2));
            _loc3_ = param2.tags[0];
            if(_navigator.data.guestRoomSearchResults == null)
            {
               Logger.log("No guest room search results while room entry mouse over");
               return;
            }
            _loc4_ = _navigator.data.guestRoomSearchResults.rooms[_loc3_];
            if(_loc4_ == null)
            {
               Logger.log("No room found " + _loc3_ + ", " + _navigator.data.guestRoomSearchResults.rooms.length);
               return;
            }
            _roomPopupCtrl.room = _loc4_;
            _roomPopupCtrl.showPopup(param2);
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            if(Util.containsMouse(param2))
            {
               Logger.log("Mouse entered contained element: " + param2.rectangle);
               return;
            }
            _loc5_ = param2.tags[0];
            param2.color = getBgColor(_loc5_);
            _roomPopupCtrl.closePopup();
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc6_ = param2.tags[0];
            if(_navigator.data.guestRoomSearchResults == null)
            {
               Logger.log("No guest room search results while room entry mouse click");
               return;
            }
            _loc7_ = _navigator.data.guestRoomSearchResults.rooms[_loc6_];
            if(_loc7_ == null)
            {
               Logger.log("No room found " + _loc6_ + ", " + _navigator.data.guestRoomSearchResults.rooms.length);
               return;
            }
            if(_loc7_.ownerName != _navigator.sessionData.userName)
            {
               _loc8_ = new Point((param1 as WindowMouseEvent).stageX,(param1 as WindowMouseEvent).stageY);
               switch(_loc7_.doorMode)
               {
                  case RoomSettingsFlatInfo.const_113:
                     _navigator.passwordInput.show(_loc7_,_loc8_);
                     return;
                  case RoomSettingsFlatInfo.const_150:
                     _navigator.doorbell.show(_loc7_,_loc8_);
                     return;
               }
            }
            _navigator.goToRoom(_loc7_.flatId,true);
            _roomPopupCtrl.hideInstantly();
         }
      }
      
      private function getListEntry(param1:int) : IWindowContainer
      {
         var _loc2_:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_guest_room_details_short"));
         _loc2_.background = true;
         _loc2_.procedure = onRow;
         _loc2_.setParamFlag(HabboWindowParam.const_34,true);
         _loc2_.setParamFlag(HabboWindowParam.const_1175,true);
         _loc2_.color = getBgColor(param1);
         _loc2_.tags.push(param1);
         return _loc2_;
      }
   }
}
