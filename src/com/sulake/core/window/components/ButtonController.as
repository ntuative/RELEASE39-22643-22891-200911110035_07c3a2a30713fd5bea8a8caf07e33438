package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class ButtonController extends InteractiveController implements IButtonWindow
   {
      
      protected static const const_1280:String = "_BTN_TEXT";
       
      
      public function ButtonController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         param5 |= 0;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         expandToAccommodateChildren();
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_226)
         {
            width = 0;
         }
         return super.update(param1,param2);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:ITextWindow = ITextWindow(getChildByName(const_1280));
         if(_loc2_ != null)
         {
            _loc2_.text = caption;
         }
      }
   }
}
