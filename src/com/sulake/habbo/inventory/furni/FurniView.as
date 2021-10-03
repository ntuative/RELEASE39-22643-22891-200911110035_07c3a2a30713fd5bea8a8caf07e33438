package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.enum.FurniCategory;
   import com.sulake.habbo.inventory.items.FloorItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IItem;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class FurniView implements IInventoryView, IGetImageListener
   {
       
      
      private var _view:IWindowContainer;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _disposed:Boolean = false;
      
      private var var_449:Map;
      
      private var var_448:String;
      
      private const const_1499:int = 2;
      
      private var _roomEngine:IRoomEngine;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2150:int;
      
      private var _model:FurniModel;
      
      public function FurniView(param1:FurniModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine, param5:IHabboConfigurationManager)
      {
         var _loc6_:* = null;
         var _loc9_:* = null;
         super();
         _model = param1;
         _assetLibrary = param3;
         _windowManager = param2;
         _roomEngine = param4;
         var_449 = new Map();
         var_449.add(FurniModel.const_39,new FurniGridView(_model,FurniModel.const_39,_windowManager,_assetLibrary,_roomEngine));
         var_449.add(FurniModel.const_41,new FurniGridView(_model,FurniModel.const_41,_windowManager,_assetLibrary,_roomEngine));
         if(param5 != null && param5.getKey("use.new.pets","0") == "1")
         {
            _loc6_ = _assetLibrary.getAssetByName("inventory_furni_base_pets_xml");
         }
         else
         {
            _loc6_ = _assetLibrary.getAssetByName("inventory_furni_base_xml");
         }
         var _loc7_:XmlAsset = XmlAsset(_loc6_);
         _view = IWindowContainer(_windowManager.buildFromXML(XML(_loc7_.content)));
         _view.visible = false;
         _view.procedure = windowEventProc;
         switchCategory(FurniModel.const_39);
         var _loc8_:IWindowContainer = _view.findChildByName("action_container") as IWindowContainer;
         if(_loc8_ != null)
         {
            _loc6_ = _assetLibrary.getAssetByName("inventory_furni_preview_xml");
            _loc7_ = XmlAsset(_loc6_);
            _loc9_ = IWindowContainer(_windowManager.buildFromXML(XML(_loc7_.content)));
            if(_loc9_ != null)
            {
               _loc8_.addChild(_loc9_);
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "placeinroom_btn":
                  _model.requestSelectedFurniPlacement(false);
                  break;
               case "offertotrade_btn":
                  _model.requestSelectedFurniToTrading();
                  break;
               default:
                  _model.cancelFurniInMover();
            }
         }
         else if(param1.type == WindowEvent.const_51)
         {
            switch(param2.name)
            {
               case "tab_floor":
                  switchCategory(FurniModel.const_39);
                  break;
               case "tab_wall":
                  switchCategory(FurniModel.const_41);
                  break;
               case "tab_pets":
                  switchCategory(FurniModel.const_309);
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:GroupItem = _model.getGroupItemInIndex(_model.getSelectedItemIndex());
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.previewCallbackId == param1)
         {
            setPreviewImage(param2);
         }
      }
      
      public function updateItem(param1:String, param2:GroupItem, param3:int) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:FurniGridView = var_449.getValue(param1);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.updateItem(param3,param2.window);
         updateActionView();
      }
      
      public function switchCategory(param1:String) : void
      {
         var _loc5_:* = null;
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         if(var_448 == param1)
         {
            return;
         }
         var _loc2_:ISelectorWindow = _view.findChildByName("category_selector") as ISelectorWindow;
         switch(param1)
         {
            case FurniModel.const_41:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_wall"));
               var_448 = FurniModel.const_41;
               break;
            case FurniModel.const_39:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_floor"));
               var_448 = FurniModel.const_39;
               break;
            case FurniModel.const_309:
               _loc2_.setSelected(_loc2_.getSelectableByName("tab_pets"));
               var_448 = FurniModel.const_309;
               break;
            default:
               throw new Error("Unknown item category: \"" + param1 + "\"");
         }
         var _loc3_:IWindowContainer = _view.findChildByName("grid_container") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.removeChildAt(0);
         var _loc4_:FurniGridView = var_449.getValue(var_448);
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.window;
            if(_loc5_ == null)
            {
               return;
            }
            _loc3_.visible = true;
            _loc3_.addChild(_loc5_);
            _loc3_.invalidate();
            updateActionView();
         }
         _model.furniCategorySwitch(param1);
      }
      
      public function get visibleCategoryId() : String
      {
         return var_448;
      }
      
      public function clearViews() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = [FurniModel.const_39,FurniModel.const_41];
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_];
            _loc3_ = var_449.getValue(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.clearGrid();
            }
            _loc4_++;
         }
         updateActionView();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _model = null;
            _view = null;
            _windowManager = null;
            _roomEngine = null;
            _disposed = true;
         }
      }
      
      public function addItemAt(param1:String, param2:GroupItem, param3:int) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:FurniGridView = var_449.getValue(param1);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.addItemAt(param2.window,param3);
      }
      
      public function updateActionView() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc21_:* = null;
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc3_:int = _model.getSelectedItemIndex();
         _loc4_ = _model.getGroupItemInIndex(_loc3_,var_448);
         if(_loc3_ > -1 && _loc4_ != null && _loc4_.peek() != null)
         {
            _loc5_ = _loc4_.peek();
            _loc1_ = true;
            if(_loc5_.category == FurniCategory.const_316)
            {
               _loc16_ = _assetLibrary.getAssetByName("icon_wallpaper_png");
               if(_loc16_ != null)
               {
                  setPreviewImage(_loc16_.content as BitmapData);
               }
               _loc10_ = "${inventory.furni.item.wallpaper.name}";
               _loc11_ = "${inventory.furni.item.wallpaper.desc}";
            }
            else if(_loc5_.category == FurniCategory.const_254)
            {
               _loc16_ = _assetLibrary.getAssetByName("icon_floor_png");
               if(_loc16_ != null)
               {
                  setPreviewImage(_loc16_.content as BitmapData);
               }
               _loc10_ = "${inventory.furni.item.floor.name}";
               _loc11_ = "${inventory.furni.item.floor.desc}";
            }
            else if(_loc5_.category == FurniCategory.const_282)
            {
               _loc16_ = _assetLibrary.getAssetByName("icon_landscape_png");
               if(_loc16_ != null)
               {
                  setPreviewImage(_loc16_.content as BitmapData);
               }
               _loc10_ = "${inventory.furni.item.landscape.name}";
               _loc11_ = "${inventory.furni.item.landscape.desc}";
            }
            else
            {
               if(_loc5_.category == FurniCategory.const_124)
               {
                  _loc10_ = "${poster_" + _loc5_.extras + "_name}";
                  _loc11_ = "${poster_" + _loc5_.extras + "_desc}";
               }
               if(_loc5_ is FloorItem)
               {
                  _loc21_ = _roomEngine.getFurnitureImage(_loc4_.type,new Vector3d(180,0,0),64,this);
               }
               else
               {
                  _loc21_ = _roomEngine.getWallItemImage(_loc4_.type,new Vector3d(180,0,0),64,this,_loc4_.extras);
               }
               if(_loc21_ != null)
               {
                  _loc2_ = _loc21_.data;
               }
               setPreviewImage(_loc2_);
               _loc4_.previewCallbackId = _loc21_.id;
            }
            _loc17_ = _loc4_.getTradeableCount();
            _loc6_ = _view.findChildByName("tradeable_icon") as IBitmapWrapperWindow;
            _loc7_ = _view.findChildByName("tradeable_number") as ITextWindow;
            _loc8_ = _view.findChildByName("tradeable_number_container") as IWindow;
            _loc9_ = _view.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc6_ != null && _loc7_ != null && _loc8_ != null && _loc9_ != null)
            {
               _loc20_ = _loc4_.getTradeableCount();
               if(_loc20_ == 0)
               {
                  _loc19_ = _assetLibrary.getAssetByName("no_trade_icon_png");
                  _loc18_ = _loc19_.content as BitmapData;
                  _loc8_.visible = false;
                  _loc7_.visible = false;
                  _loc9_.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
               }
               else
               {
                  _loc19_ = _assetLibrary.getAssetByName("trade_icon_png");
                  _loc18_ = _loc19_.content as BitmapData;
                  _loc8_.visible = true;
                  _loc7_.visible = true;
                  _loc7_.text = String(_loc20_);
                  _loc9_.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
               }
               _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               if(_loc18_ != null)
               {
                  _loc6_.bitmap.copyPixels(_loc18_,_loc18_.rect,new Point(0,0),null,null,true);
               }
               _loc6_.invalidate();
            }
            _loc6_ = _view.findChildByName("recyclable_icon") as IBitmapWrapperWindow;
            _loc7_ = _view.findChildByName("recyclable_number") as ITextWindow;
            _loc8_ = _view.findChildByName("recyclable_number_container") as IWindow;
            _loc9_ = _view.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc6_ != null && _loc7_ != null && _loc8_ != null && _loc9_ != null)
            {
               _loc20_ = _loc4_.getRecyclableCount();
               if(_loc20_ == 0)
               {
                  _loc19_ = _assetLibrary.getAssetByName("no_recycle_icon_png");
                  _loc18_ = _loc19_.content as BitmapData;
                  _loc8_.visible = false;
                  _loc7_.visible = false;
                  _loc9_.toolTipCaption = "${inventory.furni.preview.not_recyclable}";
               }
               else
               {
                  _loc19_ = _assetLibrary.getAssetByName("recycle_icon_png");
                  _loc18_ = _loc19_.content as BitmapData;
                  _loc8_.visible = true;
                  _loc7_.visible = true;
                  _loc7_.text = String(_loc20_);
                  _loc9_.toolTipCaption = "${inventory.furni.preview.recyclable_amount}";
               }
               _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               if(_loc18_ != null)
               {
                  _loc6_.bitmap.copyPixels(_loc18_,_loc18_.rect,new Point(0,0),null,null,true);
               }
               _loc6_.invalidate();
            }
         }
         else
         {
            setPreviewImage(null);
            _loc6_ = _view.findChildByName("tradeable_icon") as IBitmapWrapperWindow;
            _loc7_ = _view.findChildByName("tradeable_number") as ITextWindow;
            _loc8_ = _view.findChildByName("tradeable_number_container") as IWindow;
            _loc9_ = _view.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc6_ && _loc7_ && _loc8_ && _loc9_)
            {
               _loc6_.bitmap = null;
               _loc7_.visible = false;
               _loc8_.visible = false;
            }
            _loc6_ = _view.findChildByName("recyclable_icon") as IBitmapWrapperWindow;
            _loc7_ = _view.findChildByName("recyclable_number") as ITextWindow;
            _loc8_ = _view.findChildByName("recyclable_number_container") as IWindow;
            _loc9_ = _view.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc6_ && _loc7_ && _loc8_ && _loc9_)
            {
               _loc6_.bitmap = null;
               _loc7_.visible = false;
               _loc8_.visible = false;
            }
         }
         var _loc13_:Boolean = false;
         _loc12_ = _view.findChildByName("placeinroom_btn") as IButtonWindow;
         if(_loc12_)
         {
            if(_loc1_)
            {
               _loc12_.enable();
            }
            else
            {
               _loc12_.disable();
            }
            _loc12_.visible = !_loc13_;
         }
         _loc12_ = _view.findChildByName("offertotrade_btn") as IButtonWindow;
         if(_loc12_)
         {
            if(_loc1_ && _loc4_ != null && _loc5_ != null && _model.canUserOfferToTrade())
            {
               if(_loc4_.getUnlockedCount() && _loc5_.tradeable)
               {
                  _loc12_.enable();
               }
               else
               {
                  _loc12_.disable();
               }
            }
            else
            {
               _loc12_.disable();
            }
            _loc12_.visible = _loc13_;
         }
         var _loc14_:ITextWindow = _view.findChildByName("furni_name") as ITextWindow;
         if(_loc14_ != null)
         {
            if(_loc10_ != null)
            {
               _loc14_.text = _loc10_;
            }
            else if(_loc5_ != null)
            {
               _loc14_.text = "${roomItem.name." + _loc5_.type + "}";
            }
            else
            {
               _loc14_.text = "";
            }
         }
         var _loc15_:ITextWindow = _view.findChildByName("furni_description") as ITextWindow;
         if(_loc15_ != null)
         {
            if(_loc11_ != null)
            {
               _loc15_.text = _loc11_;
            }
            else if(_loc5_ != null)
            {
               _loc15_.text = "${roomItem.desc." + _loc5_.type + "}";
            }
            else
            {
               _loc15_.text = "";
            }
         }
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(_view == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc3_:IItem = param1.peek();
         if(_loc3_ is FloorItem)
         {
            _loc2_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(2,0,0),64,this);
         }
         else
         {
            _loc2_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(2,0,0),64,this,param1.extras);
         }
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_.data);
         }
         _loc4_ = _view.findChildByName("placeinroom_btn") as IButtonWindow;
         if(_loc4_)
         {
            _loc4_.disable();
         }
         _loc4_ = _view.findChildByName("offertotrade_btn") as IButtonWindow;
         if(_loc4_)
         {
            _loc4_.disable();
         }
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = _view.findChildByName("furni_preview_image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,16777215);
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         _loc2_.invalidate();
      }
      
      public function removeItem(param1:String, param2:int) : void
      {
         var _loc3_:FurniGridView = var_449.getValue(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.removeItem(param2);
         updateActionView();
      }
      
      public function addItemToBottom(param1:String, param2:GroupItem) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:FurniGridView = var_449.getValue(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.addItemToBottom(param2.window);
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         var _loc2_:* = null;
         if(_view == null)
         {
            return null;
         }
         if(false)
         {
            return null;
         }
         var _loc1_:Boolean = false;
         _loc2_ = _view.findChildByName("placeinroom_btn");
         if(_loc2_ != null)
         {
            _loc2_.visible = !_loc1_;
         }
         _loc2_ = _view.findChildByName("offertotrade_btn");
         if(_loc2_ != null)
         {
            _loc2_.visible = _loc1_;
         }
         return _view;
      }
   }
}
