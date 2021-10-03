package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class ProductViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener
   {
       
      
      private var var_1413:Point;
      
      private var var_1949:Array;
      
      private var var_526:IItemGridWindow;
      
      private var var_91:IBitmapWrapperWindow;
      
      private var var_1058:ITextWindow;
      
      private var var_1179:IScrollbarWindow;
      
      protected var var_1221:XML;
      
      private var var_1180:BitmapData;
      
      private var var_1059:ITextWindow;
      
      public function ProductViewCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            retrievePreviewAsset(param1);
            return;
         }
         setPreviewImage(_loc2_.content as BitmapData);
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         if(param1 == null)
         {
            return;
         }
         removeEffectSprites();
         _loc2_ = param1.offer;
         if(var_526 != null)
         {
            var_526.visible = false;
            var_526.destroyGridItems();
         }
         if(var_1179 != null)
         {
            var_1179.visible = false;
         }
         var _loc3_:IProductData = page.viewer.catalog.getProductData(_loc2_.localizationId);
         if(_loc3_ != null)
         {
            var_1058.text = "${" + _loc3_.name + "}";
            var_1059.text = "${" + _loc3_.description + "}";
         }
         else
         {
            var_1058.text = "${" + _loc2_.localizationId + "}";
            var_1059.text = "${" + _loc2_.localizationId + "}";
         }
         if(ProductImageConfiguration.hasProductImage(_loc2_.localizationId))
         {
            setPreviewFromAsset(ProductImageConfiguration.const_36[_loc2_.localizationId]);
         }
         else
         {
            _loc5_ = new Point(0,0);
            switch(_loc2_.pricingModel)
            {
               case Offer.const_350:
                  _loc4_ = var_1180.clone();
                  if(var_526 != null)
                  {
                     var_526.visible = true;
                     (_loc2_.productContainer as BundleProductContainer).populateItemGrid(var_526,var_1179,var_1221);
                  }
                  break;
               case Offer.const_428:
               case Offer.const_448:
                  _loc6_ = _loc2_.productContainer.firstProduct;
                  switch(_loc6_.productType)
                  {
                     case ProductTypeEnum.const_154:
                        _loc7_ = page.viewer.roomEngine.getFurnitureImage(_loc6_.productClassId,new Vector3d(90,0,0),64,this);
                        _loc2_.previewCallbackId = _loc7_.id;
                        break;
                     case ProductTypeEnum.const_127:
                        _loc7_ = page.viewer.roomEngine.getWallItemImage(_loc6_.productClassId,new Vector3d(90,0,0),64,this,_loc6_.extraParam);
                        _loc2_.previewCallbackId = _loc7_.id;
                        break;
                     case ProductTypeEnum.const_308:
                        _loc8_ = page.viewer.catalog.windowManager;
                        _loc9_ = _window.findChildByName("pixelsBackground") as IWindowContainer;
                        _loc10_ = 4291611852;
                        if(_loc9_ != null)
                        {
                           _loc9_.visible = true;
                           _loc10_ = uint(_loc9_.color);
                        }
                        _loc4_ = new BitmapData(var_91.width,var_91.height,false,_loc10_);
                        _loc11_ = null;
                        _loc12_ = page.viewer.catalog as HabboCatalog;
                        if(_loc12_.avatarRenderManager != null)
                        {
                           _loc14_ = _loc12_.sessionDataManager.figure;
                           _loc13_ = _loc12_.avatarRenderManager.createAvatarImage(_loc14_,AvatarScaleType.const_66);
                           if(_loc13_ != null)
                           {
                              _loc13_.setDirection(AvatarSetType.const_50,3);
                              _loc13_.initActionAppends();
                              _loc13_.appendAction(AvatarAction.const_333,AvatarAction.const_586);
                              _loc13_.appendAction(AvatarAction.const_669,_loc6_.productClassId);
                              _loc13_.endActionAppends();
                              _loc13_.updateAnimationByFrames(1);
                              _loc13_.updateAnimationByFrames(1);
                              _loc11_ = _loc13_.getImage(AvatarSetType.const_40);
                              _loc15_ = new Point(0,0);
                              if(_loc11_ != null)
                              {
                                 _loc17_ = _loc13_.avatarSpriteData;
                                 if(_loc17_ != null)
                                 {
                                 }
                                 _loc15_.x = (_loc4_.width - _loc11_.width) / 2;
                                 _loc15_.y = (_loc4_.height - _loc11_.height) / 2;
                                 for each(_loc18_ in _loc13_.getSprites())
                                 {
                                    if(_loc18_.id == "avatar")
                                    {
                                       _loc19_ = _loc13_.getLayerData(_loc18_);
                                       _loc5_.x = _loc19_.dx;
                                       _loc5_.y = _loc19_.dy;
                                    }
                                 }
                              }
                              _loc16_ = new Point(0,_loc11_.height - 16);
                              addEffectSprites(_loc4_,_loc13_,_loc5_,_loc15_.add(_loc16_),false);
                              _loc4_.copyPixels(_loc11_,_loc11_.rect,_loc15_,null,null,true);
                              addEffectSprites(_loc4_,_loc13_,_loc5_,_loc15_.add(_loc16_));
                           }
                        }
                        break;
                     case ProductTypeEnum.const_512:
                        break;
                     default:
                        Logger.log("[ProductViewCatalogWidget] Unknown Product Type: " + _loc6_.productType);
                  }
                  if(_loc7_ != null)
                  {
                     _loc4_ = _loc7_.data;
                  }
                  break;
               default:
                  Logger.log("[ProductViewCatalogWidget] Unknown pricing model" + _loc2_.pricingModel);
            }
            setPreviewImage(_loc4_,_loc5_);
         }
         _window.invalidate();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:* = null;
         for each(_loc3_ in page.offers)
         {
            if(_loc3_.previewCallbackId == param1)
            {
               setPreviewImage(param2);
               break;
            }
         }
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
         }
      }
      
      override public function init() : void
      {
         var_1058 = _window.findChildByName("ctlg_product_name") as ITextWindow;
         var_1059 = _window.findChildByName("ctlg_description") as ITextWindow;
         var_91 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         var_1413 = new Point(var_91.x,var_91.y);
         var_526 = _window.findChildByName("bundleGrid") as IItemGridWindow;
         var_1179 = _window.findChildByName("bundleGridScrollbar") as IScrollbarWindow;
         if(var_526 == null)
         {
            Logger.log("[ProductViewCatalogWidget] Bundle Grid not initialized!");
         }
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         var_1221 = _loc1_.content as XML;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset;
         var_1180 = _loc2_.content as BitmapData;
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,onPreviewProduct);
      }
      
      private function addEffectSprites(param1:BitmapData, param2:IAvatarImage, param3:Point, param4:Point, param5:Boolean = true) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = null;
         for each(_loc6_ in param2.getSprites())
         {
            _loc7_ = _window.getChildIndex(var_91);
            _loc8_ = param2.getLayerData(_loc6_);
            _loc9_ = 0;
            _loc10_ = _loc6_.getDirectionOffsetX(param2.getDirection());
            _loc11_ = _loc6_.getDirectionOffsetY(param2.getDirection());
            _loc12_ = _loc6_.getDirectionOffsetZ(param2.getDirection());
            _loc13_ = 0;
            if(!param5)
            {
               if(_loc12_ >= 0)
               {
                  continue;
               }
            }
            else if(_loc12_ < 0)
            {
               continue;
            }
            if(_loc6_.hasDirections)
            {
               _loc13_ = param2.getDirection();
            }
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.animationFrame;
               _loc10_ += _loc8_.dx;
               _loc11_ += _loc8_.dy;
               _loc13_ += _loc8_.directionOffset;
            }
            if(_loc13_ < 0)
            {
               _loc13_ += 8;
            }
            if(_loc13_ > 7)
            {
               _loc13_ -= 8;
            }
            _loc14_ = param2.getScale() + "_" + _loc6_.member + "_" + _loc13_ + "_" + _loc9_;
            _loc15_ = param2.getAsset(_loc14_);
            if(_loc15_ != null)
            {
               _loc16_ = (_loc15_.content as BitmapData).clone();
               _loc17_ = 1;
               _loc18_ = param4.x - 1 * _loc15_.offset.x + _loc10_;
               _loc19_ = param4.y - 1 * _loc15_.offset.y + _loc11_;
               if(_loc6_.ink == 33)
               {
                  _loc20_ = new Matrix(1,0,0,1,_loc18_ - param3.x,_loc19_ - param3.y);
                  param1.draw(_loc16_,_loc20_,null,BlendMode.ADD,null,false);
               }
               else
               {
                  param1.copyPixels(_loc16_,_loc16_.rect,new Point(_loc18_ - param3.x,_loc19_ - param3.y));
               }
            }
         }
      }
      
      private function removeEffectSprites() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_1949)
         {
            _window.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_1949 = new Array();
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         var _loc2_:* = page.viewer.catalog.configuration.getKey("image.library.url");
         _loc2_ += "catalogue/";
         var _loc3_:* = _loc2_ + param1 + ".gif";
         Logger.log("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _loc3_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc4_,"image/gif");
         _loc5_.addEventListener(AssetLoaderEvent.const_30,onPreviewImageReady);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1180 = null;
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Point = null) : void
      {
         if(var_91 == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(true)
         {
            var_91.bitmap = new BitmapData(var_91.width,var_91.height,true,16777215);
         }
         var_91.bitmap.fillRect(var_91.bitmap.rect,16777215);
         var _loc3_:Point = new Point((0 - param1.width) / 2,(0 - param1.height) / 2);
         var_91.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         var_91.invalidate();
         var_91.x = var_1413.x;
         var_91.y = var_1413.y;
         if(param2 != null)
         {
            var_91.x += param2.x;
            var_91.y += param2.y;
         }
      }
   }
}
