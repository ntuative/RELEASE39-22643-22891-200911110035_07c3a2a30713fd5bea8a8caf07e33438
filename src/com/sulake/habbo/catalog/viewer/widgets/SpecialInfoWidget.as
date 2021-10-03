package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   
   public class SpecialInfoWidget extends CatalogWidget implements ICatalogWidget
   {
       
      
      public function SpecialInfoWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,onPreviewProduct);
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         _window.visible = false;
      }
   }
}
