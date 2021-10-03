package com.sulake.habbo.room.events.warnings
{
   import flash.events.Event;
   
   public class AvatarWalkWarpingWarningEvent extends Event
   {
      
      public static const const_357:String = "WE_AVATAR_WALK_WARPING";
       
      
      public function AvatarWalkWarpingWarningEvent(param1:String = "WE_AVATAR_WALK_WARPING", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
