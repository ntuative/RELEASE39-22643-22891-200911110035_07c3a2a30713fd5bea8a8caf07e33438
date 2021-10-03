package com.sulake.habbo.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ICheckBoxWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DimmerView
   {
      
      private static const const_972:Number = 100;
      
      private static const const_971:Number = 100;
       
      
      private var var_1088:XML;
      
      private var var_613:int;
      
      private var var_423:DimmerViewColorGrid;
      
      private var _window:IWindowContainer;
      
      private var var_1733:int;
      
      private var var_319:DimmerViewAlphaSlider;
      
      private var _widget:DimmerFurniWidget;
      
      private var var_898:int;
      
      private var var_214:ITabContextWindow;
      
      public function DimmerView(param1:DimmerFurniWidget)
      {
         super();
         _widget = param1;
      }
      
      private function onTabClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_51)
         {
            return;
         }
         _widget.storeCurrentSetting(false);
         var _loc3_:int = param2.id;
         selectPreset(_loc3_);
      }
      
      private function get windowXML() : XML
      {
         if(var_1088 != null)
         {
            return var_1088;
         }
         if(_widget == null || true || _widget.assets.getAssetByName("dimmer_ui") == null)
         {
            return null;
         }
         var _loc1_:XmlAsset = XmlAsset(_widget.assets.getAssetByName("dimmer_ui"));
         var_1088 = XML(_loc1_.content);
         return var_1088;
      }
      
      public function get selectedBrightness() : int
      {
         return var_898;
      }
      
      private function selectTab(param1:int) : void
      {
         if(var_214 == null)
         {
            return;
         }
         var _loc2_:IWindow = var_214.getTabItemAt(param1);
         if(_loc2_ != null)
         {
            var_214.selector.setSelected(_loc2_ as ISelectableWindow);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(_widget == null || true || windowXML == null)
         {
            return;
         }
         _window = _widget.windowManager.createWindow("dimmerui_container","",HabboWindowType.const_53,HabboWindowStyle.const_37,0 | 0,new Rectangle(const_972,const_971,2,2),null,0) as IWindowContainer;
         _window.buildFromXML(windowXML);
         _loc1_ = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.procedure = onWindowClose;
         }
         _loc1_ = _window.findChildByName("color_grid_container");
         if(_loc1_ != null)
         {
            _loc5_ = (_loc1_ as IWindowContainer).findChildByName("color_grid");
            if(_loc5_ != null)
            {
               var_423 = new DimmerViewColorGrid(this,_loc5_ as IItemGridWindow,_widget.windowManager,_widget.assets);
            }
         }
         _loc1_ = _window.findChildByName("brightness_container");
         if(_loc1_ != null)
         {
            var_319 = new DimmerViewAlphaSlider(this,_loc1_ as IWindowContainer,_widget.assets);
         }
         var_214 = ITabContextWindow(_window.findChildByName("tab_context"));
         selectTab(_widget.selectedPresetIndex);
         var _loc2_:int = 0;
         while(_loc2_ < var_214.numTabItems)
         {
            _loc6_ = var_214.getTabItemAt(_loc2_);
            _loc6_.setParamFlag(HabboWindowParam.const_34,true);
            _loc6_.procedure = onTabClick;
            _loc2_++;
         }
         _loc1_ = _window.findChildByName("type_checkbox");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseEvent);
         }
         _loc1_ = _window.findChildByName("apply_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseEvent);
         }
         _loc1_ = _window.findChildByName("on_off_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseEvent);
         }
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("off_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapDataAsset = _widget.assets.getAssetByName("dimmer_info") as BitmapDataAsset;
         if(_loc3_ != null && _loc4_ != null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height);
            _loc7_ = _loc4_.content as BitmapData;
            if(_loc7_ != null)
            {
               _loc3_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            }
         }
      }
      
      public function hideInterface() : void
      {
         if(_widget != null)
         {
            _widget.removePreview();
         }
         if(var_423 != null)
         {
            var_423.dispose();
            var_423 = null;
         }
         if(var_319 != null)
         {
            var_319.dispose();
            var_319 = null;
         }
         var_214 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function update() : void
      {
         var _loc3_:* = null;
         if(_window == null || _widget == null)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:IWindow = _window.findChildByName("on_off_button");
         if(_loc2_ != null)
         {
            _loc3_ = !!_loc1_ ? "${widget.dimmer.button.off}" : "${widget.dimmer.button.on}";
            _loc2_.caption = _loc3_;
         }
         _loc2_ = _window.findChildByName("tabbedview");
         if(_loc2_ != null)
         {
            _loc2_.visible = _loc1_;
         }
         _loc2_ = _window.findChildByName("apply_button");
         if(_loc2_ != null)
         {
            if(_loc1_)
            {
               _loc2_.enable();
            }
            else
            {
               _loc2_.disable();
            }
         }
      }
      
      public function dispose() : void
      {
         hideInterface();
         _widget = null;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         hideInterface();
      }
      
      public function set selectedBrightness(param1:int) : void
      {
         var_898 = param1;
         if(var_319 != null)
         {
            var_319.setValue(param1);
         }
         _widget.previewCurrentSetting();
      }
      
      public function get selectedColorIndex() : int
      {
         return var_613;
      }
      
      public function set selectedColorIndex(param1:int) : void
      {
         var_613 = param1;
         if(var_423 != null)
         {
            var_423.setSelectedColorIndex(param1);
         }
         _widget.previewCurrentSetting();
      }
      
      private function getSelectedTabIndex() : int
      {
         if(var_214 == null)
         {
            return -1;
         }
         var _loc1_:ISelectableWindow = var_214.selector.getSelected();
         return var_214.selector.getSelectableIndex(_loc1_);
      }
      
      public function get colors() : Array
      {
         if(_widget == null)
         {
            return null;
         }
         return _widget.colors;
      }
      
      public function set selectedType(param1:int) : void
      {
         if(param1 != 1 && param1 != 2)
         {
            return;
         }
         var_1733 = param1;
         var _loc2_:ICheckBoxWindow = _window.findChildByName("type_checkbox") as ICheckBoxWindow;
         if(_loc2_ != null)
         {
            if(param1 == 2)
            {
               _loc2_.select();
            }
            else
            {
               _loc2_.unselect();
            }
         }
         if(var_319 != null)
         {
            var_319.min = _widget.minLights[param1 - 1];
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "type_checkbox":
               _loc4_ = param1.target as ICheckBoxWindow;
               if(_loc4_ == null)
               {
                  return;
               }
               if(_loc4_.isSelected)
               {
                  selectedType = 2;
               }
               else
               {
                  selectedType = 1;
               }
               _widget.previewCurrentSetting();
               break;
            case "apply_button":
               _widget.storeCurrentSetting(true);
               break;
            case "cancel":
            case "close":
               hideInterface();
               break;
            case "on_off_button":
               _widget.changeRoomDimmerState();
         }
      }
      
      public function get selectedType() : int
      {
         return var_1733;
      }
      
      private function selectPreset(param1:int) : void
      {
         if(_widget == null || true || param1 < 0 || param1 >= _widget.presets.length)
         {
            return;
         }
         _widget.selectedPresetIndex = param1;
         var _loc2_:DimmerFurniWidgetPresetItem = _widget.presets[param1];
         if(_loc2_ == null)
         {
            return;
         }
         selectTab(param1);
         var_898 = _loc2_.light;
         if(var_319 != null)
         {
            var_319.setValue(var_898);
         }
         var_613 = colors.indexOf(_loc2_.color);
         if(var_423 != null)
         {
            var_423.setSelectedColorIndex(var_613);
         }
         selectedType = _loc2_.type;
         _widget.previewCurrentSetting();
      }
      
      public function showInterface() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         selectPreset(_widget.selectedPresetIndex);
         update();
      }
   }
}
