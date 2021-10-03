package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.utils.Map;
   import flash.geom.Rectangle;
   
   public class SkinTemplateEntity implements ISkinTemplateEntity
   {
       
      
      protected var var_836:Rectangle;
      
      protected var var_1441:Map;
      
      protected var _type:String;
      
      protected var _name:String;
      
      protected var var_546:Array;
      
      protected var _id:uint;
      
      public function SkinTemplateEntity(param1:String, param2:String, param3:uint, param4:Rectangle, param5:Map)
      {
         super();
         _id = param3;
         _name = param1;
         _type = param2;
         var_836 = param4;
         var_1441 = param5 == null ? new Map() : param5;
         var_546 = new Array();
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function getProperty(param1:String) : Object
      {
         return var_1441[param1];
      }
      
      public function get region() : Rectangle
      {
         return var_836;
      }
      
      public function setProperty(param1:String, param2:Object) : void
      {
         var_1441[param1] = param2;
      }
      
      public function get tags() : Array
      {
         return var_546;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
