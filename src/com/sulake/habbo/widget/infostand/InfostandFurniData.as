package com.sulake.habbo.widget.infostand
{
   import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfostandFurniData
   {
       
      
      private var _category:int = 0;
      
      private var _name:String = "";
      
      private var _id:int = 0;
      
      private var _image:BitmapData;
      
      private var var_1011:String = "";
      
      public function InfostandFurniData()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set category(param1:int) : void
      {
         _category = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function setData(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         id = param1.id;
         category = param1.category;
         name = param1.name;
         description = param1.description;
         image = param1.image;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get description() : String
      {
         return var_1011;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
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
