package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   
   public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
       
      
      private var var_1890:XML;
      
      private var var_1392:ITextWindow;
      
      private var var_1391:ITextWindow;
      
      private var var_1889:XML;
      
      private var var_775:IWindowContainer;
      
      private var var_2084:ITextWindow;
      
      private var var_1891:String = "";
      
      private var var_2147:IButtonWindow;
      
      private var var_1893:XML;
      
      private var var_1393:ITextWindow;
      
      private var var_1892:XML;
      
      private var var_774:IButtonWindow;
      
      private var var_173:Offer;
      
      public function PurchaseCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      private function attachStub(param1:String) : void
      {
         var _loc2_:* = null;
         switch(param1)
         {
            case Offer.const_307:
               _loc2_ = page.viewer.catalog.windowManager.buildFromXML(var_1889) as IWindowContainer;
               break;
            case Offer.const_391:
               _loc2_ = page.viewer.catalog.windowManager.buildFromXML(var_1892) as IWindowContainer;
               break;
            case Offer.const_385:
               _loc2_ = page.viewer.catalog.windowManager.buildFromXML(var_1890) as IWindowContainer;
               break;
            case Offer.const_473:
               _loc2_ = page.viewer.catalog.windowManager.buildFromXML(var_1893) as IWindowContainer;
               break;
            default:
               Logger.log("Unknown price-type, can\'t attach...undefined");
         }
         if(_loc2_ != null)
         {
            if(var_775 != null)
            {
               _window.removeChild(var_775);
               var_775.dispose();
            }
            var_775 = _loc2_;
            _window.addChild(_loc2_);
            var_775.x = 0;
            var_775.y = 0;
         }
         var_1393 = _window.findChildByName("ctlg_price_credits") as ITextWindow;
         var_1391 = _window.findChildByName("ctlg_price_pixels") as ITextWindow;
         var_1392 = _window.findChildByName("ctlg_price_credits_pixels") as ITextWindow;
         var_2084 = _window.findChildByName("ctlg_special_txt") as ITextWindow;
         var_774 = window.findChildByName("ctlg_buy_button") as IButtonWindow;
         if(var_774 != null)
         {
            var_774.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onPurchase);
            var_774.disable();
         }
      }
      
      private function onPurchase(param1:WindowMouseEvent) : void
      {
         if(var_173 != null)
         {
            Logger.log("Init Purchase: undefined undefined");
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(var_173,page,var_1891);
         }
      }
      
      override public function init() : void
      {
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsStub") as XmlAsset;
         if(_loc1_ != null)
         {
            var_1889 = _loc1_.content as XML;
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetPixelsStub") as XmlAsset;
         if(_loc2_ != null)
         {
            var_1892 = _loc2_.content as XML;
         }
         var _loc3_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsPixelsStub") as XmlAsset;
         if(_loc3_ != null)
         {
            var_1890 = _loc3_.content as XML;
         }
         var _loc4_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsOrCreditsAndPixelsStub") as XmlAsset;
         if(_loc4_ != null)
         {
            var_1893 = _loc4_.content as XML;
         }
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,onSelectProduct);
         events.addEventListener(WidgetEvent.const_765,onSetParameter);
      }
      
      private function onSetParameter(param1:SetExtraPurchaseParameterEvent) : void
      {
         var_1891 = param1.parameter;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         var_173 = param1.offer;
         attachStub(var_173.priceType);
         if(var_1393 != null)
         {
            _loc2_.registerParameter("catalog.purchase.price.credits","credits",String(var_173.priceInCredits));
            var_1393.caption = "${catalog.purchase.price.credits}";
         }
         if(var_1391 != null)
         {
            _loc2_.registerParameter("catalog.purchase.price.pixels","pixels",String(var_173.priceInPixels));
            var_1391.caption = "${catalog.purchase.price.pixels}";
         }
         if(var_1392 != null)
         {
            _loc2_.registerParameter("catalog.purchase.price.credits+pixels","credits",String(var_173.priceInCredits));
            _loc2_.registerParameter("catalog.purchase.price.credits+pixels","pixels",String(var_173.priceInPixels));
            var_1392.caption = "${catalog.purchase.price.credits+pixels}";
         }
         if(var_774 != null)
         {
            var_774.enable();
         }
      }
   }
}
