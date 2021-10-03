package com.sulake.room.utils
{
   public class XMLValidator
   {
       
      
      public function XMLValidator()
      {
         super();
      }
      
      public static function checkRequiredAttributes(param1:Object, param2:Array) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:int = 0;
         if(param1 is XML)
         {
            _loc4_ = param1 as XML;
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(_loc4_.attribute(String(param2[_loc3_])).length() == 0)
               {
                  return false;
               }
               _loc3_++;
            }
         }
         else
         {
            if(!(param1 is XMLList))
            {
               return false;
            }
            _loc5_ = param1 as XMLList;
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(_loc4_.attribute(String(param2[_loc3_])).length() == 0)
               {
                  return false;
               }
               _loc3_++;
            }
         }
         return true;
      }
   }
}
