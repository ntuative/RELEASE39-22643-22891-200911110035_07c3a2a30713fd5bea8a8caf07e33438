package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class TabSelectorController extends SelectorController implements ITabSelectorWindow
   {
       
      
      protected var _spacing:int = 0;
      
      private var var_1116:Boolean = false;
      
      public function TabSelectorController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         var_2046 = false;
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         _spacing = param1;
         updateSelectableRegion();
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         if(param2.type == WindowNotifyEvent.const_276)
         {
            updateSelectableRegion();
         }
         else if(param2.type == WindowNotifyEvent.const_226)
         {
            updateSelectableRegion();
         }
         else if(param2.type == WindowNotifyEvent.const_225)
         {
            updateSelectableRegion();
         }
         return super.update(param1,param2);
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(new PropertyStruct("spacing",_spacing,"int",_spacing != 0));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_] as PropertyStruct;
            switch(_loc3_.key)
            {
               case "spacing":
                  spacing = _loc3_.value as int;
                  break;
            }
            _loc4_++;
         }
         super.properties = param1;
      }
      
      private function updateSelectableRegion() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(var_1116)
         {
            return;
         }
         var_1116 = true;
         var _loc1_:uint = numSelectables;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = getSelectableAt(_loc4_);
            _loc2_.x = _loc3_;
            _loc3_ += _loc2_.width + _spacing;
            _loc4_++;
         }
         var_1116 = false;
      }
   }
}
