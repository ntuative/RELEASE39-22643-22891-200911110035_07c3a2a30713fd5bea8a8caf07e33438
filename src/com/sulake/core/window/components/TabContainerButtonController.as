package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.Iterator;
   import flash.geom.Rectangle;
   
   public class TabContainerButtonController extends SelectableController implements ITabButtonWindow, IWindowContainer
   {
       
      
      public function TabContainerButtonController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function get iterator() : IIterator
      {
         return new Iterator(this);
      }
   }
}
