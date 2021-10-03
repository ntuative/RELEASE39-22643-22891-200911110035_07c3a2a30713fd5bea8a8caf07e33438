package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.Iterator;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class SelectorController extends InteractiveController implements ISelectorWindow, IIterable
   {
       
      
      protected var var_2046:Boolean = true;
      
      private var _selected:ISelectableWindow;
      
      public function SelectorController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function getSelectableAt(param1:int) : ISelectableWindow
      {
         return getChildAt(param1) as ISelectableWindow;
      }
      
      public function getSelectableIndex(param1:ISelectableWindow) : int
      {
         return getChildIndex(param1);
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_207)
         {
            if(param1 is ISelectableWindow)
            {
               setSelected(param1 as ISelectableWindow);
            }
         }
         return super.update(param1,param2);
      }
      
      public function removeSelectable(param1:ISelectableWindow) : ISelectableWindow
      {
         var _loc2_:int = getChildIndex(param1);
         if(_loc2_ > -1)
         {
            if(param1 == _selected)
            {
               if(numSelectables > 1)
               {
                  setSelected(getSelectableAt(_loc2_ == 0 ? 1 : 0));
               }
               else
               {
                  _selected = null;
               }
            }
            return ISelectableWindow(removeChild(param1));
         }
         return null;
      }
      
      public function addSelectable(param1:ISelectableWindow) : ISelectableWindow
      {
         return ISelectableWindow(addChild(param1));
      }
      
      public function getSelected() : ISelectableWindow
      {
         return _selected as ISelectableWindow;
      }
      
      public function getSelectableByID(param1:uint) : ISelectableWindow
      {
         return getChildByID(param1) as ISelectableWindow;
      }
      
      public function setSelected(param1:ISelectableWindow) : void
      {
         if(param1 != null)
         {
            if(param1 != _selected)
            {
               if(_selected != null)
               {
                  _selected.unselect();
               }
               _selected = param1;
               _selected.select();
               if(getChildIndex(param1) > -1)
               {
                  if(var_2046)
                  {
                     if(getChildIndex(param1) != numChildren - 1)
                     {
                        setChildIndex(param1,numChildren - 1);
                     }
                  }
                  notifyEventListeners(new WindowNotifyEvent(WindowNotifyEvent.const_288,this,_selected));
               }
            }
         }
      }
      
      public function addSelectableAt(param1:ISelectableWindow, param2:int) : ISelectableWindow
      {
         return ISelectableWindow(addChildAt(param1,param2));
      }
      
      public function get iterator() : IIterator
      {
         return new Iterator(this);
      }
      
      public function getSelectableByTag(param1:String) : ISelectableWindow
      {
         return getChildByTag(param1) as ISelectableWindow;
      }
      
      public function getSelectableByName(param1:String) : ISelectableWindow
      {
         return getChildByName(param1) as ISelectableWindow;
      }
      
      public function get numSelectables() : uint
      {
         return numChildren;
      }
   }
}
