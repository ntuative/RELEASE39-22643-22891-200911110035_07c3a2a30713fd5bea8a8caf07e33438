package com.sulake.habbo.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailUpdateResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomThumbnailUpdateResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import flash.external.ExternalInterface;
   
   public class IncomingMessages
   {
       
      
      private var _navigator:HabboNavigator;
      
      public function IncomingMessages(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var _loc2_:IHabboCommunicationManager = _navigator.communication;
         _loc2_.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthOK));
         _loc2_.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         _loc2_.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _loc2_.addHabboConnectionMessageEvent(new OfficialRoomsEvent(onOfficialRooms));
         _loc2_.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(onGuestRoomSearchResult));
         _loc2_.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(onPopularRoomTagsResult));
         _loc2_.addHabboConnectionMessageEvent(new RoomEventEvent(onRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(onCanCreateRoomEventEvent));
         _loc2_.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
         _loc2_.addHabboConnectionMessageEvent(new PublicSpaceCastLibsEvent(onPublicSpaceCastLibs));
         _loc2_.addHabboConnectionMessageEvent(new FlatCreatedEvent(onFlatCreated));
         _loc2_.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         _loc2_.addHabboConnectionMessageEvent(new RoomForwardMessageEvent(onRoomForward));
         _loc2_.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(onNavigatorSettings));
         _loc2_.addHabboConnectionMessageEvent(new UserFlatCatsEvent(onUserFlatCats));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(onRoomSettingsData));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(onRoomSettingsError));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(onRoomSettingsSaveError));
         _loc2_.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(onRoomInfoUpdated));
         _loc2_.addHabboConnectionMessageEvent(new RoomThumbnailUpdateResultEvent(onThumbnailUpdated));
         _loc2_.addHabboConnectionMessageEvent(new FavouritesEvent(onFavourites));
         _loc2_.addHabboConnectionMessageEvent(new FavouriteChangedEvent(onFavouriteChanged));
         _loc2_.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(onFlatControllerAdded));
         _loc2_.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(onFlatControllerRemoved));
         _loc2_.addHabboConnectionMessageEvent(new NoSuchFlatEvent(onNoSuchFlat));
         _loc2_.addHabboConnectionMessageEvent(new RoomRatingEvent(onRoomRating));
         _loc2_.addHabboConnectionMessageEvent(new CanCreateRoomEvent(onCanCreateRoom));
         _loc2_.addHabboConnectionMessageEvent(new GenericErrorEvent(onError));
         _loc2_.addHabboConnectionMessageEvent(new DoorbellMessageEvent(onDoorbell));
         _loc2_.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(onDoorOpened));
         _loc2_.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         _loc2_.addHabboConnectionMessageEvent(new CantConnectMessageEvent(onCantConnect));
      }
      
      private function onNoSuchFlat(param1:IMessageEvent) : void
      {
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Array = UserRightsMessageEvent(param1).rights;
         Logger.log("GOT USER RIGHTS: " + _loc2_.length);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ == "fuse_cancel_roomevent")
            {
               Logger.log("User can cancel room events");
               _navigator.data.eventMod = true;
            }
         }
      }
      
      private function onRoomSettingsSaved(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:RoomSettingsSavedMessageParser = (param1 as RoomSettingsSavedEvent).getParser();
         for each(_loc3_ in _navigator.roomSettingsCtrls)
         {
            _loc3_.onRoomSettingsSaved(_loc2_.roomId);
         }
         _navigator.mainViewCtrl.reloadRoomList(Tabs.const_190);
      }
      
      private function onAuthOK(param1:IMessageEvent) : void
      {
         _navigator.onAuthOk();
      }
      
      private function onCantConnect(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:CantConnectMessageParser = (param1 as CantConnectMessageEvent).getParser();
         Logger.log("FAILED TO CONNECT: REASON: " + _loc2_.reason);
         switch(_loc2_.reason)
         {
            case CantConnectMessageParser.const_1088:
               _loc3_ = new SimpleAlertView(_navigator,"${navigator.guestroomfull.title}","${navigator.guestroomfull.text}");
               _loc3_.show();
               break;
            case CantConnectMessageParser.const_1146:
               _loc3_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error." + _loc2_.parameter + "}");
               _loc3_.show();
               break;
            case CantConnectMessageParser.const_303:
               _loc3_ = new SimpleAlertView(_navigator,"${navigator.banned.title}","${navigator.banned.text}");
               _loc3_.show();
               break;
            default:
               _loc3_ = new SimpleAlertView(_navigator,"${room.queue.error.title}","${room.queue.error.title}");
               _loc3_.show();
         }
      }
      
      private function onCanCreateRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(param1).getParser();
         Logger.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
         if(_loc2_.canCreateEvent)
         {
            _navigator.roomInfoViewCtrl.startEventEdit();
         }
         else
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.cannotcreateevent.title}","${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
            _loc3_.show();
            Logger.log("Cannot create an event just now...");
         }
      }
      
      private function onFavouriteChanged(param1:IMessageEvent) : void
      {
         var _loc2_:FavouriteChangedMessageParser = (param1 as FavouriteChangedEvent).getParser();
         Logger.log("Received favourite changed: " + _loc2_.flatId + ", " + _loc2_.added);
         _navigator.data.favouriteChanged(_loc2_.flatId,_loc2_.added);
         _navigator.roomInfoViewCtrl.reload();
         _navigator.mainViewCtrl.refresh();
      }
      
      private function onRoomForward(param1:IMessageEvent) : void
      {
         var _loc2_:RoomForwardMessageParser = RoomForwardMessageEvent(param1).getParser();
         Logger.log("Got room forward: " + _loc2_.publicRoom + ", " + _loc2_.roomId);
         forwardToRoom(_loc2_.publicRoom,_loc2_.roomId);
      }
      
      private function onFlatControllerRemoved(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:FlatControllerRemovedMessageParser = (param1 as FlatControllerRemovedEvent).getParser();
         Logger.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
         for each(_loc3_ in _navigator.roomSettingsCtrls)
         {
            _loc3_.onFlatControllerRemoved(_loc2_.flatId,_loc2_.userId);
         }
      }
      
      private function onCanCreateRoom(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:CanCreateRoomMessageParser = (param1 as CanCreateRoomEvent).getParser();
         Logger.log("Can create room: " + _loc2_.resultCode + ", " + _loc2_.roomLimit);
         if(_loc2_.resultCode == 0)
         {
            _navigator.roomCreateViewCtrl.show();
         }
         else
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.createroom.error}","${navigator.createroom.limitreached}");
            _navigator.registerParameter("navigator.createroom.limitreached","limit","" + _loc2_.roomLimit);
            _loc3_.show();
         }
      }
      
      private function setToolbarExitIcon() : void
      {
         var _loc1_:HabboToolbarSetIconEvent = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_251,HabboToolbarIconEnum.EXITROOM);
         var _loc2_:int = data == null && true ? 0 : int(data.settings.homeRoomId);
         var _loc3_:int = data.enteredGuestRoom == null ? 0 : int(data.enteredGuestRoom.flatId);
         if(false)
         {
            if(_loc2_ > 0 && _loc2_ != _loc3_)
            {
               _loc1_.iconState = "exit_homeroom";
            }
            else
            {
               _loc1_.iconState = "exit_hotelview";
            }
         }
         else if(data != null && false && data.settings.homeRoomId > 0)
         {
            _loc1_.iconState = "homeroom";
         }
         else
         {
            _loc1_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_152,HabboToolbarIconEnum.EXITROOM);
         }
         _navigator.toolbar.events.dispatchEvent(_loc1_);
      }
      
      private function onPublicSpaceCastLibs(param1:IMessageEvent) : void
      {
         var _loc2_:PublicSpaceCastLibsMessageParser = PublicSpaceCastLibsEvent(param1).getParser();
         Logger.log("Got public space cast libs: " + _loc2_.nodeId + ", " + _loc2_.unitPort + ", " + _loc2_.castLibs);
         _navigator.data.publicSpaceNodeId = _loc2_.nodeId;
         _navigator.goToPublicSpace(_loc2_.unitPort,_loc2_.castLibs);
      }
      
      private function onError(param1:IMessageEvent) : void
      {
         var _loc2_:GenericErrorEvent = param1 as GenericErrorEvent;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.getParser().errorCode)
         {
            case -100002:
               _navigator.passwordInput.showRetry();
         }
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:FlatCreatedMessageParser = FlatCreatedEvent(param1).getParser();
         Logger.log("Flat created: " + _loc2_.flatId + ", " + _loc2_.flatName);
         data.createdFlatId = _loc2_.flatId;
         _navigator.goToRoom(_loc2_.flatId,true);
         _navigator.mainViewCtrl.reloadRoomList(Tabs.const_190);
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         Logger.log("Navigator: exiting room");
         data.onRoomExit();
         _navigator.roomInfoViewCtrl.close();
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_152,HabboToolbarIconEnum.ROOMINFO));
         if(!_navigator.mainViewCtrl.isOpen())
         {
            _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
         }
         setToolbarExitIcon();
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.openHabblet","news");
         }
      }
      
      private function onRoomEventEvent(param1:IMessageEvent) : void
      {
         var _loc2_:RoomEventMessageParser = RoomEventEvent(param1).getParser();
         Logger.log("Got room event: " + _loc2_.data.ownerAvatarId + ", " + _loc2_.data.eventName);
         data.roomEventData = _loc2_.data.ownerAvatarId > 0 ? _loc2_.data : null;
         _navigator.roomInfoViewCtrl.reload();
      }
      
      private function forwardToRoom(param1:Boolean, param2:int) : void
      {
         _navigator.send(!!param1 ? new GetPublicSpaceCastLibsMessageComposer(param2) : new GetGuestRoomMessageComposer(param2,false,true));
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         Logger.log("Navigator: entering room");
         data.onRoomEnter(_loc2_);
         _navigator.roomInfoViewCtrl.close();
         if(_loc2_.guestRoom)
         {
            _navigator.send(new GetGuestRoomMessageComposer(_loc2_.guestRoomId,true,false));
            Logger.log("Sent get guest room...");
         }
         else
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_101,HabboToolbarIconEnum.ROOMINFO));
            setToolbarExitIcon();
            _navigator.roomInfoViewCtrl.open(false);
         }
      }
      
      private function onUserFlatCats(param1:IMessageEvent) : void
      {
         var _loc2_:UserFlatCatsMessageParser = (param1 as UserFlatCatsEvent).getParser();
         _navigator.data.categories = _loc2_.nodes;
         Logger.log("GOT USER FLAT CATS: " + _loc2_.nodes.length);
      }
      
      private function onRoomRating(param1:IMessageEvent) : void
      {
         var _loc2_:RoomRatingMessageParser = (param1 as RoomRatingEvent).getParser();
         Logger.log("Received room rating: " + _loc2_.rating);
         _navigator.data.currentRoomRating = _loc2_.rating;
         this._navigator.roomInfoViewCtrl.reload();
      }
      
      private function onRoomSettingsData(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:RoomSettingsDataMessageParser = (param1 as RoomSettingsDataEvent).getParser();
         for each(_loc3_ in _navigator.roomSettingsCtrls)
         {
            _loc3_.onRoomSettings(_loc2_.data);
         }
         Logger.log("GOT ROOM SETTINGS DATA: " + _loc2_.data.name + ", " + _loc2_.data.maximumVisitors + ", " + _loc2_.data.maximumVisitorsLimit);
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc3_:* = false;
         var _loc4_:Boolean = false;
         var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
         Logger.log("Got room info: " + _loc2_.enterRoom + ", " + _loc2_.roomForward);
         if(_loc2_.enterRoom)
         {
            data.enteredRoom = _loc2_.data;
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_101,HabboToolbarIconEnum.ROOMINFO));
            _loc3_ = data.createdFlatId == _loc2_.data.flatId;
            _loc4_ = _loc3_ || data.enteredGuestRoom.ownerName != _navigator.sessionData.userName;
            if(_loc4_)
            {
               _navigator.roomInfoViewCtrl.open(_loc3_);
            }
            data.createdFlatId = 0;
         }
         else if(_loc2_.roomForward)
         {
            if(_loc2_.data.doorMode == RoomSettingsData.const_150)
            {
               _navigator.doorbell.show(_loc2_.data);
            }
            else if(_loc2_.data.doorMode == RoomSettingsData.const_113)
            {
               _navigator.passwordInput.show(_loc2_.data);
            }
            else
            {
               _navigator.goToRoom(_loc2_.data.flatId,false);
            }
         }
         else
         {
            data.enteredRoom = _loc2_.data;
            _navigator.roomInfoViewCtrl.reload();
         }
         setToolbarExitIcon();
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
         data.avatarId = _loc2_.id;
         _navigator.send(new GetUserFlatCatsMessageComposer());
      }
      
      public function get data() : NavigatorData
      {
         return _navigator.data;
      }
      
      private function onRoomSettingsError(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsErrorMessageParser = (param1 as RoomSettingsErrorEvent).getParser();
      }
      
      private function onFlatControllerAdded(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:FlatControllerAddedMessageParser = (param1 as FlatControllerAddedEvent).getParser();
         Logger.log("Flat controller added: " + _loc2_.flatId + ", " + _loc2_.data.userId + ", " + _loc2_.data.userName);
         for each(_loc3_ in _navigator.roomSettingsCtrls)
         {
            _loc3_.onFlatControllerAdded(_loc2_.flatId,_loc2_.data);
         }
      }
      
      private function onOfficialRooms(param1:IMessageEvent) : void
      {
         var _loc2_:OfficialRoomsData = OfficialRoomsEvent(param1).getParser().data;
         data.officialRooms = _loc2_;
         Logger.log("Received Official rooms: " + data.officialRooms.entries.length);
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(param1).getParser();
         Logger.log("Got subscription info: " + _loc2_.productName + ", " + _loc2_.daysToPeriodEnd + ", " + _loc2_.memberPeriods + ", " + _loc2_.periodsSubscribedAhead + ", " + _loc2_.responseType);
         data.hcMember = _loc2_.daysToPeriodEnd > 0;
      }
      
      private function onPopularRoomTagsResult(param1:IMessageEvent) : void
      {
         var _loc2_:PopularRoomTagsData = PopularRoomTagsResultEvent(param1).getParser().data;
         data.popularTags = _loc2_;
         Logger.log("Received popular room tags: " + data.popularTags.tags.length);
      }
      
      private function onRoomSettingsSaveError(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:RoomSettingsSaveErrorMessageParser = (param1 as RoomSettingsSaveErrorEvent).getParser();
         for each(_loc3_ in _navigator.roomSettingsCtrls)
         {
            _loc3_.onRoomSettingsSaveError(_loc2_.roomId,_loc2_.errorCode,_loc2_.info);
         }
      }
      
      private function onDoorOpened(param1:IMessageEvent) : void
      {
         var _loc2_:FlatAccessibleMessageEvent = param1 as FlatAccessibleMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         _navigator.doorbell.hide();
      }
      
      private function onDoorbell(param1:IMessageEvent) : void
      {
         var _loc2_:DoorbellMessageEvent = param1 as DoorbellMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.userName != "")
         {
            return;
         }
         _navigator.doorbell.showWaiting();
      }
      
      private function onFavourites(param1:IMessageEvent) : void
      {
         var _loc2_:FavouritesMessageParser = (param1 as FavouritesEvent).getParser();
         Logger.log("Received favourites: " + _loc2_.limit + ", " + _loc2_.favouriteRoomIds.length);
         _navigator.data.onFavourites(_loc2_);
      }
      
      private function onGuestRoomSearchResult(param1:IMessageEvent) : void
      {
         var _loc2_:GuestRoomSearchResultData = GuestRoomSearchResultEvent(param1).getParser().data;
         data.guestRoomSearchResults = _loc2_;
         Logger.log("Received GuestRoomSearch: " + data.guestRoomSearchResults.rooms.length);
      }
      
      private function onRoomInfoUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:RoomInfoUpdatedMessageParser = (param1 as RoomInfoUpdatedEvent).getParser();
         Logger.log("ROOM UPDATED: " + _loc2_.flatId);
         _navigator.send(new GetGuestRoomMessageComposer(_loc2_.flatId,false,false));
      }
      
      private function onNavigatorSettings(param1:IMessageEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc2_:NavigatorSettingsMessageParser = NavigatorSettingsEvent(param1).getParser();
         Logger.log("Got navigator settings: " + _loc2_.homeRoomId);
         var _loc3_:* = _navigator.data.settings == null;
         _navigator.data.settings = _loc2_;
         _navigator.mainViewCtrl.refresh();
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         if(_loc3_)
         {
            if(false)
            {
               if(_navigator.configuration.keyExists("friend.id"))
               {
                  _loc4_ = 0;
                  _navigator.send(new FollowFriendMessageComposer(int(_navigator.configuration.getKey("friend.id"))));
               }
               if(_navigator.configuration.keyExists("forward.type") && _navigator.configuration.keyExists("forward.id"))
               {
                  _loc4_ = int(_navigator.configuration.getKey("forward.type"));
                  _loc5_ = int(_navigator.configuration.getKey("forward.id"));
               }
            }
            _loc6_ = false;
            if(parseInt(_navigator.configuration.getKey("navigator.always_open_after_login")) == 1)
            {
               _loc6_ = true;
            }
            if(_loc4_ == 2)
            {
               Logger.log("Guest room forward on enter: " + _loc5_);
               forwardToRoom(false,_loc5_);
            }
            else if(_loc4_ == 1)
            {
               Logger.log("Public room forward on enter: " + _loc5_);
               forwardToRoom(true,_loc5_);
            }
            else if(_loc4_ == -1)
            {
               _loc7_ = this._navigator.goToHomeRoom();
               if(!_loc7_)
               {
                  _loc6_ = true;
               }
            }
            if(_loc6_ && !_navigator.mainViewCtrl.isOpen())
            {
               _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
            }
         }
         else
         {
            _navigator.roomInfoViewCtrl.reload();
         }
         setToolbarExitIcon();
      }
      
      private function onThumbnailUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:RoomThumbnailUpdateResultMessageParser = (param1 as RoomThumbnailUpdateResultEvent).getParser();
         Logger.log("THUMBNAIL UPDATED: " + _loc2_.resultCode);
         _navigator.roomInfoViewCtrl.backToRoomSettings();
         _navigator.send(new GetGuestRoomMessageComposer(_loc2_.flatId,false,false));
      }
      
      private function onFlatAccessDenied(param1:IMessageEvent) : void
      {
         _navigator.doorbell.showNoAnswer();
      }
   }
}
