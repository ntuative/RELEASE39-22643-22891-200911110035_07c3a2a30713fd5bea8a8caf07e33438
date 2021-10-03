package com.sulake.habbo.avatar.common
{
   public class CategoryData
   {
       
      
      private var _data:Array;
      
      private var _index:int = -1;
      
      private var var_595:int = -1;
      
      private var var_315:Array;
      
      public function CategoryData(param1:Array, param2:Array)
      {
         super();
         _data = param1;
         var_315 = param2;
      }
      
      public function get currentColourId() : int
      {
         var _loc1_:AvatarEditorColorItem = currentColour;
         if(_loc1_ != null)
         {
            return _loc1_.partColor.id;
         }
         return -1;
      }
      
      public function select(param1:int) : AvatarEditorGridItem
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_index >= 0)
         {
            _loc3_ = _data[_index];
            _loc3_.isSelected = false;
         }
         if(_data.length > param1)
         {
            _loc2_ = _data[param1] as AvatarEditorGridItem;
            _loc2_.isSelected = true;
         }
         _index = param1;
         return _loc2_;
      }
      
      public function get currentColour() : AvatarEditorColorItem
      {
         if(var_595 > -1)
         {
            return var_315[var_595] as AvatarEditorColorItem;
         }
         return null;
      }
      
      public function selectColour(param1:int) : AvatarEditorColorItem
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_595 >= 0)
         {
            _loc3_ = var_315[var_595];
            _loc3_.isSelected = false;
         }
         if(var_315.length > param1)
         {
            _loc2_ = var_315[param1] as AvatarEditorColorItem;
            _loc2_.isSelected = true;
         }
         var_595 = param1;
         updateColours(_loc2_);
         return _loc2_;
      }
      
      public function selectColourWithId(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_315.length)
         {
            _loc3_ = var_315[_loc2_];
            if(_loc3_.partColor.id == param1)
            {
               selectColour(_loc2_);
               return;
            }
            _loc2_++;
         }
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function selectItemWithId(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < _data.length)
         {
            _loc3_ = _data[_loc2_];
            if(_loc3_.id == param1)
            {
               select(_loc2_);
               return;
            }
            _loc2_++;
         }
      }
      
      public function get palette() : Array
      {
         return var_315;
      }
      
      private function updateColours(param1:AvatarEditorColorItem) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in _data)
         {
            _loc2_.color = param1.partColor;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in _data)
         {
            _loc1_.dispose();
         }
         for each(_loc2_ in var_315)
         {
            _loc2_.dispose();
         }
         _data = null;
         var_315 = null;
         _index = -1;
         var_595 = -1;
      }
   }
}
