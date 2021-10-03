package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   
   public class PetsModel implements IInventoryModel
   {
       
      
      private var _view:PetsView;
      
      private var _disposed:Boolean = false;
      
      private var var_876:Array;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _assets:IAssetLibrary;
      
      private var _controller:HabboInventory;
      
      public function PetsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:IRoomEngine)
      {
         super();
         _controller = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param6;
         _view = new PetsView(this,param2,param4,param5);
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _view.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == InventoryCategory.const_286 && false)
         {
            _controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_PETS));
         }
      }
      
      public function updateView() : void
      {
         if(_view == null)
         {
            return;
         }
         _view.updateList();
      }
      
      public function requestInitialization(param1:int = 0) : void
      {
         _communication.getHabboMainConnection(null).send(new GetPetInventoryComposer());
      }
      
      public function switchCategory(param1:String) : void
      {
         _controller.furniModel.switchCategory(param1);
         _controller.toggleInventoryPage(InventoryCategory.const_80);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set pets(param1:Array) : void
      {
         var_876 = param1;
      }
      
      public function refreshViews() : void
      {
         _view.updateList();
      }
      
      public function get pets() : Array
      {
         return var_876;
      }
      
      public function placePetToRoom(param1:int) : void
      {
         _controller.communication.getHabboMainConnection(null).send(new PlacePetMessageComposer(param1));
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
            _disposed = true;
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
   }
}
