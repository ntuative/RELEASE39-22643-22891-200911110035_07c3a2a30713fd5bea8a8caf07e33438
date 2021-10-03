package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Rectangle;
   
   public class TagListRenderer
   {
       
      
      private var _widget:InfostandWidget;
      
      private var _offsetX:int;
      
      private const const_1484:int = 5;
      
      private const const_1485:int = 5;
      
      private var var_1001:Array;
      
      private var var_836:Rectangle = null;
      
      private var var_2060:int = 0;
      
      private var var_117:Function;
      
      private var var_681:int;
      
      public function TagListRenderer(param1:InfostandWidget, param2:Function)
      {
         super();
         _widget = param1;
         var_117 = param2;
      }
      
      private function createTag(param1:String) : ITextWindow
      {
         var _loc2_:* = null;
         if(var_1001 != null && var_1001.indexOf(param1) != -1)
         {
            _loc2_ = _widget.assets.getAssetByName("user_tag_highlighted") as XmlAsset;
         }
         else
         {
            _loc2_ = _widget.assets.getAssetByName("user_tag") as XmlAsset;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:ITextWindow = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as ITextWindow;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,var_117);
         _loc3_.caption = param1;
         return _loc3_;
      }
      
      public function renderTags(param1:Array, param2:IWindowContainer, param3:Array) : int
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var_1001 = param3;
         if(var_1001 != null)
         {
            _loc8_ = [];
            while((_loc9_ = param1.pop()) != null)
            {
               if(param3.indexOf(_loc9_) != -1)
               {
                  _loc8_.unshift(_loc9_);
               }
               else
               {
                  _loc8_.push(_loc9_);
               }
            }
            param1 = _loc8_;
         }
         while(param2.removeChildAt(0) != null)
         {
         }
         var_2060 = 0;
         _offsetX = 0;
         var_681 = 0;
         var_836 = param2.rectangle.clone();
         var_836.height = 150;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = createTag(param1[_loc5_] as String);
            if(fit(_loc4_.rectangle))
            {
               param2.addChild(_loc4_);
            }
            else
            {
               _loc4_.dispose();
            }
            _loc5_++;
         }
         var _loc6_:int = param2.numChildren;
         if(_loc6_ == 0)
         {
            return 0;
         }
         var _loc7_:IWindow = param2.getChildAt(param2.numChildren - 1);
         return _loc7_.rectangle.bottom;
      }
      
      private function fit(param1:Rectangle) : Boolean
      {
         if(param1.width > var_836.width)
         {
            return false;
         }
         if(var_681 + param1.height > var_836.height)
         {
            return false;
         }
         if(_offsetX + param1.width > var_836.width)
         {
            _offsetX = 0;
            var_681 += param1.height + const_1485;
            return fit(param1);
         }
         param1.offset(_offsetX,var_681);
         _offsetX += param1.width + const_1484;
         return true;
      }
      
      public function dispose() : void
      {
         _widget = null;
         var_117 = null;
      }
   }
}
