package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tabs;
   import flash.display.BitmapData;
   
   public class OfficialRoomListCtrl implements IViewCtrl
   {
      
      private static const const_1008:int = 267;
      
      private static const const_1007:int = 70;
      
      private static const const_1009:int = -70;
       
      
      private var var_30:IWindowContainer;
      
      private var _navigator:HabboNavigator;
      
      private var var_1720:UserCountRenderer;
      
      private var _list:IItemListWindow;
      
      public function OfficialRoomListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_1720 = new UserCountRenderer(_navigator);
      }
      
      private function refreshGuestRoomImage(param1:IWindowContainer, param2:OfficialRoomEntryData, param3:IBitmapWrapperWindow) : void
      {
         var _loc4_:String = "guestRoom." + param2.guestRoomData.thumbnail.getAsString();
         if(param3.tags[0] == _loc4_)
         {
            param3.visible = true;
            return;
         }
         Logger.log("Redrawing guest room image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64);
         this._navigator.thumbRenderer.refreshBitmapContent(param3.bitmap,param2.guestRoomData.thumbnail);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc4_);
         param3.visible = true;
      }
      
      private function setEnterArrowVisibility(param1:IWindow, param2:Boolean) : void
      {
         var _loc5_:* = null;
         var _loc3_:IWindowContainer = IWindowContainer(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IWindowContainer = IWindowContainer(_loc3_.findChildByName("enter_room"));
         if(_loc4_ == null)
         {
            return;
         }
         if(param2)
         {
            _navigator.refreshButton(_loc4_,"enter_room_l",true,null,0);
            _navigator.refreshButton(_loc4_,"enter_room_r",true,null,0);
            _loc5_ = IBitmapWrapperWindow(_loc4_.findChildByName("enter_room_m"));
            if(_loc5_.bitmap == null)
            {
               _loc5_.bitmap = _navigator.getButtonImage("enter_room_m");
            }
            _navigator.refreshButton(_loc4_,"enter_room_a",true,null,0);
         }
         _loc4_.visible = param2;
      }
      
      private function handleClick(param1:IWindow) : void
      {
         var _loc2_:OfficialRoomEntryData = this.getEntry(param1);
         if(_loc2_ == null)
         {
            return;
         }
         Logger.log("ENTRY CLICKED: " + _loc2_.picText + ", " + _loc2_.guestRoomData + ", " + _loc2_.publicRoomData + ", " + _loc2_.tag);
         if(_loc2_.guestRoomData != null)
         {
            Logger.log("ENTERING ROOM: " + _loc2_.guestRoomData.flatId);
            _navigator.goToRoom(_loc2_.guestRoomData.flatId,true);
         }
         else if(_loc2_.tag != null)
         {
            Logger.log("MAKING TAG SEARCH: " + _loc2_.tag);
            _navigator.mainViewCtrl.startSearch(Tabs.const_185,Tabs.const_295,_loc2_.tag);
         }
         else if(_loc2_.publicRoomData != null)
         {
            Logger.log("ENTERING PUBLIC SPACE: " + _loc2_.publicRoomData.nodeId);
            _navigator.send(new GetPublicSpaceCastLibsMessageComposer(_loc2_.publicRoomData.nodeId));
            _navigator.mainViewCtrl.close();
         }
         else if(_loc2_.flatCategoryId > 0)
         {
            Logger.log("DOING FLAT CAT SEARCH: " + _loc2_.flatCategoryId);
            _navigator.mainViewCtrl.startSearch(Tabs.const_219,Tabs.const_410,"" + _loc2_.flatCategoryId,MainViewCtrl.const_631);
         }
         else
         {
            Logger.log("Non interactive entry clicked...");
         }
      }
      
      private function refreshPublicSpaceImage(param1:IWindowContainer, param2:OfficialRoomEntryData, param3:IBitmapWrapperWindow) : void
      {
         var _loc4_:String = resolveRoomImageName(param2);
         var _loc5_:String = "publicSpace." + _loc4_ + "." + param2.showDetails;
         if(param3.tags[0] == _loc5_)
         {
            param3.visible = true;
            return;
         }
         param3.x = !!param2.showDetails ? int(const_1009) : 0;
         param3.width = 274;
         if(!_navigator.assets.hasAsset(_loc4_ + "_png"))
         {
            Logger.log("NA: " + _loc4_);
            param3.bitmap = new BitmapData(274,64,false,4291559424);
         }
         else
         {
            Logger.log("av: " + _loc4_);
            param3.bitmap = _navigator.getButtonImage(_loc4_);
         }
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc5_);
         param3.visible = true;
      }
      
      private function getEntry(param1:IWindow) : OfficialRoomEntryData
      {
         var _loc2_:IWindowContainer = param1 as IWindowContainer;
         if(_loc2_ == null || _loc2_.name != "cont")
         {
            Logger.log("Target not cont");
            return null;
         }
         var _loc3_:IWindow = _loc2_.findChildByName("room_image");
         if(_loc3_ == null)
         {
            Logger.log("Room image not found...");
            return null;
         }
         if(_navigator.data.officialRooms == null)
         {
            Logger.log("No official rooms data click");
            return null;
         }
         var _loc4_:int = _loc3_.id;
         Logger.log("Got index: " + _loc4_);
         var _loc5_:OfficialRoomEntryData = _navigator.data.officialRooms.entries[_loc4_];
         if(_loc5_ == null)
         {
            Logger.log("No room found " + _loc4_ + ", " + _navigator.data.officialRooms.entries.length);
            return null;
         }
         return _loc5_;
      }
      
      private function onCell(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            this.setEnterArrowVisibility(param2,true);
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            this.setEnterArrowVisibility(param2,false);
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.handleClick(param2);
         }
      }
      
      private function refreshCustomImage(param1:IWindowContainer, param2:OfficialRoomEntryData, param3:IBitmapWrapperWindow) : void
      {
         var _loc4_:String = "customImage." + param2.picRef;
         if(param3.tags[0] == _loc4_)
         {
            param3.visible = true;
            return;
         }
         Logger.log("Loading custom image: " + param2.picRef);
         param3.x = 0;
         param3.visible = false;
         var _loc5_:OfficialRoomImageLoader = new OfficialRoomImageLoader(_navigator,param2.picRef,param3);
         _loc5_.startLoad();
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push(_loc4_);
      }
      
      private function refreshEntryCaption(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param1.getChildByName("entry_caption"));
         _loc3_.visible = true;
         _loc3_.text = getPopupCaption(param2);
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:OfficialRoomEntryData) : Boolean
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
            refreshCell(_loc4_,param3);
            refreshDetails(_loc4_,param3);
            refreshUserCount(_loc4_,param3);
            _loc4_.visible = true;
            _loc4_.height = 68;
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
      
      private function refreshCell(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("image_cont"));
         _loc3_.findChildByName("room_image").id = param2.index;
         _loc3_.visible = true;
         _loc3_.width = !!param2.showDetails ? int(const_1007) : int(const_1008);
         refreshPicText(_loc3_,param2);
         refreshRoomImage(_loc3_,param2);
      }
      
      private function resolveRoomImageName(param1:OfficialRoomEntryData) : String
      {
         var _loc3_:* = null;
         var _loc2_:Array = param1.publicRoomData.castLibs.split(",");
         for each(_loc3_ in _loc2_)
         {
            if(_navigator.assets.hasAsset(_loc3_ + "_png"))
            {
               return _loc3_;
            }
         }
         return _loc2_[0];
      }
      
      private function refreshEntryDesc(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:String = getPopupDesc(param2);
         if(_loc3_ == "")
         {
            return;
         }
         var _loc5_:ITextWindow = ITextWindow(param1.getChildByName("entry_desc"));
         _loc5_.text = _loc3_;
         _loc5_.visible = true;
      }
      
      private function refreshEmptyImage(param1:IWindowContainer, param2:OfficialRoomEntryData, param3:IBitmapWrapperWindow) : void
      {
         if(param3.tags[0] == "empty")
         {
            param3.visible = true;
            return;
         }
         Logger.log("Redrawing empty image");
         param3.x = 0;
         param3.width = 64;
         param3.bitmap = new BitmapData(64,64,false,4291611852);
         param3.tags.splice(0,param3.tags.length);
         param3.tags.push("empty");
         param3.visible = true;
      }
      
      public function refresh() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:Array = _navigator.data.officialRooms.entries;
         _list.autoArrangeItems = false;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ < _loc1_.length)
            {
               refreshEntry(true,_loc2_,_loc1_[_loc2_]);
            }
            else
            {
               _loc3_ = refreshEntry(false,_loc2_,null);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc2_++;
         }
         _list.autoArrangeItems = true;
      }
      
      public function getPopupCaption(param1:OfficialRoomEntryData) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupCaption;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.roomName;
         }
         if(param1.publicRoomData != null)
         {
            return _navigator.getPublicSpaceName(param1.publicRoomData.unitPropertySet,param1.publicRoomData.worldId);
         }
         if(param1.tag != null && param1.tag != "")
         {
            return param1.tag;
         }
         return "NA";
      }
      
      private function refreshRoomImage(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("room_image"));
         _loc3_.visible = false;
         if(param2.picRef != "")
         {
            refreshCustomImage(param1,param2,_loc3_);
         }
         else if(param2.publicRoomData != null)
         {
            refreshPublicSpaceImage(param1,param2,_loc3_);
         }
         else if(param2.guestRoomData != null)
         {
            refreshGuestRoomImage(param1,param2,_loc3_);
         }
         else
         {
            refreshEmptyImage(param1,param2,_loc3_);
         }
      }
      
      private function refreshDetails(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("details_container"));
         _loc3_.visible = param2.showDetails;
         Logger.log("Refreshing details: " + _loc3_.visible);
         if(!param2.showDetails)
         {
            return;
         }
         Util.hideChildren(_loc3_);
         refreshEntryCaption(_loc3_,param2);
         refreshEntryDesc(_loc3_,param2);
         Logger.log("Refreshed: " + _loc3_.visible + ", " + _loc3_.rectangle);
      }
      
      private function refreshUserCount(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2.showDetails && (param2.type == OfficialRoomEntryData.const_496 || param2.type == OfficialRoomEntryData.TYPE_PUBLIC_SPACE))
         {
            _loc3_ = 3;
            _loc4_ = 34;
            _loc5_ = 13;
            var_1720.refreshUserCount(param2.maxUsers,param1,param2.userCount,"${navigator.usercounttooltip.users}",param1.width - _loc3_ - _loc4_,param1.height - _loc3_ - _loc5_);
         }
      }
      
      public function getPopupDesc(param1:OfficialRoomEntryData) : String
      {
         if(param1.popupCaption != null && param1.popupCaption != "")
         {
            return param1.popupDesc;
         }
         if(param1.guestRoomData != null)
         {
            return param1.guestRoomData.description;
         }
         if(param1.publicRoomData != null)
         {
            return _navigator.getPublicSpaceDesc(param1.publicRoomData.unitPropertySet,param1.publicRoomData.worldId);
         }
         return "";
      }
      
      private function getBgColor(param1:int) : uint
      {
         return param1 % 2 != 0 ? 4294967295 : uint(4292797682);
      }
      
      public function set content(param1:IWindowContainer) : void
      {
         var_30 = param1;
         _list = IItemListWindow(var_30.findChildByName("item_list"));
      }
      
      public function get content() : IWindowContainer
      {
         return var_30;
      }
      
      private function refreshPicText(param1:IWindowContainer, param2:OfficialRoomEntryData) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("picTextContainer"));
         if(param2.picText == "" || param2.showDetails)
         {
            _loc3_.visible = false;
            return;
         }
         _loc3_.visible = true;
         var _loc5_:ITextWindow = ITextWindow(_loc3_.findChildByName("picText"));
         _loc5_.width = param1.width - 30;
         _loc5_.text = param2.picText;
         _loc5_.height = _loc5_.textHeight + 10;
         var _loc6_:* = _loc5_.textHeight > 10;
         var _loc7_:*;
         _loc3_.width = !!_loc6_ ? (_loc7_ = param1.width - 10, _loc3_.width = param1.width - 10, int(_loc7_)) : int(_loc5_.textWidth + 20);
         _loc3_.height = _loc5_.height + 4;
         _loc3_.x = param1.width - _loc3_.width - 5;
         _loc3_.y = param1.height - _loc3_.height - 5;
      }
      
      private function getListEntry(param1:int) : IWindowContainer
      {
         var _loc2_:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_official_room_row"));
         var _loc3_:IWindowContainer = IWindowContainer(_loc2_.findChildByName("image_cont"));
         var _loc4_:String = param1 % 2 == 0 ? "_b" : "";
         _navigator.refreshButton(_loc3_,"rico_rnd_l" + _loc4_,true,null,0);
         _navigator.refreshButton(_loc3_,"rico_rnd_r" + _loc4_,true,null,0);
         IBitmapWrapperWindow(_loc3_.findChildByName("rico_rnd_m")).bitmap = _navigator.getButtonImage("rico_rnd_m");
         _loc2_.procedure = onCell;
         _loc2_.color = getBgColor(param1);
         return _loc2_;
      }
   }
}
