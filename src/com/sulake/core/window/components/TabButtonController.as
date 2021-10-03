package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class TabButtonController extends SelectableController implements ITabButtonWindow
   {
      
      private static const const_1304:String = "TAB_BUTTON_ICON";
      
      private static const const_1303:String = "TAB_BUTTON_CONTENT";
      
      private static const const_1002:String = "TAB_BUTTON_TITLE";
       
      
      public function TabButtonController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         param5 |= 0;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         expandToAccommodateChildren();
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_226)
         {
            trace(this.rectangle + " " + this.getChildAt(1).rectangle);
            WindowController.resizeToAccommodateChildren(this,true);
            trace(this.rectangle + " " + this.getChildAt(1).rectangle);
         }
         return super.update(param1,param2);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:ITextWindow = ITextWindow(findChildByTag(const_1002));
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
   }
}
