package com.sulake.habbo.help.cfh.data
{
   import com.sulake.core.utils.Map;
   
   public class UserRegistry
   {
      
      private static const const_1010:int = 80;
       
      
      private var var_425:Map;
      
      private var var_603:String = "";
      
      private var var_1094:Array;
      
      public function UserRegistry()
      {
         var_425 = new Map();
         var_1094 = new Array();
         super();
      }
      
      private function addRoomNameForMissing() : void
      {
         var _loc1_:* = null;
         while(false)
         {
            _loc1_ = var_425.getValue(var_1094.shift());
            if(_loc1_ != null)
            {
               _loc1_.roomName = var_603;
            }
         }
      }
      
      public function registerUser(param1:int, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:* = null;
         if(var_425.getValue(param1) != null)
         {
            var_425.remove(param1);
         }
         if(param3)
         {
            _loc4_ = new UserRegistryItem(param1,param2,var_603);
         }
         else
         {
            _loc4_ = new UserRegistryItem(param1,param2);
         }
         if(param3 && var_603 == "")
         {
            var_1094.push(param1);
         }
         var_425.add(param1,_loc4_);
         purgeUserIndex();
      }
      
      public function getRegistry() : Map
      {
         return var_425;
      }
      
      public function unregisterRoom() : void
      {
         var_603 = "";
      }
      
      private function purgeUserIndex() : void
      {
         var _loc1_:int = 0;
         while(var_425.length > const_1010)
         {
            _loc1_ = var_425.getKey(0);
            var_425.remove(_loc1_);
         }
      }
      
      public function registerRoom(param1:String) : void
      {
         var_603 = param1;
         if(var_603 != "")
         {
            addRoomNameForMissing();
         }
      }
   }
}
