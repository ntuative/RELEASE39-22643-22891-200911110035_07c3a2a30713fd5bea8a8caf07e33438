package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.utils.IChildEntity;
   import flash.geom.Rectangle;
   
   public interface ISkinTemplateEntity extends IChildEntity
   {
       
      
      function get type() : String;
      
      function getProperty(param1:String) : Object;
      
      function get region() : Rectangle;
      
      function setProperty(param1:String, param2:Object) : void;
   }
}
