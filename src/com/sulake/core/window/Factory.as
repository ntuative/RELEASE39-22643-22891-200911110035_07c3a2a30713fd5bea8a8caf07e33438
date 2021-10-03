package com.sulake.core.window
{
   import com.sulake.core.window.components.ActivatorController;
   import com.sulake.core.window.components.BackgroundController;
   import com.sulake.core.window.components.BitmapWrapperController;
   import com.sulake.core.window.components.BorderController;
   import com.sulake.core.window.components.ButtonController;
   import com.sulake.core.window.components.CanvasController;
   import com.sulake.core.window.components.CheckBoxController;
   import com.sulake.core.window.components.ContainerButtonController;
   import com.sulake.core.window.components.ContainerController;
   import com.sulake.core.window.components.DisplayObjectWrapperController;
   import com.sulake.core.window.components.DropMenuController;
   import com.sulake.core.window.components.DropMenuItemController;
   import com.sulake.core.window.components.FrameController;
   import com.sulake.core.window.components.HeaderController;
   import com.sulake.core.window.components.IconController;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.ItemGridController;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.components.PasswordFieldController;
   import com.sulake.core.window.components.RadioButtonController;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.components.ScalerController;
   import com.sulake.core.window.components.ScrollableItemListWindow;
   import com.sulake.core.window.components.ScrollbarController;
   import com.sulake.core.window.components.ScrollbarLiftController;
   import com.sulake.core.window.components.SelectableButtonController;
   import com.sulake.core.window.components.SelectorController;
   import com.sulake.core.window.components.TabButtonController;
   import com.sulake.core.window.components.TabContainerButtonController;
   import com.sulake.core.window.components.TabContextController;
   import com.sulake.core.window.components.TabSelectorController;
   import com.sulake.core.window.components.TextController;
   import com.sulake.core.window.components.TextFieldController;
   import com.sulake.core.window.components.ToolTipController;
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class Factory
   {
       
      
      protected var var_26:Dictionary;
      
      public function Factory()
      {
         super();
         var_26 = new Dictionary();
         var_26["null"] = WindowController;
         var_26["null"] = ActivatorController;
         var_26["null"] = BackgroundController;
         var_26["null"] = BorderController;
         var_26["null"] = ButtonController;
         var_26["null"] = ButtonController;
         var_26["null"] = SelectableButtonController;
         var_26["null"] = SelectableButtonController;
         var_26["null"] = SelectableButtonController;
         var_26["null"] = BitmapWrapperController;
         var_26["null"] = CanvasController;
         var_26["null"] = CheckBoxController;
         var_26["null"] = ContainerController;
         var_26["null"] = ContainerButtonController;
         var_26["null"] = InteractiveController;
         var_26["null"] = DisplayObjectWrapperController;
         var_26["null"] = ScrollbarLiftController;
         var_26["null"] = DropMenuController;
         var_26["null"] = DropMenuItemController;
         var_26["null"] = FrameController;
         var_26["null"] = HeaderController;
         var_26["null"] = IconController;
         var_26["null"] = ItemListController;
         var_26["null"] = ItemListController;
         var_26["null"] = ItemListController;
         var_26["null"] = ItemGridController;
         var_26["null"] = ItemGridController;
         var_26["null"] = ItemGridController;
         var_26["null"] = PasswordFieldController;
         var_26["null"] = RadioButtonController;
         var_26["null"] = RegionController;
         var_26["null"] = ScalerController;
         var_26["null"] = ScrollbarController;
         var_26["null"] = ScrollbarController;
         var_26["null"] = ButtonController;
         var_26["null"] = ButtonController;
         var_26["null"] = ButtonController;
         var_26["null"] = ButtonController;
         var_26["null"] = ScrollbarLiftController;
         var_26["null"] = ScrollbarLiftController;
         var_26["null"] = WindowController;
         var_26["null"] = WindowController;
         var_26["null"] = ScrollableItemListWindow;
         var_26["null"] = SelectorController;
         var_26["null"] = TabSelectorController;
         var_26["null"] = TabButtonController;
         var_26["null"] = TabContainerButtonController;
         var_26["null"] = ContainerController;
         var_26["null"] = TabContextController;
         var_26["null"] = TabSelectorController;
         var_26["null"] = TextController;
         var_26["null"] = TextFieldController;
         var_26["null"] = ToolTipController;
      }
      
      public function getWindowClassByType(param1:uint) : Class
      {
         return var_26[param1];
      }
   }
}
