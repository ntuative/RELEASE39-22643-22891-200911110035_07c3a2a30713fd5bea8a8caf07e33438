package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class SelectableController extends InteractiveController implements ISelectableWindow
   {
       
      
      public function SelectableController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         setStateFlag(WindowState.const_44,param1);
      }
      
      public function get selector() : ISelectorWindow
      {
         var _loc1_:* = null;
         if(var_23)
         {
            _loc1_ = var_23 as WindowController;
            while(_loc1_)
            {
               if(_loc1_ is ISelectorWindow)
               {
                  return _loc1_ as ISelectorWindow;
               }
               _loc1_ = _loc1_.parent;
            }
         }
         return null;
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         var _loc3_:* = null;
         if(param2.type == WindowNotifyEvent.const_312)
         {
            if(var_23)
            {
               if(!(var_23 is ISelectorWindow))
               {
                  _loc3_ = var_23.parent as WindowController;
                  while(_loc3_)
                  {
                     if(_loc3_ is ISelectorWindow)
                     {
                        _loc3_.update(this,new WindowNotifyEvent(WindowNotifyEvent.const_207,this,null));
                        break;
                     }
                     _loc3_ = _loc3_.parent as WindowController;
                  }
               }
            }
         }
         return super.update(param1,param2);
      }
      
      public function select() : Boolean
      {
         if(getStateFlag(WindowState.const_44))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_369,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_44,true);
         _loc1_.type = WindowNotifyEvent.const_288;
         update(this,_loc1_);
         return true;
      }
      
      public function get isSelected() : Boolean
      {
         return testStateFlag(WindowState.const_44);
      }
      
      public function unselect() : Boolean
      {
         if(!getStateFlag(WindowState.const_44))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_544,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_44,false);
         _loc1_.type = WindowNotifyEvent.const_646;
         update(this,_loc1_);
         return true;
      }
   }
}
