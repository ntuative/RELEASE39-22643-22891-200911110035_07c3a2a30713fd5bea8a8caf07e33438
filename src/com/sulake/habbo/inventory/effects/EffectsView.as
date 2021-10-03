package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   import com.sulake.habbo.inventory.common.ThumbListManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EffectsView implements IInventoryView
   {
       
      
      private var _view:IWindowContainer;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _disposed:Boolean = false;
      
      private var var_516:ThumbListManager;
      
      private var var_515:ThumbListManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _model:EffectsModel;
      
      public function EffectsView(param1:EffectsModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IThumbListDataProvider, param6:IThumbListDataProvider)
      {
         super();
         _model = param1;
         _assetLibrary = param3;
         _windowManager = param2;
         var _loc7_:IAsset = _assetLibrary.getAssetByName("inventory_effects_xml");
         var _loc8_:XmlAsset = XmlAsset(_loc7_);
         var _loc9_:ICoreWindowManager = ICoreWindowManager(_windowManager);
         _view = IWindowContainer(_loc9_.buildFromXML(XML(_loc8_.content)));
         _view.visible = false;
         _view.procedure = windowEventProc;
         var_515 = new ThumbListManager(_assetLibrary,param5,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var_516 = new ThumbListManager(_assetLibrary,param6,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var _loc10_:IBitmapWrapperWindow = _view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         _loc10_.procedure = activeThumbListEventProc;
         var _loc11_:IBitmapWrapperWindow = _view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         _loc11_.procedure = inactiveThumbListEventProc;
         _view.procedure = windowEventProc;
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(param2.name == "activateEffect_button")
            {
               _loc3_ = _model.getSelectedEffect(0);
               if(_loc3_ != null)
               {
                  _model.requestEffectActivated(_loc3_.type);
               }
            }
         }
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
      
      public function getActiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = _view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      private function activeThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc4_ = var_515.resolveIndexFromImageLocation(_loc3_);
            _loc5_ = _model.getItemInIndex(_loc4_,1);
            if(_loc5_ != null)
            {
               _model.toggleEffectSelected(_loc5_.type);
            }
         }
      }
      
      public function getActiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = _view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      private function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc3_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc4_:int = param1 - _loc2_ * 60 * 60 - _loc3_ * 60;
         var _loc5_:* = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
         _loc5_ += ":";
         return _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_;
      }
      
      public function updateActionView() : void
      {
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:IButtonWindow = _view.findChildByName("activateEffect_button") as IButtonWindow;
         var _loc2_:ITextWindow = _view.findChildByName("effectDescriptionText") as ITextWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Effect = _model.getSelectedEffect(-1);
         if(_loc3_ == null)
         {
            _loc1_.disable();
            setEffectDescriptionImage(null);
            _loc2_.text = "${inventory.effects.defaultdescription}";
         }
         else if(_loc3_.isActive)
         {
            _loc1_.disable();
            setEffectDescriptionImage(_loc3_.iconImage);
            _loc2_.text = "${inventory.effects.active}";
            _windowManager.registerLocalizationParameter("inventory.effects.active","timeleft",convertSecondsToTime(_loc3_.secondsLeft));
            _windowManager.registerLocalizationParameter("inventory.effects.active","duration",convertSecondsToTime(_loc3_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.active","itemcount",String(_loc3_.effectsInInventory));
         }
         else
         {
            _loc1_.enable();
            setEffectDescriptionImage(_loc3_.iconImage);
            _loc2_.text = "${inventory.effects.inactive}";
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","duration",convertSecondsToTime(_loc3_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","itemcount",String(_loc3_.effectsInInventory));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            _model = null;
            _view = null;
            if(var_515 != null)
            {
               var_515.dispose();
               var_515 = null;
            }
            if(var_516 != null)
            {
               var_516.dispose();
               var_516 = null;
            }
            _disposed = true;
         }
      }
      
      public function updateListViews() : void
      {
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var_516.updateImageFromList();
         var_515.updateImageFromList();
         var _loc1_:IBitmapWrapperWindow = _view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         var _loc2_:BitmapData = var_516.getListImage();
         _loc1_.bitmap = _loc2_;
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height;
         _loc1_.invalidate();
         var _loc3_:IBitmapWrapperWindow = _view.findChildByName("active_items_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapData = var_515.getListImage();
         _loc3_.bitmap = _loc4_;
         _loc3_.width = _loc4_.width;
         _loc3_.height = _loc4_.height;
         _loc3_.invalidate();
      }
      
      private function inactiveThumbListEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc4_ = var_516.resolveIndexFromImageLocation(_loc3_);
            _loc5_ = _model.getItemInIndex(_loc4_,0);
            if(_loc5_ != null)
            {
               _model.toggleEffectSelected(_loc5_.type);
            }
         }
      }
      
      public function getInactiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperWindow = _view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      private function setEffectDescriptionImage(param1:BitmapData) : void
      {
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _view.findChildByName("effectDescriptionImage") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap == null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,false);
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc2_.width,_loc2_.height);
         }
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,false);
         _loc2_.invalidate();
      }
      
      public function getInactiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperWindow = _view.findChildByName("inactive_items_image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
   }
}
