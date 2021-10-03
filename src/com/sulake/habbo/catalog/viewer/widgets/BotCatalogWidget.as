package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IGridItem;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.widgets.events.RentableBotDefinitionWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.product.IProductData;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BotCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid
   {
       
      
      private var var_514:IGridItem;
      
      protected var var_823:IItemGridWindow;
      
      protected var var_1221:XML;
      
      private var var_1283:Map;
      
      private var var_687:Offer;
      
      public function BotCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
         var_823 = _window.findChildByName("botGrid") as IItemGridWindow;
      }
      
      private function populateGridItems() : void
      {
         var _loc3_:* = null;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("BotgridItem") as XmlAsset;
         var_1221 = _loc1_.content as XML;
         var _loc2_:int = 0;
         while(_loc2_ < page.offers.length)
         {
            _loc3_ = page.offers[_loc2_];
            createGridItem(_loc3_);
            _loc3_.productContainer.grid = this;
            if(_loc2_ == 0)
            {
               select(_loc3_.productContainer as IGridItem);
            }
            _loc2_++;
         }
      }
      
      protected function createGridItem(param1:Offer) : void
      {
         var _loc2_:IWindowContainer = page.viewer.catalog.windowManager.buildFromXML(var_1221) as IWindowContainer;
         var_823.addGridItem(_loc2_);
         param1.productContainer.view = _loc2_;
         var _loc3_:String = var_1283.getValue(param1.productContainer.firstProduct.extraParam.toLowerCase());
         var _loc4_:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createAvatarImage(_loc3_,AvatarScaleType.const_93);
         var _loc5_:IBitmapWrapperWindow = _loc2_.findChildByName("image") as IBitmapWrapperWindow;
         _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
         _loc4_.setDirection(AvatarSetType.const_40,4);
         var _loc6_:BitmapData = _loc4_.getImage(AvatarSetType.const_40);
         _loc5_.bitmap.copyPixels(_loc6_,_loc6_.rect,new Point((_loc5_.width - _loc6_.width) / 2,_loc5_.height - _loc6_.height));
         _loc5_.invalidate();
      }
      
      override public function init() : void
      {
         super.init();
         (page.viewer.catalog as HabboCatalog).getRentableBotDefinitions();
         events.addEventListener(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS,onBotDefinitions);
         var _loc1_:IWindow = window.findChildByName("ctlg_buy_button");
         _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onBuyButtonEvent);
      }
      
      private function updatePreviewImage() : void
      {
         var _loc1_:String = var_1283.getValue(var_687.productContainer.firstProduct.extraParam.toLowerCase());
         var _loc2_:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createAvatarImage(_loc1_,AvatarScaleType.const_66);
         _loc2_.setDirection(AvatarSetType.const_40,4);
         setPreviewImage(_loc2_.getImage(AvatarSetType.const_40));
      }
      
      private function onBuyButtonEvent(param1:WindowEvent) : void
      {
         (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(var_687,page);
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = window.findChildByName("big_bot_image") as IBitmapWrapperWindow;
         if(_loc2_ == null || _loc2_.bitmap == null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,16777215);
         }
         _loc2_.bitmap.copyPixels(param1,param1.rect,new Point((_loc2_.width - param1.width) / 2 - 25,_loc2_.height - param1.height));
         _loc2_.invalidate();
      }
      
      private function onBotDefinitions(param1:RentableBotDefinitionWidgetEvent) : void
      {
         var_1283 = param1.botFigureData;
         populateGridItems();
      }
      
      public function select(param1:IGridItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_514 != null)
         {
            var_514.deActivate();
         }
         var_514 = param1;
         param1.activate();
         var _loc2_:Offer = (param1 as ProductContainer).offer;
         if(_loc2_ != null)
         {
            var_687 = _loc2_;
            updatePreviewImage();
            setProductData();
            events.dispatchEvent(new SelectProductEvent(_loc2_));
         }
      }
      
      private function setProductData() : void
      {
         var _loc1_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         var _loc2_:ITextWindow = _window.findChildByName("ctlg_price") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc1_.registerParameter("catalog.purchase.price.credits+pixels","credits",String(var_687.priceInCredits));
            _loc1_.registerParameter("catalog.purchase.price.credits+pixels","pixels",String(var_687.priceInPixels));
            _loc2_.text = "${catalog.purchase.price.credits+pixels}";
         }
         var _loc3_:IProductData = page.viewer.catalog.getProductData(var_687.localizationId);
         var _loc4_:ITextWindow = _window.findChildByName("ctlg_product_name") as ITextWindow;
         if(_loc4_ != null)
         {
            if(_loc3_ != null)
            {
               _loc4_.text = _loc3_.name;
            }
            else
            {
               _loc4_.text = "";
            }
         }
         _loc4_ = _window.findChildByName("ctlg_description") as ITextWindow;
         if(_loc4_ != null)
         {
            if(_loc3_ != null)
            {
               _loc4_.text = _loc3_.description;
            }
            else
            {
               _loc4_.text = "";
            }
         }
      }
   }
}
