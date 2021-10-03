package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.SimpleAlertView;
   import com.sulake.habbo.navigator.TagRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
   import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner
   {
       
      
      private var var_597:IWindowContainer;
      
      private var var_892:ITextWindow;
      
      private var var_187:RoomSettingsCtrl;
      
      private var var_1079:IContainerButtonWindow;
      
      private var _window:IWindowContainer;
      
      private var var_422:Timer;
      
      private var var_1082:ITextWindow;
      
      private var var_316:IWindowContainer;
      
      private var var_1724:IWindowContainer;
      
      private var var_1723:ITextWindow;
      
      private var var_728:IWindowContainer;
      
      private var var_1330:IButtonWindow;
      
      private var _ownerName:ITextWindow;
      
      private var var_603:ITextWindow;
      
      private var var_1332:IWindowContainer;
      
      private var var_1078:IWindowContainer;
      
      private var var_727:ITextWindow;
      
      private var var_893:ITextFieldWindow;
      
      private var var_275:IWindowContainer;
      
      private var var_730:ITextWindow;
      
      private var var_1331:IButtonWindow;
      
      private var var_894:ITextWindow;
      
      private var var_2078:int;
      
      private var var_1084:IContainerButtonWindow;
      
      private var var_729:IWindowContainer;
      
      private var var_1083:ITextWindow;
      
      private var var_1081:IContainerButtonWindow;
      
      private var var_1329:ITextWindow;
      
      private var var_1328:IButtonWindow;
      
      private var var_858:TagRenderer;
      
      private var var_1660:ITextWindow;
      
      private var var_317:RoomEventViewCtrl;
      
      private var _navigator:HabboNavigator;
      
      private var var_596:ITextWindow;
      
      private var var_244:RoomThumbnailCtrl;
      
      private var var_1080:IContainerButtonWindow;
      
      private var var_1725:IWindowContainer;
      
      private var var_245:IWindowContainer;
      
      public function RoomInfoViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_317 = new RoomEventViewCtrl(_navigator);
         var_187 = new RoomSettingsCtrl(_navigator,this,true);
         var_244 = new RoomThumbnailCtrl(_navigator);
         var_858 = new TagRenderer(_navigator);
         _navigator.roomSettingsCtrls.push(this.var_187);
         var_422 = new Timer(6000,1);
         var_422.addEventListener(TimerEvent.TIMER,hideInfo);
      }
      
      public function backToRoomSettings() : void
      {
         this.var_187.active = true;
         this.var_317.active = false;
         this.var_244.active = false;
         this.reload();
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      private function refreshEventButtons(param1:RoomEventData) : void
      {
         if(false)
         {
            return;
         }
         var_1330.visible = param1 == null && _navigator.data.currentRoomOwner;
         var_1328.visible = param1 != null && (_navigator.data.currentRoomOwner || _navigator.data.eventMod);
         var_1332.visible = Util.hasVisibleChildren(var_1332);
      }
      
      private function refreshRoomDetails(param1:GuestRoomData, param2:Boolean) : void
      {
         if(param1 == null || false || false)
         {
            return;
         }
         var_603.text = param1.roomName;
         var_603.height = NaN;
         _ownerName.text = param1.ownerName;
         var_727.text = param1.description;
         var_858.refreshTags(var_316,param1.tags);
         var_727.visible = false;
         if(param1.description != "")
         {
            var_727.height = NaN;
            var_727.visible = true;
         }
         var _loc3_:* = _navigator.data.currentRoomRating == -1;
         _navigator.refreshButton(var_316,"thumb_up",_loc3_,onThumbUp,0);
         _navigator.refreshButton(var_316,"thumb_down",_loc3_,onThumbDown,0);
         var_1723.visible = _loc3_;
         var_730.visible = !_loc3_;
         var_1329.visible = !_loc3_;
         var_1329.text = "" + _navigator.data.currentRoomRating;
         _navigator.refreshButton(var_316,"home",param2,null,0);
         _navigator.refreshButton(var_316,"favourite",!param2 && _navigator.data.isCurrentRoomFavourite(),null,0);
         Util.moveChildrenToColumn(var_316,["room_name","owner_name_cont","tags","room_desc","rating_cont"],var_603.y,0);
         var_316.visible = true;
         var_316.height = Util.getLowestPoint(var_316);
      }
      
      private function getButtonsMinHeight() : int
      {
         return !!_navigator.data.currentRoomOwner ? 0 : 21;
      }
      
      private function hideInfo(param1:Event) : void
      {
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_409,HabboToolbarIconEnum.ROOMINFO,_window,false));
      }
      
      private function onThumbUp(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.send(new RateFlatMessageComposer(1));
      }
      
      private function getRoomInfoMinHeight() : int
      {
         return 37;
      }
      
      public function onAddFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         if(_navigator.data.isFavouritesFull())
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.favouritesfull.title}","${navigator.favouritesfull.body}");
            _loc3_.show();
         }
         else
         {
            _navigator.send(new AddFavouriteRoomMessageComposer(0,_navigator.data.enteredGuestRoom.flatId));
         }
      }
      
      private function refreshRoomButtons(param1:Boolean) : void
      {
         if(_navigator.data.enteredGuestRoom == null || false || false)
         {
            return;
         }
         var_1331.visible = _navigator.data.canEditRoomSettings;
         var _loc2_:Boolean = _navigator.data.isCurrentRoomFavourite();
         var_1079.visible = _navigator.data.canAddFavourite && !_loc2_;
         var_1080.visible = _navigator.data.canAddFavourite && _loc2_;
         var_1084.visible = _navigator.data.canEditRoomSettings && !param1;
         var_1081.visible = _navigator.data.canEditRoomSettings && param1;
         var_1078.visible = Util.hasVisibleChildren(var_1078);
      }
      
      public function open(param1:Boolean) : void
      {
         this.var_422.reset();
         this.var_317.active = false;
         this.var_187.active = false;
         this.var_244.active = false;
         if(param1)
         {
            this.startRoomSettingsEdit(_navigator.data.enteredGuestRoom.flatId);
         }
         refresh();
         _window.visible = true;
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.ROOMINFO,_window,false));
         _window.parent.activate();
         _window.activate();
         if(!param1)
         {
            this.var_422.start();
         }
      }
      
      public function toggle() : void
      {
         this.var_422.reset();
         this.var_317.active = false;
         this.var_187.active = false;
         this.var_244.active = false;
         refresh();
         if(true)
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.ROOMINFO,_window,false));
            _window.parent.activate();
         }
         else
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_409,HabboToolbarIconEnum.ROOMINFO,_window,false));
         }
      }
      
      private function refreshRoom() : void
      {
         Util.hideChildren(var_275);
         var_275.findChildByName("close").visible = true;
         var _loc1_:GuestRoomData = _navigator.data.enteredGuestRoom;
         var _loc2_:Boolean = _navigator.data.settings != null && _loc1_ != null && _loc1_.flatId == _navigator.data.settings.homeRoomId;
         refreshRoomDetails(_loc1_,_loc2_);
         refreshPublicSpaceDetails(_navigator.data.enteredPublicSpace);
         refreshRoomButtons(_loc2_);
         this.var_187.refresh(var_275);
         this.var_244.refresh(var_275);
         Util.moveChildrenToColumn(var_275,["room_details","room_buttons"],0,2);
         var_275.height = Util.getLowestPoint(var_275);
         var_275.visible = true;
         Logger.log("XORP: undefined, undefined, undefined, undefined, undefined");
      }
      
      private function onCloseButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         hideInfo(null);
      }
      
      private function onEmbedSrcClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var_893.setSelection(0,var_893.text.length);
      }
      
      private function getEmbedData() : String
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_navigator.data.enteredGuestRoom != null)
         {
            _loc1_ = "private";
            _loc2_ = "" + _navigator.data.enteredGuestRoom.flatId;
         }
         else
         {
            _loc1_ = "public";
            _loc2_ = "" + _navigator.data.publicSpaceNodeId;
            Logger.log("Node id is: " + _loc2_);
         }
         var _loc3_:String = _navigator.configuration.getKey("user.hash","");
         _navigator.registerParameter("navigator.embed.src","roomType",_loc1_);
         _navigator.registerParameter("navigator.embed.src","embedCode",_loc3_);
         _navigator.registerParameter("navigator.embed.src","roomId",_loc2_);
         return _navigator.getText("navigator.embed.src");
      }
      
      private function onThumbDown(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.send(new RateFlatMessageComposer(-1));
      }
      
      private function refreshEvent() : void
      {
         Util.hideChildren(var_245);
         var _loc1_:RoomEventData = _navigator.data.roomEventData;
         refreshEventDetails(_loc1_);
         refreshEventButtons(_loc1_);
         this.var_317.refresh(var_245);
         if(Util.hasVisibleChildren(var_245) && !this.var_244.active)
         {
            Util.moveChildrenToColumn(var_245,["event_details","event_buttons"],0,2);
            var_245.height = Util.getLowestPoint(var_245);
            var_245.visible = true;
         }
         else
         {
            var_245.visible = false;
         }
         Logger.log("EVENT: undefined, undefined");
      }
      
      public function startEventEdit() : void
      {
         this.var_422.reset();
         this.var_317.active = true;
         this.var_187.active = false;
         this.var_244.active = false;
         this.reload();
      }
      
      private function getEventInfoMinHeight() : int
      {
         return 18;
      }
      
      public function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         _navigator.send(new DeleteFavouriteRoomMessageComposer(0,_navigator.data.enteredGuestRoom.flatId));
      }
      
      private function onHover(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            return;
         }
         var_422.reset();
      }
      
      private function refreshPublicSpaceDetails(param1:PublicRoomShortData) : void
      {
         if(param1 == null || false || false)
         {
            return;
         }
         var_892.text = _navigator.getPublicSpaceName(param1.unitPropertySet,param1.worldId);
         var_892.height = NaN;
         var_1082.text = _navigator.getPublicSpaceDesc(param1.unitPropertySet,param1.worldId);
         var_1082.height = NaN;
         Util.moveChildrenToColumn(var_597,["public_space_name","public_space_desc"],var_892.y,0);
         var_597.visible = true;
         var_597.height = Math.max(86,Util.getLowestPoint(var_597));
      }
      
      public function reload() : void
      {
         if(_window != null && false)
         {
            refresh();
         }
      }
      
      private function find(param1:String) : IWindow
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function refreshEmbed() : void
      {
         var _loc1_:* = _navigator.configuration.getKey("embed.showInRoomInfo","IssueListView") == "AnimationAction";
         if(_loc1_ && true && true && true)
         {
            var_729.visible = true;
            var_893.text = this.getEmbedData();
         }
         else
         {
            var_729.visible = false;
         }
      }
      
      public function startRoomSettingsEdit(param1:int) : void
      {
         this.var_422.reset();
         this.var_187.load(param1);
         this.var_187.active = true;
         this.var_317.active = false;
         this.var_244.active = false;
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      public function startThumbnailEdit() : void
      {
         this.var_422.reset();
         this.var_187.active = false;
         this.var_317.active = false;
         this.var_244.active = true;
         this.reload();
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IWindowContainer(_navigator.getXmlWindow("iro_room_details"));
         _window.setParamFlag(HabboWindowParam.const_63,false);
         _window.setParamFlag(HabboWindowParam.const_1093,true);
         var_275 = IWindowContainer(find("room_info"));
         var_316 = IWindowContainer(find("room_details"));
         var_597 = IWindowContainer(find("public_space_details"));
         var_1725 = IWindowContainer(find("owner_name_cont"));
         var_1724 = IWindowContainer(find("rating_cont"));
         var_1078 = IWindowContainer(find("room_buttons"));
         var_603 = ITextWindow(find("room_name"));
         var_892 = ITextWindow(find("public_space_name"));
         _ownerName = ITextWindow(find("owner_name"));
         var_727 = ITextWindow(find("room_desc"));
         var_1082 = ITextWindow(find("public_space_desc"));
         var_894 = ITextWindow(find("owner_caption"));
         var_730 = ITextWindow(find("rating_caption"));
         var_1723 = ITextWindow(find("rate_caption"));
         var_1329 = ITextWindow(find("rating_txt"));
         var_245 = IWindowContainer(find("event_info"));
         var_728 = IWindowContainer(find("event_details"));
         var_1332 = IWindowContainer(find("event_buttons"));
         var_1660 = ITextWindow(find("event_name"));
         var_596 = ITextWindow(find("event_desc"));
         var_1079 = IContainerButtonWindow(find("add_favourite_button"));
         var_1080 = IContainerButtonWindow(find("rem_favourite_button"));
         var_1084 = IContainerButtonWindow(find("make_home_button"));
         var_1081 = IContainerButtonWindow(find("unmake_home_button"));
         var_1331 = IButtonWindow(find("room_settings_button"));
         var_1330 = IButtonWindow(find("create_event_button"));
         var_1328 = IButtonWindow(find("edit_event_button"));
         var_729 = IWindowContainer(find("embed_info"));
         var_1083 = ITextWindow(find("embed_info_txt"));
         var_893 = ITextFieldWindow(find("embed_src_txt"));
         Util.setProcDirectly(var_1079,onAddFavouriteClick);
         Util.setProcDirectly(var_1080,onRemoveFavouriteClick);
         Util.setProcDirectly(var_1331,onRoomSettingsClick);
         Util.setProcDirectly(var_1084,onMakeHomeClick);
         Util.setProcDirectly(var_1081,onUnmakeHomeClick);
         Util.setProcDirectly(var_1330,onEventSettingsClick);
         Util.setProcDirectly(var_1328,onEventSettingsClick);
         Util.setProcDirectly(var_893,onEmbedSrcClick);
         _navigator.refreshButton(var_1079,"favourite",true,null,0);
         _navigator.refreshButton(var_1080,"favourite",true,null,0);
         _navigator.refreshButton(var_1084,"home",true,null,0);
         _navigator.refreshButton(var_1081,"home",true,null,0);
         _window.findChildByName("close").procedure = onCloseButtonClick;
         Util.setProcDirectly(var_275,onHover);
         Util.setProcDirectly(var_245,onHover);
         var_894.width = var_894.textWidth;
         Util.moveChildrenToRow(var_1725,["owner_caption","owner_name"],var_894.x,var_894.y,3);
         var_730.width = var_730.textWidth;
         Util.moveChildrenToRow(var_1724,["rating_caption","rating_txt"],var_730.x,var_730.y,3);
         var_1083.height = NaN;
         Util.moveChildrenToColumn(var_729,["embed_info_txt","embed_src_txt"],var_1083.y,2);
         var_729.height = Util.getLowestPoint(var_729) + 5;
         var_2078 = NaN;
      }
      
      private function refreshEventDetails(param1:RoomEventData) : void
      {
         if(param1 == null || false)
         {
            return;
         }
         var_1660.text = param1.eventName;
         var_596.text = param1.eventDescription;
         var_858.refreshTags(var_728,[_navigator.getText("roomevent_type_" + param1.eventType),param1.tags[0],param1.tags[1]]);
         var_596.visible = false;
         if(param1.eventDescription != "")
         {
            var_596.height = NaN;
            var_596.y = Util.getLowestPoint(var_728) + 2;
            var_596.visible = true;
         }
         var_728.visible = true;
         var_728.height = Util.getLowestPoint(var_728);
      }
      
      private function refresh() : void
      {
         prepareWindow();
         refreshRoom();
         refreshEvent();
         refreshEmbed();
         Util.moveChildrenToColumn(this._window,["room_info","event_info","embed_info"],0,2);
         _window.height = Util.getLowestPoint(_window);
         _window.y = _window.desktop.height - 0 - 5;
         Logger.log("MAIN: undefined, undefined, undefined");
      }
      
      private function onRoomSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = _navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         startRoomSettingsEdit(_loc3_.flatId);
      }
      
      private function onUnmakeHomeClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("CLEARING HOME ROOM:");
         _navigator.send(new UpdateNavigatorSettingsMessageComposer(0));
      }
      
      private function onEventSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.roomEventData == null)
         {
            if(_navigator.data.currentRoomOwner)
            {
               _navigator.send(new CanCreateEventMessageComposer());
            }
         }
         else
         {
            startEventEdit();
         }
      }
      
      public function roomSettingsRefreshNeeded() : void
      {
         refresh();
      }
      
      public function close() : void
      {
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_799,HabboToolbarIconEnum.ROOMINFO,_window,false));
         if(_window == null)
         {
            return;
         }
         this._window.visible = false;
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
      }
      
      private function onMakeHomeClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = _navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         Logger.log("SETTING HOME ROOM TO: " + _loc3_.flatId);
         _navigator.send(new UpdateNavigatorSettingsMessageComposer(_loc3_.flatId));
      }
   }
}
