package com.sulake.habbo.avatar.structure
{
   import flash.geom.Point;
   
   public class AvatarCanvas
   {
       
      
      private var var_849:int;
      
      private var _height:int;
      
      private var _width:int;
      
      private var _offset:Point;
      
      private var _dx:int;
      
      private var var_1128:int;
      
      private var _id:String;
      
      public function AvatarCanvas(param1:XML)
      {
         super();
         _id = String(param1.@id);
         _width = parseInt(param1.@width);
         _height = parseInt(param1.@height);
         var_849 = parseInt(param1.@depth);
         _dx = parseInt(param1.@dx);
         var_1128 = parseInt(param1.@dy);
         _offset = new Point(_dx,var_1128);
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
   }
}
