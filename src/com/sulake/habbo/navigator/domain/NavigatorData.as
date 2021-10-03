package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   import com.sulake.habbo.communication.messages.incoming.navigator.MsgWithRequestId;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.utils.Dictionary;
   
   public class NavigatorData
   {
      
      private static const const_1299:int = 10;
       
      
      private var var_1313:NavigatorSettingsMessageParser;
      
      private var var_1062:int;
      
      private var var_1646:Boolean;
      
      private var var_1644:int;
      
      private var var_707:Dictionary;
      
      private var var_2073:int;
      
      private var var_1648:int;
      
      private var var_1647:int;
      
      private var var_306:Array;
      
      private var var_1642:int;
      
      private var var_1153:Array;
      
      private var var_490:PublicRoomShortData;
      
      private var var_360:RoomEventData;
      
      private var var_127:MsgWithRequestId;
      
      private var var_1645:Boolean;
      
      private var _navigator:HabboNavigator;
      
      private var var_1643:Boolean;
      
      private var var_186:GuestRoomData;
      
      private var var_589:Boolean;
      
      private var _currentRoomOwner:Boolean;
      
      public function NavigatorData(param1:HabboNavigator)
      {
         var_306 = new Array();
         var_707 = new Dictionary();
         super();
         _navigator = param1;
      }
      
      public function get createdFlatId() : int
      {
         return var_1644;
      }
      
      public function get eventMod() : Boolean
      {
         return var_1643;
      }
      
      public function startLoading() : void
      {
         this.var_589 = true;
      }
      
      public function isRoomFavourite(param1:int) : Boolean
      {
         return false;
      }
      
      public function set eventMod(param1:Boolean) : void
      {
         var_1643 = param1;
      }
      
      public function set roomEventData(param1:RoomEventData) : void
      {
         if(var_360 != null)
         {
            var_360.dispose();
         }
         var_360 = param1;
      }
      
      public function get popularTagsArrived() : Boolean
      {
         return var_127 != null && var_127 as PopularRoomTagsData != null;
      }
      
      public function get guestRoomSearchArrived() : Boolean
      {
         return var_127 != null && var_127 as GuestRoomSearchResultData != null;
      }
      
      public function get guestRoomSearchResults() : GuestRoomSearchResultData
      {
         return var_127 as GuestRoomSearchResultData;
      }
      
      public function get enteredGuestRoom() : GuestRoomData
      {
         return var_186;
      }
      
      public function onRoomEnter(param1:RoomEntryInfoMessageParser) : void
      {
         var_490 = null;
         var_186 = null;
         _currentRoomOwner = false;
         if(param1.guestRoom)
         {
            _currentRoomOwner = param1.owner;
         }
         else
         {
            var_490 = param1.publicSpace;
            var_360 = null;
         }
      }
      
      public function onRoomExit() : void
      {
         if(var_360 != null)
         {
            var_360.dispose();
            var_360 = null;
         }
         if(var_490 != null)
         {
            var_490.dispose();
            var_490 = null;
         }
         if(var_186 != null)
         {
            var_186.dispose();
            var_186 = null;
         }
         _currentRoomOwner = false;
      }
      
      public function set officialRooms(param1:OfficialRoomsData) : void
      {
         disposeCurrentMsg();
         var_127 = param1;
         var_589 = false;
         if(var_1153 == null)
         {
            var_1153 = param1.topLevelNodes;
         }
      }
      
      public function get settings() : NavigatorSettingsMessageParser
      {
         return var_1313;
      }
      
      public function set popularTags(param1:PopularRoomTagsData) : void
      {
         disposeCurrentMsg();
         var_127 = param1;
         var_589 = false;
      }
      
      public function get currentRoomOwner() : Boolean
      {
         return _currentRoomOwner;
      }
      
      public function getCategoryByIndex(param1:int) : FlatCategory
      {
         if(var_306.length > param1)
         {
            return var_306[param1] as FlatCategory;
         }
         return null;
      }
      
      public function onFavourites(param1:FavouritesMessageParser) : void
      {
         var _loc2_:int = 0;
         this.var_2073 = param1.limit;
         this.var_1062 = param1.favouriteRoomIds.length;
         this.var_707 = new Dictionary();
         for each(_loc2_ in param1.favouriteRoomIds)
         {
            this.var_707[_loc2_] = "yes";
         }
      }
      
      public function get popularTags() : PopularRoomTagsData
      {
         return var_127 as PopularRoomTagsData;
      }
      
      public function get categories() : Array
      {
         return var_306;
      }
      
      public function get enteredPublicSpace() : PublicRoomShortData
      {
         return var_490;
      }
      
      public function set avatarId(param1:int) : void
      {
         var_1647 = param1;
      }
      
      public function get hotRoomPopupOpen() : Boolean
      {
         return var_1646;
      }
      
      public function set guestRoomSearchResults(param1:GuestRoomSearchResultData) : void
      {
         disposeCurrentMsg();
         var_127 = param1;
         var_589 = false;
      }
      
      public function getCategoryIndexById(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < var_306.length)
         {
            if((var_306[_loc2_] as FlatCategory).nodeId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function get canEditRoomSettings() : Boolean
      {
         return var_186 != null && _currentRoomOwner;
      }
      
      public function isLoading() : Boolean
      {
         return this.var_589;
      }
      
      public function set categories(param1:Array) : void
      {
         var_306 = param1;
      }
      
      public function get currentRoomRating() : int
      {
         return var_1648;
      }
      
      public function get publicSpaceNodeId() : int
      {
         return var_1642;
      }
      
      public function set settings(param1:NavigatorSettingsMessageParser) : void
      {
         var_1313 = param1;
      }
      
      private function disposeCurrentMsg() : void
      {
         if(var_127 == null)
         {
            return;
         }
         var_127.dispose();
         var_127 = null;
      }
      
      public function get roomEventData() : RoomEventData
      {
         return var_360;
      }
      
      public function favouriteChanged(param1:int, param2:Boolean) : void
      {
         var_707[param1] = !!param2 ? "yes" : null;
         var_1062 += !!param2 ? 1 : -1;
      }
      
      public function get officialRooms() : OfficialRoomsData
      {
         return var_127 as OfficialRoomsData;
      }
      
      public function get topLevelNodes() : Array
      {
         return var_1153;
      }
      
      public function get avatarId() : int
      {
         return var_1647;
      }
      
      public function isCurrentRoomFavourite() : Boolean
      {
         var _loc1_:int = 0;
         return false;
      }
      
      public function get officialRoomsArrived() : Boolean
      {
         return var_127 != null && var_127 as OfficialRoomsData != null;
      }
      
      public function set hotRoomPopupOpen(param1:Boolean) : void
      {
         var_1646 = param1;
      }
      
      public function set currentRoomRating(param1:int) : void
      {
         var_1648 = param1;
      }
      
      public function set hcMember(param1:Boolean) : void
      {
         var_1645 = param1;
      }
      
      public function set enteredRoom(param1:GuestRoomData) : void
      {
         if(var_186 != null)
         {
            var_186.dispose();
         }
         var_186 = param1;
      }
      
      public function getCategoryById(param1:int) : FlatCategory
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_306)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isCurrentRoomHome() : Boolean
      {
         if(var_186 == null)
         {
            return false;
         }
         var _loc1_:int = 0;
         return this.var_1313.homeRoomId == _loc1_;
      }
      
      public function isFavouritesFull() : Boolean
      {
         return var_1062 >= var_2073;
      }
      
      public function set publicSpaceNodeId(param1:int) : void
      {
         var_1642 = param1;
      }
      
      public function get hcMember() : Boolean
      {
         return var_1645;
      }
      
      public function get canAddFavourite() : Boolean
      {
         return var_186 != null && !_currentRoomOwner;
      }
      
      public function set createdFlatId(param1:int) : void
      {
         var_1644 = param1;
      }
   }
}
