package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.Map;
   import flash.utils.getTimer;
   
   public class AvatarImageActionCache
   {
       
      
      private var var_1512:int;
      
      private var var_138:Map;
      
      public function AvatarImageActionCache()
      {
         super();
         var_138 = new Map();
         setLastAccessTime();
      }
      
      public function setLastAccessTime() : void
      {
         var_1512 = getTimer();
      }
      
      private function debugInfo(param1:String) : void
      {
      }
      
      public function getLastAccessTime() : int
      {
         return var_1512;
      }
      
      public function getDirectionCache(param1:int) : AvatarImageDirectionCache
      {
         var _loc2_:String = param1.toString();
         return var_138.getValue(_loc2_) as AvatarImageDirectionCache;
      }
      
      public function updateDirectionCache(param1:int, param2:AvatarImageDirectionCache) : void
      {
         var _loc3_:String = param1.toString();
         var_138.add(_loc3_,param2);
      }
      
      public function dispose() : void
      {
         debugInfo("[dispose]");
         if(var_138 == null)
         {
            return;
         }
         var_138.dispose();
      }
   }
}
