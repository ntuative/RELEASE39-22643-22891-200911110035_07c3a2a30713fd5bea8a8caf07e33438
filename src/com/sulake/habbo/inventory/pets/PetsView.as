package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class PetsView implements IInventoryView
   {
       
      
      private var _view:IWindowContainer;
      
      private var _model:PetsModel;
      
      private var _disposed:Boolean = false;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      public function PetsView(param1:PetsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super();
         _model = param1;
         _assetLibrary = param3;
         _windowManager = param2;
         var _loc5_:XmlAsset = _assetLibrary.getAssetByName("inventory_pets_view_xml") as XmlAsset;
         if(_loc5_ == null || _loc5_.content == null)
         {
            return;
         }
         _view = _windowManager.buildFromXML(_loc5_.content as XML) as IWindowContainer;
         if(_view == null)
         {
            return;
         }
         _view.visible = false;
         _view.procedure = windowEventHandler;
         updateList();
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowEvent.const_51)
         {
            switch(param2.name)
            {
               case "tab_floor":
                  _model.switchCategory(FurniModel.const_39);
                  break;
               case "tab_wall":
                  _model.switchCategory(FurniModel.const_41);
            }
         }
      }
      
      private function placeButtonClickHandler(param1:WindowMouseEvent) : void
      {
         _model.placePetToRoom(param1.window.id);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function updateList() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:ISelectorWindow = _view.findChildByName("category_selector") as ISelectorWindow;
         _loc1_.setSelected(_loc1_.getSelectableByName("tab_pets"));
         var _loc2_:IItemListWindow = _view.getChildByName("pet_list") as IItemListWindow;
         _loc2_.destroyListItems();
         var _loc3_:Array = _model.pets;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = createListItem(_loc4_);
            if(_loc5_ != null)
            {
               _loc2_.addListItem(_loc5_);
            }
         }
      }
      
      private function createListItem(param1:PetData) : IWindowContainer
      {
         var _loc2_:XmlAsset = _assetLibrary.getAssetByName("pets_list_item_xml") as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return null;
         }
         var _loc3_:IWindowContainer = _windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         var _loc4_:ITextWindow = _loc3_.findChildByName("name") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.caption = param1.name;
         }
         var _loc5_:IButtonWindow = _loc3_.findChildByName("place_button") as IButtonWindow;
         if(_loc5_ != null)
         {
            _loc5_.id = param1.id;
            _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,placeButtonClickHandler);
         }
         return _loc3_;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(_view == null)
         {
            return null;
         }
         if(false)
         {
            return null;
         }
         return _view;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            _model = null;
            _view = null;
            _disposed = true;
         }
      }
   }
}
