package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import flash.geom.Rectangle;
   
   public class HeaderController extends ContainerController implements IHeaderWindow
   {
      
      private static const const_1032:String = "_TITLE";
      
      private static const const_1031:String = "_CONTROLS";
       
      
      public function HeaderController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      override public function set caption(param1:String) : void
      {
         var value:String = param1;
         super.caption = value;
         try
         {
            title.text = value;
         }
         catch(e:Error)
         {
            Logger.log("Header contains no title element!");
         }
      }
      
      override public function set color(param1:uint) : void
      {
         var _loc3_:* = null;
         super.color = param1;
         var _loc2_:Array = new Array();
         groupChildrenWithTag("_COLORIZE",_loc2_,true);
         for each(_loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
      
      public function get title() : ITextWindow
      {
         return findChildByTag(HeaderController.const_1032) as ITextWindow;
      }
      
      public function get controls() : IItemListWindow
      {
         return findChildByTag(HeaderController.const_1031) as IItemListWindow;
      }
   }
}
