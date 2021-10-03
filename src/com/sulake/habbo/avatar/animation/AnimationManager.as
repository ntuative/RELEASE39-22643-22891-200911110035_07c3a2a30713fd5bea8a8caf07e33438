package com.sulake.habbo.avatar.animation
{
   import com.sulake.habbo.avatar.AvatarStructure;
   import flash.utils.Dictionary;
   
   public class AnimationManager
   {
       
      
      private var var_373:Dictionary;
      
      public function AnimationManager()
      {
         super();
         var_373 = new Dictionary();
      }
      
      public function registerAnimation(param1:AvatarStructure, param2:XML) : Boolean
      {
         var _loc3_:String = String(param2.@name);
         var_373[_loc3_] = new Animation(param1,param2);
         return true;
      }
      
      public function getAnimation(param1:String) : Animation
      {
         return var_373[param1] as Animation;
      }
      
      public function getLayerData(param1:String, param2:int, param3:String) : AnimationLayerData
      {
         var _loc4_:Animation = var_373[param1] as Animation;
         if(_loc4_ != null)
         {
            return _loc4_.getLayerData(param2,param3);
         }
         return null;
      }
   }
}
