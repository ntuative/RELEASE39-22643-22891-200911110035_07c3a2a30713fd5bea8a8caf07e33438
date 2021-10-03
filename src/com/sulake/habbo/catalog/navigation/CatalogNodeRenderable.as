package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import com.sulake.habbo.window.enum.HabboIconType;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class CatalogNodeRenderable extends CatalogNode
   {
      
      private static const const_979:Number = 4285716709;
      
      private static var _listSubItemWindowLayout:XML;
      
      private static var var_1309:XML;
      
      private static var var_1310:XML;
       
      
      private var var_2067:IWindowContainer;
      
      private var var_866:Boolean = false;
      
      private var _window:IWindowContainer;
      
      private var _icon:BitmapData;
      
      private var var_1311:Number = 4.294967295E9;
      
      private var _list:IItemListWindow;
      
      public function CatalogNodeRenderable(param1:ICatalogNavigator, param2:NodeData, param3:int)
      {
         var _loc4_:* = null;
         super(param1,param2,param3);
         if(_listSubItemWindowLayout == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("navigation_list_subitem") as XmlAsset;
            _listSubItemWindowLayout = _loc4_.content as XML;
         }
         if(var_1309 == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("navigation_list_item") as XmlAsset;
            var_1309 = _loc4_.content as XML;
         }
         if(var_1310 == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("list_item_list") as XmlAsset;
            var_1310 = _loc4_.content as XML;
         }
      }
      
      override public function activate() : void
      {
         var _loc1_:IWindow = _window.findChildByTag("SELECTION_COLOR");
         if(_loc1_ != null)
         {
            if(var_1311 == 4294967295)
            {
               var_1311 = _loc1_.color;
            }
            _loc1_.color = const_979;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         navigator.activateNode(this);
      }
      
      private function retrieveIconImage(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         var _loc2_:String = param1;
         var _loc3_:* = navigator.catalog.configuration.getKey("image.library.url");
         _loc3_ += "catalogue/";
         var _loc4_:* = _loc3_ + _loc2_ + ".png";
         var _loc5_:URLRequest = new URLRequest(_loc4_);
         var _loc6_:AssetLoaderStruct = navigator.catalog.assets.loadAssetFromFile(_loc2_,_loc5_,"image/gif");
         _loc6_.addEventListener(AssetLoaderEvent.const_30,onIconImageReady);
      }
      
      private function setElementImage(param1:String, param2:String, param3:Boolean = true, param4:uint = 0) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow = _window.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc5_ != null)
         {
            _loc6_ = navigator.catalog.assets.getAssetByName(param2) as BitmapDataAsset;
            if(_loc6_ == null)
            {
               return;
            }
            _loc7_ = _loc6_.content as BitmapData;
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _loc8_ = 0;
            _loc9_ = 0;
            if(param3)
            {
               _loc8_ = (_loc5_.width - _loc7_.width) / 2;
               _loc9_ = (_loc5_.height - _loc7_.height) / 2;
            }
            if(param4 > 0)
            {
               _loc7_ = _loc7_.clone();
               _loc10_ = param4 >> 16 & 255;
               _loc11_ = param4 >> 8 & 255;
               _loc12_ = param4 >> 0 & 255;
               _loc13_ = _loc10_ / 255 * 1;
               _loc14_ = _loc11_ / 255 * 1;
               _loc15_ = _loc12_ / 255 * 1;
               _loc16_ = new ColorTransform(_loc13_,_loc14_,_loc15_);
               _loc7_.colorTransform(_loc7_.rect,_loc16_);
            }
            _loc5_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(_loc8_,_loc9_));
         }
         else
         {
            Logger.log("[CatalogNodeRenderable] Could not find element: " + param1);
         }
      }
      
      override public function open() : void
      {
         var _loc1_:* = null;
         showChildren();
         var_866 = true;
         if(isBranch)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = HabboIconType.const_1091;
            }
         }
      }
      
      public function removeFromList(param1:IItemListWindow) : void
      {
         param1.removeListItem(_window);
         if(isBranch)
         {
            param1.removeListItem(_list);
         }
      }
      
      private function getLocalizationKey(param1:String, param2:String = "") : String
      {
         var _loc3_:ICoreLocalizationManager = (navigator.catalog as HabboCatalog).localization;
         if(_loc3_ == null)
         {
            return param2;
         }
         return _loc3_.getKey(param1,param2);
      }
      
      private function createWindow() : void
      {
         if(depth == 1)
         {
            _window = navigator.catalog.windowManager.buildFromXML(var_1309) as IWindowContainer;
         }
         else
         {
            _window = navigator.catalog.windowManager.buildFromXML(_listSubItemWindowLayout) as IWindowContainer;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         var _loc2_:IWindow = _window.findChildByTag("DOWNBTN");
         if(disabled)
         {
            if(_loc1_ != null)
            {
               _loc1_.caption = localization + " " + getLocalizationKey("catalog.comingsoon");
            }
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         else if(_loc1_ != null)
         {
            _loc1_.caption = localization;
         }
         if(isLeaf)
         {
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         setElementImage("iconBackgroundBitmap","icon_bg_img",true,color);
         initIcon();
         if(!disabled)
         {
            _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            if(_loc2_ != null)
            {
               _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            }
         }
      }
      
      private function showChildren() : void
      {
         var _loc1_:* = null;
         if(_list == null)
         {
            createList();
         }
         for each(_loc1_ in children)
         {
            if(_loc1_.isNavigateable)
            {
               (_loc1_ as CatalogNodeRenderable).addToList(_list);
            }
         }
         if(_list != null)
         {
            _list.visible = true;
            _list.height = 0;
         }
      }
      
      private function onIconImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.assetName;
            setElementImage("icon",_loc3_);
         }
      }
      
      override public function get isOpen() : Boolean
      {
         return var_866;
      }
      
      private function createList() : void
      {
         _list = navigator.catalog.windowManager.buildFromXML(var_1310) as IItemListWindow;
         if(_list == null)
         {
            throw new Error("Failed to construct list-item-list from XML!");
         }
         removeChildren();
      }
      
      private function initIcon() : void
      {
         var _loc2_:String = iconName;
         if(_loc2_ == "")
         {
            return;
         }
         if(navigator.catalog.assets.hasAsset(_loc2_))
         {
            setElementImage("icon",_loc2_);
         }
         else
         {
            retrieveIconImage(_loc2_);
         }
      }
      
      override public function deActivate() : void
      {
         var _loc1_:IWindow = _window.findChildByTag("SELECTION_COLOR");
         if(_loc1_ != null)
         {
            _loc1_.color = var_1311;
         }
      }
      
      override public function dispose() : void
      {
         if(var_866)
         {
            close();
            deActivate();
         }
         _icon = null;
         _window = null;
         var_2067 = null;
         _list = null;
         super.dispose();
      }
      
      public function set icon(param1:BitmapData) : void
      {
         _icon = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      override public function close() : void
      {
         var _loc1_:* = null;
         removeChildren();
         var_866 = false;
         if(isBranch)
         {
            _loc1_ = _window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = HabboIconType.const_1116;
            }
         }
      }
      
      override public function get icon() : BitmapData
      {
         return _icon;
      }
      
      public function addToList(param1:IItemListWindow) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         param1.addListItem(_window);
         if(isBranch)
         {
            if(_list == null)
            {
               createList();
            }
            param1.addListItem(_list);
         }
      }
      
      private function removeChildren() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in children)
         {
            if(_loc1_.isNavigateable)
            {
               (_loc1_ as CatalogNodeRenderable).removeFromList(_list);
            }
         }
         if(_list != null)
         {
            _list.height = 0;
            _list.visible = false;
            _list.x = 0;
         }
      }
   }
}
