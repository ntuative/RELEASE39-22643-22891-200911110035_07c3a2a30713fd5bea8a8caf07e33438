package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITabSelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class AvatarEditorView
   {
      
      public static var var_1436:IWindowContainer;
      
      public static var var_1215:IWindowContainer;
      
      public static var var_970:int = 6710886;
       
      
      private var var_1265:Boolean = true;
      
      private var var_172:Timer;
      
      private var var_1264:ITabSelectorWindow;
      
      private var _window:IWindowContainer;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_958:String;
      
      private var _controller:HabboAvatarEditor;
      
      private var var_1528:Number = 0;
      
      public function AvatarEditorView(param1:HabboAvatarEditor, param2:IHabboWindowManager)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super();
         _controller = param1;
         _windowManager = param2;
         createWindow();
         if(var_1215 == null)
         {
            _loc3_ = _controller.assets.getAssetByName("AvatarEditorThumb") as XmlAsset;
            var_1215 = _controller.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         }
         if(var_1436 == null)
         {
            _loc4_ = _controller.assets.getAssetByName("color_chooser_cell") as XmlAsset;
            var_1436 = _controller.windowManager.buildFromXML(_loc4_.content as XML) as IWindowContainer;
         }
         var_172 = new Timer(1000);
         var_172.addEventListener(TimerEvent.TIMER,onUpdate);
      }
      
      public function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type == WindowEvent.const_51)
         {
            _loc3_ = param2.name;
            Logger.log("Select tab: " + _loc3_);
            if(_loc3_ != var_958)
            {
               _controller.toggleAvatarEditorPage(_loc3_);
            }
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "save":
                  if(false)
                  {
                     _controller.handler.saveCurrentSelection();
                  }
                  var_1528 = new Date().valueOf();
                  var_1265 = false;
                  var_172.start();
                  _window.findChildByName("save").disable();
                  _controller.close();
                  break;
               case "cancel":
                  _controller.close();
            }
            if(param2.name == "header_button_close")
            {
               hide();
            }
         }
      }
      
      private function loadSubCategoryContent(param1:String) : void
      {
         Logger.log("Load sub-category: " + param1);
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      private function canChangeOutfit() : Boolean
      {
         var _loc1_:Number = new Date().valueOf();
         return _loc1_ - var_1528 > 5000;
      }
      
      public function updateAvatar() : void
      {
         var _loc1_:IWindowContainer = _controller.figureData.view.window;
         var _loc2_:IWindowContainer = _window.findChildByName("figureContainer") as IWindowContainer;
         if(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
         if(_loc2_ != null)
         {
            _loc2_.addChild(_loc1_);
         }
         if(var_958 != null)
         {
            toggleCategoryView(var_958,true);
         }
      }
      
      private function createWindow() : void
      {
         if(_window == null)
         {
            _window = _windowManager.buildFromXML((_controller.assets.getAssetByName("AvatarEditor") as XmlAsset).content as XML) as IWindowContainer;
         }
         _window.procedure = windowEventProc;
         var_1264 = _window.findChildByName("mainTabs") as ITabSelectorWindow;
         attachImages();
         updateAvatar();
      }
      
      public function toggle() : void
      {
         _window.visible = true;
         if(false)
         {
            var_172.start();
         }
         else
         {
            var_172.stop();
         }
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         if(canChangeOutfit())
         {
            var_1265 = canChangeOutfit();
            var_172.stop();
            _window.findChildByName("save").enable();
         }
      }
      
      private function onSelectCategory(param1:WindowEvent, param2:IWindow = null) : void
      {
         Logger.log("Select category: " + param1.target);
      }
      
      private function attachImages() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:* = ["generic","head","torso","legs","wardrobe"];
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = (_window as IWindowContainer).findChildByName(_loc2_) as IWindowContainer;
            _loc4_ = _loc3_.findChildByTag("BITMAP") as IBitmapWrapperWindow;
            if(_loc4_ != null)
            {
               _loc5_ = _controller.assets.getAssetByName("ae_tabs_" + _loc2_) as BitmapDataAsset;
               _loc6_ = (_loc5_.content as BitmapData).clone();
               _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,16777215);
               _loc7_ = (_loc4_.width - _loc6_.width) / 2;
               _loc8_ = (_loc4_.height - _loc6_.height) / 2;
               _loc4_.bitmap.copyPixels(_loc6_,_loc6_.rect,new Point(_loc7_,_loc8_));
            }
         }
      }
      
      public function dispose() : void
      {
         if(var_172 != null)
         {
            var_172.stop();
            var_172.removeEventListener(TimerEvent.TIMER,onUpdate);
            var_172 = null;
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         var _loc2_:IWindowContainer = _window.findChildByName("contentArea") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = _loc2_.getChildAt(0) as IWindowContainer;
         _loc2_.removeChild(_loc3_);
         _loc2_.invalidate();
         var _loc4_:IWindowContainer = _controller.getCategoryWindowContainer(param1);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.visible = true;
         _loc2_.addChild(_loc4_);
         var_958 = param1;
         var_1264.setSelected(var_1264.getSelectableByName(param1));
         _window.invalidate();
      }
      
      private function onSelectSubCategory(param1:WindowEvent, param2:IWindow = null) : void
      {
         Logger.log("Select sub-category: " + param1.target);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = false) : void
      {
         if(!param2)
         {
         }
         setViewToCategory(param1);
      }
      
      public function show() : void
      {
         _window.visible = true;
      }
   }
}
