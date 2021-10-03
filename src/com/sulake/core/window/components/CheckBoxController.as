package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class CheckBoxController extends SelectableController implements ICheckBoxWindow
   {
       
      
      public function CheckBoxController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param1 == this)
         {
            switch(param2.type)
            {
               case MouseEvent.MOUSE_DOWN:
                  break;
               case MouseEvent.MOUSE_UP:
                  if(isSelected)
                  {
                     unselect();
                  }
                  else
                  {
                     select();
                  }
            }
         }
         return super.update(param1,param2);
      }
   }
}
