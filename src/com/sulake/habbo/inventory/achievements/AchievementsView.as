package com.sulake.habbo.inventory.achievements
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AchievementsView implements IInventoryView
   {
       
      
      private var _view:IWindowContainer;
      
      private var _model:AchievementsModel;
      
      private var _disposed:Boolean = false;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      public function AchievementsView(param1:AchievementsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super();
         _model = param1;
         _assetLibrary = param3;
         _windowManager = param2;
         var _loc5_:IAsset = _assetLibrary.getAssetByName("inventory_achievements_xml");
         var _loc6_:XmlAsset = XmlAsset(_loc5_);
         var _loc7_:ICoreWindowManager = ICoreWindowManager(_windowManager);
         _view = IWindowContainer(_loc7_.buildFromXML(XML(_loc6_.content)));
         _view.visible = false;
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
         var _loc1_:IItemListWindow = _view.getChildByName("achievements_itemlist") as IItemListWindow;
         _loc1_.destroyListItems();
         var _loc2_:Array = _model.getAchievements();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as Achievement;
            _loc5_ = createListItem(_loc4_);
            if(_loc5_ != null)
            {
               _loc1_.addListItem(_loc5_);
            }
            _loc3_++;
         }
      }
      
      private function createListItem(param1:Achievement) : IWindowContainer
      {
         var _loc2_:IAsset = _assetLibrary.getAssetByName("inventory_achievement_item_xml");
         var _loc3_:XmlAsset = XmlAsset(_loc2_);
         var _loc4_:ICoreWindowManager = ICoreWindowManager(_windowManager);
         var _loc5_:IWindowContainer = IWindowContainer(_loc4_.buildFromXML(XML(_loc3_.content)));
         var _loc6_:IBitmapWrapperWindow = _loc5_.findChildByName("achievement_image") as IBitmapWrapperWindow;
         if(_loc5_ == null)
         {
            return null;
         }
         if(_loc6_.bitmap == null)
         {
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,false);
         }
         var _loc7_:Point = new Point((_loc6_.width - param1.image.width) / 2,(_loc6_.height - param1.image.height) / 2);
         _loc6_.bitmap.copyPixels(param1.image,param1.image.rect,_loc7_,null,null,false);
         var _loc8_:ITextWindow = _loc5_.findChildByName("achievement_name") as ITextWindow;
         if(_loc8_ == null)
         {
            return null;
         }
         _loc8_.text = "${badge_name_" + param1.badgeId + "}";
         var _loc9_:ITextWindow = _loc5_.findChildByName("achievement_description") as ITextWindow;
         if(_loc9_ == null)
         {
            return null;
         }
         _loc9_.text = "${badge_desc_" + param1.badgeId + "}";
         return _loc5_;
      }
      
      public function updateListItem(param1:int, param2:Achievement) : void
      {
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc3_:IItemListWindow = _view.getChildByName("achievements_itemlist") as IItemListWindow;
         var _loc4_:IWindowContainer = createListItem(param2);
         if(_loc4_ != null)
         {
            _loc3_.removeListItemAt(param1);
            _loc3_.addListItemAt(_loc4_,param1);
         }
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
