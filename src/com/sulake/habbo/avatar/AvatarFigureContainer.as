package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   
   public class AvatarFigureContainer
   {
       
      
      private var var_492:Map;
      
      public function AvatarFigureContainer(param1:String)
      {
         super();
         var_492 = new Map();
         parseFigureString(param1);
      }
      
      public function getPartSetId(param1:String) : int
      {
         var _loc2_:Map = getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("setid") as int;
         }
         return 0;
      }
      
      public function getPartTypeIds() : Array
      {
         return getParts().getKeys();
      }
      
      public function hasPartType(param1:String) : Boolean
      {
         return getParts().getValue(param1) != null;
      }
      
      private function parseFigureString(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for each(_loc2_ in param1.split("."))
         {
            _loc3_ = _loc2_.split("-");
            if(_loc3_.length > 0)
            {
               _loc4_ = String(_loc3_[0]);
               _loc5_ = parseInt(_loc3_[1]);
               _loc6_ = parseInt(_loc3_[2]);
               updatePart(_loc4_,_loc5_,_loc6_);
            }
         }
      }
      
      private function getParts() : Map
      {
         if(var_492 == null)
         {
            var_492 = new Map();
         }
         return var_492;
      }
      
      public function updatePart(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:Map = new Map();
         _loc4_.add("type",param1);
         _loc4_.add("setid",param2);
         _loc4_.add("colorid",param3);
         var _loc5_:Map = getParts();
         _loc5_.remove(param1);
         _loc5_.add(param1,_loc4_);
      }
      
      public function getPartColorId(param1:String) : int
      {
         var _loc2_:Map = getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("colorid") as int;
         }
         return 0;
      }
      
      public function removePart(param1:String) : void
      {
         getParts().remove(param1);
      }
   }
}
