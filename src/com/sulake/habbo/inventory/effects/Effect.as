package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
   import com.sulake.habbo.widget.memenu.IWidgetAvatarEffect;
   import flash.display.BitmapData;
   
   public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem
   {
       
      
      private var _isSelected:Boolean = false;
      
      private var var_1994:Date;
      
      private var var_1190:Boolean = false;
      
      private var _type:int;
      
      private var var_335:BitmapData;
      
      private var var_318:Boolean = false;
      
      private var var_1108:int;
      
      private var var_533:int = 1;
      
      private var var_956:int;
      
      public function Effect()
      {
         super();
      }
      
      public function get icon() : BitmapData
      {
         return var_335;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function setOneEffectExpired() : void
      {
         --var_533;
         if(var_533 < 0)
         {
            var_533 = 0;
         }
         var_956 = var_1108;
         var_318 = false;
         var_1190 = false;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function set secondsLeft(param1:int) : void
      {
         var_956 = param1;
      }
      
      public function get isActive() : Boolean
      {
         return var_318;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_335 = param1;
      }
      
      public function get duration() : int
      {
         return var_1108;
      }
      
      public function get isInUse() : Boolean
      {
         return var_1190;
      }
      
      public function get effectsInInventory() : int
      {
         return var_533;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_335;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 && !var_318)
         {
            var_1994 = new Date();
         }
         var_318 = param1;
      }
      
      public function set effectsInInventory(param1:int) : void
      {
         var_533 = param1;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         if(var_318)
         {
            _loc1_ = var_956 - (new Date().valueOf() - var_1994.valueOf()) / 1000;
            _loc1_ = Math.floor(_loc1_);
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return var_956;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_1190 = param1;
      }
      
      public function set duration(param1:int) : void
      {
         var_1108 = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}
