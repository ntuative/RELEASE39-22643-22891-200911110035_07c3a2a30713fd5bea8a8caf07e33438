package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.communication.enum.HabboHotelViewEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public class HabboHotelView implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_176:Function;
      
      private var var_809:uint = 0;
      
      private var var_659:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var name_1:IEventDispatcher;
      
      public function HabboHotelView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IEventDispatcher)
      {
         var asset:IAsset = null;
         var layout:XML = null;
         var bmp:IBitmapWrapperWindow = null;
         var result:Array = null;
         var windowManager:IHabboWindowManager = param1;
         var assetLibrary:IAssetLibrary = param2;
         var events:IEventDispatcher = param3;
         super();
         var_659 = assetLibrary;
         name_1 = events;
         var array:Array = new Array();
         asset = assetLibrary.getAssetByName("hotel_view_window");
         if(asset == null)
         {
            throw new Error("Missing asset; hotel view window layout!");
         }
         layout = XmlAsset(asset).content as XML;
         if(layout)
         {
            _window = windowManager.buildFromXML(layout,0) as IWindowContainer;
            _window.rectangle = _window.desktop.rectangle;
            _window.groupChildrenWithTag("bitmap",array,true);
            for each(bmp in array)
            {
               result = bmp.properties.filter(function(param1:*, param2:int, param3:Array):Boolean
               {
                  return PropertyStruct(param1).key == "bitmap_asset_name";
               });
               if(result.length)
               {
                  asset = assetLibrary.getAssetByName(PropertyStruct(result[0]).value as String);
                  if(asset && asset is BitmapDataAsset)
                  {
                     bmp.bitmap = BitmapDataAsset(asset).content as BitmapData;
                  }
               }
            }
         }
      }
      
      public function loadHotelViewImage(param1:String, param2:Function = null) : void
      {
         var _loc3_:AssetLoaderStruct = var_659.loadAssetFromFile("hotelview_png",new URLRequest(param1),"image/png");
         if(param2 == null)
         {
            _loc3_.addEventListener(AssetLoaderEvent.const_30,hotelViewLoadedHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_45,hotelViewLoadedHandler);
         }
         else
         {
            var_176 = param2;
            _loc3_.addEventListener(AssetLoaderEvent.const_30,hotelViewLoadedCallbackHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_45,hotelViewLoadedCallbackHandler);
         }
         ++var_809;
      }
      
      private function bannerLoadedCallbackHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = var_659.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_45)
         {
            if(name_1 != null)
            {
               name_1.dispatchEvent(new Event(HabboHotelViewEvent.const_56));
            }
         }
         else if(param1.type == AssetLoaderEvent.const_30)
         {
            if(name_1 != null)
            {
               name_1.dispatchEvent(new Event(HabboHotelViewEvent.const_358));
            }
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(_window && true)
            {
               _loc5_ = _window.findChildByName("banner_placeholder") as IBitmapWrapperWindow;
               if(_loc5_)
               {
                  _loc5_.bitmap = _loc4_;
               }
            }
            if(var_176 != null)
            {
               var_176(_loc4_);
               var_176 = null;
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.const_30,bannerLoadedCallbackHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_45,bannerLoadedCallbackHandler);
      }
      
      private function hotelViewLoadedCallbackHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = var_659.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_45)
         {
            if(name_1 != null)
            {
               name_1.dispatchEvent(new Event(HabboHotelViewEvent.const_56));
            }
         }
         else if(param1.type == AssetLoaderEvent.const_30)
         {
            if(name_1 != null)
            {
               name_1.dispatchEvent(new Event(HabboHotelViewEvent.const_358));
            }
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(_window && true)
            {
            }
            if(var_176 != null)
            {
               var_176(_loc4_);
               var_176 = null;
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.const_30,hotelViewLoadedCallbackHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_45,hotelViewLoadedCallbackHandler);
      }
      
      public function loadBannerImage(param1:String, param2:Function) : void
      {
         var _loc3_:AssetLoaderStruct = var_659.loadAssetFromFile("hotel_view_banner_" + var_809,new URLRequest(param1),"image/png");
         if(param2 == null)
         {
            _loc3_.addEventListener(AssetLoaderEvent.const_30,bannerLoadedHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_45,bannerLoadedHandler);
         }
         else
         {
            if(name_1 != null)
            {
               name_1.dispatchEvent(new Event(HabboHotelViewEvent.const_500));
            }
            var_176 = param2;
            _loc3_.addEventListener(AssetLoaderEvent.const_30,bannerLoadedCallbackHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_45,bannerLoadedCallbackHandler);
         }
         ++var_809;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function bannerLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = var_659.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_30)
         {
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(_window && true)
            {
               _loc5_ = _window.findChildByName("banner_placeholder") as IBitmapWrapperWindow;
               if(_loc5_)
               {
                  _loc5_.bitmap = _loc4_;
               }
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.const_30,bannerLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_45,bannerLoadedHandler);
      }
      
      public function hide() : void
      {
         if(_window && true)
         {
            _window.visible = false;
         }
      }
      
      private function hotelViewLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = var_659.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_30)
         {
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(_window && true)
            {
               _loc5_ = _window.findChildByTag("bitmap") as IBitmapWrapperWindow;
               if(_loc5_ != null)
               {
                  _loc5_.width = _loc4_.width;
                  _loc5_.height = _loc4_.height;
                  _loc5_.bitmap = _loc4_;
               }
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.const_30,hotelViewLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_45,hotelViewLoadedHandler);
      }
      
      public function show() : void
      {
         if(_window && true)
         {
            _window.visible = true;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _disposed = true;
            var_176 = null;
            name_1 = null;
         }
      }
   }
}
