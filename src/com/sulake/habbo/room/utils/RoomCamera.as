package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomCamera
   {
      
      private static const const_325:Number = 0.5;
      
      private static const const_709:int = 3;
      
      private static const const_995:Number = 1;
       
      
      private var var_1685:Boolean = false;
      
      private var _targetCategory:int = -2;
      
      private var var_1682:Boolean = false;
      
      private var var_1684:Boolean = false;
      
      private var var_1683:Boolean = false;
      
      private var var_1686:int = -1;
      
      private var var_883:int = 0;
      
      private var var_242:Vector3d = null;
      
      private var var_362:Vector3d = null;
      
      public function RoomCamera()
      {
         super();
      }
      
      public function get limitedLocationX() : Boolean
      {
         return var_1682;
      }
      
      public function get limitedLocationY() : Boolean
      {
         return var_1684;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = null;
         if(var_362 != null && var_242 != null)
         {
            ++var_883;
            _loc2_ = Vector3d.dif(var_362,var_242);
            if(_loc2_.length <= const_325)
            {
               var_242 = var_362;
               var_362 = null;
            }
            else
            {
               _loc2_.div(_loc2_.length);
               if(_loc2_.length < const_325 * (const_709 + 1))
               {
                  _loc2_.mul(const_325);
               }
               else if(var_883 <= const_709)
               {
                  _loc2_.mul(const_325);
               }
               else
               {
                  _loc2_.mul(const_995);
               }
               var_242 = Vector3d.sum(var_242,_loc2_);
            }
         }
      }
      
      public function set limitedLocationX(param1:Boolean) : void
      {
         var_1682 = param1;
      }
      
      public function set centeredLocY(param1:Boolean) : void
      {
         var_1683 = param1;
      }
      
      public function get targetId() : int
      {
         return var_1686;
      }
      
      public function set targetCategory(param1:int) : void
      {
         _targetCategory = param1;
      }
      
      public function set target(param1:IVector3d) : void
      {
         if(var_362 == null)
         {
            var_362 = new Vector3d();
         }
         var_362.assign(param1);
         var_883 = 0;
      }
      
      public function set limitedLocationY(param1:Boolean) : void
      {
         var_1684 = param1;
      }
      
      public function initializeLocation(param1:IVector3d) : void
      {
         if(var_242 != null)
         {
            return;
         }
         var_242 = new Vector3d();
         var_242.assign(param1);
      }
      
      public function set targetId(param1:int) : void
      {
         var_1686 = param1;
      }
      
      public function dispose() : void
      {
         var_362 = null;
         var_242 = null;
      }
      
      public function get targetCategory() : int
      {
         return _targetCategory;
      }
      
      public function get centeredLocX() : Boolean
      {
         return var_1685;
      }
      
      public function get centeredLocY() : Boolean
      {
         return var_1683;
      }
      
      public function get location() : IVector3d
      {
         return var_242;
      }
      
      public function set centeredLocX(param1:Boolean) : void
      {
         var_1685 = param1;
      }
   }
}
