package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_674:String = "RWFIUE_FURNI";
       
      
      private var var_1007:Boolean = false;
      
      private var _id:int = 0;
      
      private var var_1008:Boolean = false;
      
      private var var_1581:Boolean = false;
      
      private var _image:BitmapData = null;
      
      private var _category:int = 0;
      
      private var var_1582:Boolean = false;
      
      private var var_1583:Boolean = false;
      
      private var _name:String = "";
      
      private var var_1011:String = "";
      
      public function RoomWidgetFurniInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set isRoomController(param1:Boolean) : void
      {
         var_1007 = param1;
      }
      
      public function get description() : String
      {
         return var_1011;
      }
      
      public function set isStickie(param1:Boolean) : void
      {
         var_1582 = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set isWallItem(param1:Boolean) : void
      {
         var_1583 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_1008;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_1581;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_1583;
      }
      
      public function get isRoomController() : Boolean
      {
         return var_1007;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get isStickie() : Boolean
      {
         return var_1582;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_1008 = param1;
      }
      
      public function set isAnyRoomController(param1:Boolean) : void
      {
         var_1581 = param1;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set category(param1:int) : void
      {
         _category = param1;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function set description(param1:String) : void
      {
         var_1011 = param1;
      }
   }
}
