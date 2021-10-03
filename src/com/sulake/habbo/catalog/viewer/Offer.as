package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class Offer
   {
      
      public static const const_947:String = "price_type_none";
      
      public static const const_448:String = "pricing_model_multi";
      
      public static const const_307:String = "price_type_credits";
      
      public static const const_385:String = "price_type_credits_and_pixels";
      
      public static const const_350:String = "pricing_model_bundle";
      
      public static const const_428:String = "pricing_model_single";
      
      public static const const_473:String = "price_type_credits_or_credits_and_pixels";
      
      public static const const_1067:String = "pricing_model_unknown";
      
      public static const const_391:String = "price_type_pixels";
       
      
      private var var_784:int;
      
      private var var_1171:int;
      
      private var var_783:int;
      
      private var var_375:String;
      
      private var var_523:String;
      
      private var var_1915:int;
      
      private var var_658:ICatalogPage;
      
      private var var_1170:String;
      
      private var var_635:IProductContainer;
      
      public function Offer(param1:CatalogPageMessageOfferData, param2:ICatalogPage)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         super();
         var_1171 = param1.offerId;
         var_1170 = param1.localizationId;
         var_784 = param1.priceInCredits;
         var_783 = param1.priceInPixels;
         var_658 = param2;
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1.products)
         {
            _loc5_ = param2.viewer.catalog.getProductData(_loc4_.productType);
            _loc6_ = param2.viewer.catalog.getFurnitureData(_loc4_.furniClassId);
            _loc7_ = new Product(_loc4_,_loc5_,_loc6_);
            _loc3_.push(_loc7_);
         }
         analyzePricingModel(_loc3_);
         analyzePriceType();
         createProductContainer(_loc3_);
      }
      
      public function get pricingModel() : String
      {
         return var_375;
      }
      
      public function get page() : ICatalogPage
      {
         return var_658;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_1915 = param1;
      }
      
      public function get productContainer() : IProductContainer
      {
         return var_635;
      }
      
      public function get localizationId() : String
      {
         return var_1170;
      }
      
      public function get offerId() : int
      {
         return var_1171;
      }
      
      public function get priceInPixels() : int
      {
         return var_783;
      }
      
      public function dispose() : void
      {
         var_1171 = 0;
         var_1170 = "";
         var_784 = 0;
         var_783 = 0;
         var_635.dispose();
      }
      
      public function get priceType() : String
      {
         return var_523;
      }
      
      public function get previewCallbackId() : int
      {
         return var_1915;
      }
      
      public function get priceInCredits() : int
      {
         return var_784;
      }
      
      private function analyzePricingModel(param1:Array) : void
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            _loc2_ = param1[0];
            if(_loc2_.productCount == 1)
            {
               var_375 = const_428;
            }
            else
            {
               var_375 = const_448;
            }
         }
         else if(param1.length > 1)
         {
            var_375 = const_350;
         }
         else
         {
            var_375 = const_1067;
         }
      }
      
      private function createProductContainer(param1:Array) : void
      {
         switch(var_375)
         {
            case const_428:
               var_635 = new SingleProductContainer(this,param1);
               break;
            case const_448:
               var_635 = new MultiProductContainer(this,param1);
               break;
            case const_350:
               var_635 = new BundleProductContainer(this,param1);
               break;
            default:
               Logger.log("[Offer] Unknown pricing model" + var_375);
         }
      }
      
      private function analyzePriceType() : void
      {
         if(var_784 > 0 && var_783 > 0)
         {
            var_523 = const_385;
         }
         else if(var_784 > 0)
         {
            var_523 = const_307;
         }
         else if(var_783 > 0)
         {
            var_523 = const_391;
         }
         else
         {
            var_523 = const_947;
         }
      }
   }
}
