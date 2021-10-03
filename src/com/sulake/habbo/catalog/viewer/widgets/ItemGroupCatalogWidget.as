package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.catalog.viewer.IGridItem;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.events.TimerEvent;
   
   public class ItemGroupCatalogWidget extends ItemGridCatalogWidget implements ICatalogWidget, IItemGrid
   {
       
      
      private var var_839:int = 0;
      
      private var var_838:Array;
      
      private var var_1493:int = 0;
      
      private var var_478:Array;
      
      public function ItemGroupCatalogWidget(param1:IWindowContainer)
      {
         var_838 = new Array();
         var_478 = new Array();
         super(param1);
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         var _loc2_:int = param1.index;
         var _loc3_:Array = var_478[var_839] as Array;
         var _loc4_:Offer = _loc3_[_loc2_] as Offer;
         if(_loc4_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc4_));
         }
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent) : void
      {
         var _loc2_:Offer = var_478[var_839][var_1493];
         this.select(_loc2_.productContainer as IGridItem);
      }
      
      private function createOfferGroups() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         for each(_loc1_ in page.offers)
         {
            if(_loc1_.pricingModel == Offer.const_428 || _loc1_.pricingModel == Offer.const_448)
            {
               _loc3_ = _loc1_.productContainer.firstProduct;
               if(_loc3_ != null)
               {
                  _loc4_ = _loc3_.productClassId;
                  if(_loc3_.productType == ProductTypeEnum.const_127 || _loc3_.productType == ProductTypeEnum.const_154)
                  {
                     if(_loc3_.furnitureData != null)
                     {
                        _loc5_ = _loc3_.furnitureData.name;
                        if(var_838.indexOf(_loc5_) == -1)
                        {
                           var_838.push(_loc5_);
                           var_478.push(new Array());
                        }
                        _loc6_ = var_838.indexOf(_loc5_);
                        (var_478[_loc6_] as Array).push(_loc1_);
                     }
                  }
               }
            }
         }
         for each(_loc2_ in var_478)
         {
            _loc2_.sort(sortByColor);
         }
      }
      
      private function sortByColor(param1:Offer, param2:Offer) : int
      {
         var _loc3_:Number = param1.productContainer.firstProduct.furnitureData.colourIndex;
         var _loc4_:Number = param2.productContainer.firstProduct.furnitureData.colourIndex;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function populateItemGrid(param1:TimerEvent = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(_loc2_ in var_478)
         {
            if(var_1493 < _loc2_.length)
            {
               _loc3_ = _loc2_[var_1493] as Offer;
               createGridItem(_loc3_);
               _loc3_.productContainer.grid = this;
            }
         }
      }
      
      override public function select(param1:IGridItem) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         super.select(param1);
         var_839 = var_823.getGridItemIndex(param1.view);
         var _loc2_:String = "null";
         var _loc3_:Array = var_478[var_839] as Array;
         var _loc4_:Array = new Array();
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = _loc5_.productContainer.firstProduct.furnitureData;
            _loc7_ = _loc6_.colours[_loc6_.colours.length - 1];
            _loc4_.push(_loc7_);
         }
         Logger.log("Show the colors for current selection..." + _loc2_ + " " + _loc4_.length);
         events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_,"ctlg_clr_40x32_1","ctlg_clr_40x32_2","ctlg_clr_40x32_3"));
      }
      
      override public function init() : void
      {
         Logger.log("Init Item Group Catalog Widget (Plasto)");
         createOfferGroups();
         var_120 = false;
         super.init();
         events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED,onWidgetsInitialized);
         events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX,onColourIndex);
      }
   }
}
