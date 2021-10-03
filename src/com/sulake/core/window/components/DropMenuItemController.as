package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import flash.geom.Rectangle;
   
   public class DropMenuItemController extends ButtonController implements IDropMenuItemWindow
   {
       
      
      public function DropMenuItemController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function get menu() : IDropMenuWindow
      {
         var _loc1_:IWindow = parent;
         while(_loc1_)
         {
            if(_loc1_ is IDropMenuWindow)
            {
               break;
            }
            _loc1_ = _loc1_.parent;
         }
         return _loc1_ as IDropMenuWindow;
      }
   }
}
