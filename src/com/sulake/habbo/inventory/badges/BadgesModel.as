package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   
   public class BadgesModel implements IInventoryModel
   {
       
      
      private var _view:BadgesView;
      
      private var var_524:ISessionDataManager;
      
      private var _disposed:Boolean = false;
      
      private const const_1489:int = 5;
      
      private var var_164:Array;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _controller:HabboInventory;
      
      public function BadgesModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:ISessionDataManager)
      {
         super();
         _controller = param1;
         _windowManager = param2;
         var_164 = new Array();
         _assets = param4;
         _communication = param3;
         var_524 = param6;
         var_524.events.addEventListener(BadgeImageReadyEvent.BADGE_READY,onBadgeImageReady);
         _view = new BadgesView(this,param2,param4,param5);
      }
      
      public function getBadgeFromInactive(param1:int) : Badge
      {
         return getItemInIndex(param1,0);
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == InventoryCategory.const_260 && false)
         {
            _controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES));
         }
      }
      
      public function saveBadgeSelection() : void
      {
         var _loc4_:* = null;
         var _loc1_:SetActivatedBadgesComposer = new SetActivatedBadgesComposer();
         var _loc2_:Array = getBadges(1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc1_.addActivatedBadge(_loc4_.type);
            _loc3_++;
         }
         _communication.getHabboMainConnection(null).send(_loc1_);
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _view.getWindowContainer();
      }
      
      public function updateView() : void
      {
         _view.updateAll();
      }
      
      public function requestInitialization(param1:int = 0) : void
      {
         _communication.getHabboMainConnection(null).send(new GetBadgesComposer());
      }
      
      public function getSelectedBadge(param1:int = -1) : Badge
      {
         var _loc4_:* = null;
         var _loc2_:Array = getBadges(param1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.isSelected)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function toggleBadgeWearing(param1:String) : void
      {
         var _loc2_:Badge = getBadge(param1);
         if(_loc2_ != null)
         {
            _loc2_.isInUse = !_loc2_.isInUse;
            saveBadgeSelection();
         }
      }
      
      private function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         var _loc2_:Badge = getBadge(param1.badgeId);
         if(_loc2_ != null)
         {
            _loc2_.iconImage = param1.badgeImage.clone();
            updateView();
         }
      }
      
      public function updateBadge(param1:String, param2:Boolean) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc3_:Badge = getBadge(param1);
         var _loc4_:Boolean = false;
         if(_loc3_ != null)
         {
            if(_loc3_.isInUse != param2)
            {
               _loc3_.isInUse = param2;
               _loc4_ = true;
            }
         }
         else
         {
            _loc5_ = _assets.getAssetByName("inventory_thumb_xml");
            _loc6_ = XmlAsset(_loc5_);
            _loc7_ = _windowManager.buildFromXML(XML(_loc6_.content)) as IWindowContainer;
            _loc8_ = new Badge(param1,_loc7_);
            _loc8_.isInUse = param2;
            _loc8_.iconImage = var_524.getBadgeImage(param1);
            var_164.push(_loc8_);
            _loc4_ = true;
         }
      }
      
      public function getMaxActiveCount() : int
      {
         return const_1489;
      }
      
      public function setBadgeSelected(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < var_164.length)
         {
            _loc2_ = var_164[_loc3_] as Badge;
            if(_loc2_ != null)
            {
               if(_loc2_.type == param1)
               {
                  _loc2_.isSelected = true;
               }
               else
               {
                  _loc2_.isSelected = false;
               }
            }
            _loc3_++;
         }
         updateView();
      }
      
      public function getBadgeFromActive(param1:int) : Badge
      {
         return getItemInIndex(param1,1);
      }
      
      public function forceSelection() : void
      {
         var _loc1_:* = null;
         _loc1_ = getSelectedBadge();
         if(_loc1_ != null)
         {
            return;
         }
         var _loc2_:Array = getBadges(0);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            _loc1_ = _loc2_[0] as Badge;
            _loc1_.isSelected = true;
            updateView();
            return;
         }
         var _loc3_:Array = getBadges(1);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc1_ = _loc3_[0] as Badge;
            _loc1_.isSelected = true;
            updateView();
            return;
         }
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Badge
      {
         var _loc3_:Array = getBadges(param2);
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[param1];
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function closingInventoryView() : void
      {
      }
      
      private function getBadge(param1:String) : Badge
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_164.length)
         {
            _loc3_ = var_164[_loc2_];
            if(_loc3_.type == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getBadges(param1:int = -1) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array();
         if(param1 == -1)
         {
            return var_164;
         }
         if(param1 == 0)
         {
            _loc3_ = 0;
            while(_loc3_ < var_164.length)
            {
               if((var_164[_loc3_] as Badge).isInUse == false)
               {
                  _loc2_.push(var_164[_loc3_]);
               }
               _loc3_++;
            }
         }
         else if(param1 == 1)
         {
            _loc3_ = 0;
            while(_loc3_ < var_164.length)
            {
               if((var_164[_loc3_] as Badge).isInUse == true)
               {
                  _loc2_.push(var_164[_loc3_]);
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _controller = null;
            if(_view != null)
            {
               _view.dispose();
            }
            _assets = null;
            _communication = null;
            if(var_524 != null)
            {
               var_524.events.removeEventListener(BadgeImageReadyEvent.BADGE_READY,onBadgeImageReady);
               var_524 = null;
            }
            _disposed = true;
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function removeBadge(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_164.length)
         {
            _loc3_ = var_164[_loc2_];
            if(_loc3_.type == param1)
            {
               var_164.splice(_loc2_,1);
               updateView();
               return;
            }
            _loc2_++;
         }
      }
   }
}
