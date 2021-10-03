package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   
   public class EffectsModel implements IInventoryModel
   {
       
      
      private var var_251:Array;
      
      private var _view:EffectsView;
      
      private var var_747:EffectListProxy;
      
      private var _disposed:Boolean = false;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _assets:IAssetLibrary;
      
      private var _controller:HabboInventory;
      
      private var _inactiveEffectsProxy:EffectListProxy;
      
      public function EffectsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager)
      {
         super();
         _controller = param1;
         var_251 = new Array();
         _assets = param4;
         _communication = param3;
         var_747 = new EffectListProxy(this,1);
         _inactiveEffectsProxy = new EffectListProxy(this,0);
         _view = new EffectsView(this,param2,param4,param5,var_747,_inactiveEffectsProxy);
      }
      
      public function toggleEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isSelected)
            {
               setEffectDeselected(param1);
            }
            else
            {
               setEffectSelected(param1);
            }
            refreshViews();
         }
      }
      
      public function getSelectedEffect(param1:int = -1) : Effect
      {
         var _loc4_:* = null;
         var _loc2_:Array = getEffects(param1);
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
      
      private function getEffect(param1:int) : Effect
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_251.length)
         {
            _loc3_ = var_251[_loc2_];
            if(_loc3_.type == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return _view.getWindowContainer();
      }
      
      public function getEffects(param1:int = -1) : Array
      {
         var _loc4_:* = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < var_251.length)
         {
            _loc4_ = var_251[_loc3_];
            if(_loc4_.isActive && param1 == 1 || !_loc4_.isActive && param1 == 0 || param1 == -1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            setAllEffectsDeselected(false);
            _loc2_.isSelected = true;
            refreshViews();
         }
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function requestInitialization(param1:int = 0) : void
      {
      }
      
      public function refreshViews() : void
      {
         _view.updateListViews();
         _view.updateActionView();
      }
      
      public function addEffect(param1:Effect, param2:Boolean = true) : void
      {
         var _loc4_:* = null;
         var _loc3_:Effect = getEffect(param1.type);
         if(_loc3_ != null)
         {
            ++_loc3_.effectsInInventory;
         }
         else
         {
            _loc4_ = BitmapDataAsset(_assets.getAssetByName("fx_icon_" + param1.type + "_png"));
            if(_loc4_ != null)
            {
               param1.iconImage = BitmapData(_loc4_.content);
            }
            var_251.push(param1);
         }
         if(param2)
         {
            refreshViews();
         }
      }
      
      public function stopUsingAllEffects(param1:Boolean = true, param2:Boolean = true) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < var_251.length)
         {
            _loc4_ = var_251[_loc3_];
            _loc4_.isInUse = false;
            _loc3_++;
         }
         if(param1)
         {
            _controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
         }
         if(param2)
         {
            refreshViews();
         }
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Effect
      {
         var _loc3_:Array = getEffects(param2);
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
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _controller = null;
            if(_view != null)
            {
               _view.dispose();
            }
            if(var_747 != null)
            {
               var_747.dispose();
               var_747 = null;
            }
            if(_inactiveEffectsProxy != null)
            {
               _inactiveEffectsProxy.dispose();
               _inactiveEffectsProxy = null;
            }
            _disposed = true;
         }
      }
      
      public function setEffectDeselected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            _loc2_.isSelected = false;
            refreshViews();
         }
      }
      
      public function setEffectExpired(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.effectsInInventory > 1)
            {
               _loc2_.setOneEffectExpired();
               refreshViews();
            }
            else
            {
               removeEffect(_loc2_.type);
            }
         }
      }
      
      public function stopUsingEffect(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Effect = getEffect(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.isInUse == true)
            {
               _loc3_.isInUse = false;
               if(param2)
               {
                  _controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(-1));
               }
               refreshViews();
            }
         }
      }
      
      private function getEffectIndex(param1:int, param2:int = -1) : int
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Effect = getEffect(param1);
         if(_loc3_ != null)
         {
            _loc4_ = getEffects(param2);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_];
               if(_loc6_.type == param1)
               {
                  return _loc5_;
               }
               _loc5_++;
            }
         }
         return -1;
      }
      
      public function requestEffectActivated(param1:int) : void
      {
         _controller.communication.getHabboMainConnection(null).send(new AvatarEffectActivatedComposer(param1));
      }
      
      public function closingInventoryView() : void
      {
      }
      
      private function removeEffect(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_251.length)
         {
            _loc3_ = var_251[_loc2_];
            if(_loc3_.type == param1)
            {
               var_251.splice(_loc2_,1);
               refreshViews();
               return;
            }
            _loc2_++;
         }
      }
      
      private function setAllEffectsDeselected(param1:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_251.length)
         {
            _loc3_ = var_251[_loc2_];
            _loc3_.isSelected = false;
            _loc2_++;
         }
         if(param1)
         {
            refreshViews();
         }
      }
      
      public function useEffect(param1:int) : void
      {
         stopUsingAllEffects(false,false);
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(!_loc2_.isActive)
         {
            requestEffectActivated(_loc2_.type);
         }
         if(_loc2_.isInUse == false)
         {
            _loc2_.isInUse = true;
            _controller.communication.getHabboMainConnection(null).send(new AvatarEffectSelectedComposer(param1));
            refreshViews();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function setEffectActivated(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            stopUsingAllEffects(false,false);
            _loc2_.isActive = true;
            _loc2_.isInUse = true;
            refreshViews();
         }
      }
   }
}
