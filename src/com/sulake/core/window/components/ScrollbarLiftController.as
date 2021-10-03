package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class ScrollbarLiftController extends InteractiveController implements IDragBarWindow
   {
       
      
      protected var var_681:Number;
      
      protected var _offsetX:Number;
      
      protected var _scrollBar:ScrollbarController;
      
      public function ScrollbarLiftController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         _offsetX = 0;
         var_681 = 0;
         param5 |= 0;
         param5 |= 0;
         param5 |= 0;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         var _loc13_:* = param8;
         while(_loc13_ != null)
         {
            if(_loc13_ is IScrollbarWindow)
            {
               _scrollBar = ScrollbarController(_loc13_);
               _loc13_ = null;
            }
            else
            {
               _loc13_ = _loc13_.parent;
            }
         }
         if(false)
         {
            setMinWidth(width);
         }
         else
         {
            setMinHeight(height);
         }
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_354)
         {
            _offsetX = x != 0 ? Number(x / Number(0 - width)) : Number(0);
            var_681 = y != 0 ? Number(y / Number(0 - height)) : Number(0);
            if(var_23 != _scrollBar)
            {
               _scrollBar.update(this,new WindowNotifyEvent(WindowNotifyEvent.const_225,this,null));
            }
         }
         return super.update(param1,param2);
      }
      
      public function set offsetX(param1:Number) : void
      {
      }
      
      public function set offsetY(param1:Number) : void
      {
      }
      
      public function get offsetY() : Number
      {
         return var_681;
      }
      
      public function get offsetX() : Number
      {
         return _offsetX;
      }
   }
}
