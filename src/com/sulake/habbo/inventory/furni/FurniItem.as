package com.sulake.habbo.inventory.furni
{
   import flash.display.BitmapData;
   
   public class FurniItem
   {
       
      
      private var _isSelected:Boolean = false;
      
      private var var_1670:int;
      
      private var var_1669:Boolean;
      
      private var var_1496:int;
      
      private var var_1666:String;
      
      private var var_1667:Boolean = false;
      
      private var var_1668:int;
      
      private var var_392:int;
      
      private var var_845:String;
      
      private var var_1472:String;
      
      private var _image:BitmapData;
      
      private var _objId:int;
      
      private var var_1199:int;
      
      private var var_1671:Boolean;
      
      private var var_1665:int;
      
      public function FurniItem(param1:int, param2:String, param3:int, param4:int, param5:String, param6:Boolean, param7:Boolean, param8:int, param9:String, param10:int)
      {
         super();
         var_1670 = param1;
         var_845 = param2;
         _objId = param3;
         var_1199 = param4;
         var_1666 = param5;
         var_1669 = param6;
         var_1671 = param7;
         var_1668 = param8;
         var_1472 = param9;
         var_1496 = param10;
         var_392 = -1;
      }
      
      public function get songId() : int
      {
         return var_1496;
      }
      
      public function get iconCallbackId() : int
      {
         return var_392;
      }
      
      public function get expiryTime() : int
      {
         return var_1668;
      }
      
      public function set prevCallbackId(param1:int) : void
      {
         var_1665 = param1;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         var_1667 = param1;
      }
      
      public function set iconCallbackId(param1:int) : void
      {
         var_392 = param1;
      }
      
      public function get isTradeable() : Boolean
      {
         return var_1671;
      }
      
      public function get slotId() : String
      {
         return var_1472;
      }
      
      public function get classId() : int
      {
         return var_1199;
      }
      
      public function get isRecyclable() : Boolean
      {
         return var_1669;
      }
      
      public function get stuffData() : String
      {
         return var_1666;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function get stripId() : int
      {
         return var_1670;
      }
      
      public function get isLocked() : Boolean
      {
         return var_1667;
      }
      
      public function get prevCallbackId() : int
      {
         return var_1665;
      }
      
      public function get iconImage() : BitmapData
      {
         return _image;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get method_4() : int
      {
         return _objId;
      }
      
      public function get itemType() : String
      {
         return var_845;
      }
   }
}
