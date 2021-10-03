package com.sulake.habbo.navigator.roomthumbnails
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateRoomThumbnailMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class RoomThumbnailCtrl
   {
       
      
      private var var_1474:IWindowContainer;
      
      private var _window:IWindowContainer;
      
      private var var_1240:IButtonWindow;
      
      private var _navigator:HabboNavigator;
      
      private var _bgTabButton:IButtonWindow;
      
      private var _active:Boolean;
      
      private var _model:ThumbnailEditorModel;
      
      private var var_1241:IButtonWindow;
      
      private var var_1475:IWindowContainer;
      
      public function RoomThumbnailCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         _model = new ThumbnailEditorModel();
      }
      
      private function refreshTab() : void
      {
         setEnabled(_bgTabButton,this._model.mode != ThumbnailEditorModel.const_33);
         setEnabled(var_1241,this._model.mode != ThumbnailEditorModel.const_48);
         setEnabled(var_1240,this._model.mode != ThumbnailEditorModel.const_31);
      }
      
      private function onBgTabButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("bg tab clicked");
         this._model.mode = ThumbnailEditorModel.const_33;
         this.reload();
      }
      
      private function refreshTileLoc(param1:IBitmapWrapperWindow, param2:int) : void
      {
         var _loc3_:Point = _navigator.thumbRenderer.getScreenLocForPos(param2);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
      }
      
      private function refreshHeader() : void
      {
         this._navigator.thumbRenderer.refreshThumbnail(IWindowContainer(_window.findChildByName("picframe")),_model.data,false);
      }
      
      private function onCancelButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("cancel clicked");
         this._navigator.roomInfoViewCtrl.backToRoomSettings();
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
         if(_active)
         {
            _model.data = _navigator.data.enteredGuestRoom.thumbnail.getCopy();
         }
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      private function onSaveButton(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("save clicked");
         var _loc3_:Array = new Array();
         for each(_loc4_ in _model.data.objects)
         {
            if(_loc4_.imgId > 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc5_ = new UpdateRoomThumbnailMessageComposer(_navigator.data.enteredGuestRoom.flatId,_model.data.bgImgId,_model.data.frontImgId,_loc3_.length);
         for each(_loc4_ in _loc3_)
         {
            _loc5_.addObj(_loc4_.pos,_loc4_.imgId);
         }
         _navigator.send(_loc5_);
      }
      
      private function onTopTabButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("top tab clicked");
         this._model.mode = ThumbnailEditorModel.const_48;
         this.reload();
      }
      
      private function getImgSelectorContainer(param1:int) : IWindowContainer
      {
         return IWindowContainer(_window.findChildByName("img_selector_container_" + param1));
      }
      
      private function prepareWindow(param1:IWindowContainer) : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(_navigator.getXmlWindow("ros_roomicon_editor"));
         param1.addChildAt(_window,0);
         _bgTabButton = IButtonWindow(find("bg_tab"));
         var_1241 = IButtonWindow(find("top_tab"));
         var_1240 = IButtonWindow(find("obj_tab"));
         var_1475 = IWindowContainer(find("tile_grid"));
         var_1474 = IWindowContainer(find("now_editing_container"));
         Util.setProcDirectly(find("save"),onSaveButton);
         Util.setProcDirectly(find("cancel"),onCancelButton);
         Util.setProcDirectly(_bgTabButton,onBgTabButton);
         Util.setProcDirectly(var_1241,onTopTabButton);
         Util.setProcDirectly(var_1240,onObjTabButton);
      }
      
      private function onSelectPos(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("obj pos clicked: " + param2.id);
         _model.setPos(param2.id);
         this.reload();
      }
      
      public function refresh(param1:IWindowContainer) : void
      {
         if(!_active)
         {
            return;
         }
         prepareWindow(param1);
         refreshHeader();
         refreshTab();
         refreshEditArea();
         refreshImgSelectors();
         _window.height = Util.getLowestPoint(this._window) + 4;
         _window.visible = true;
      }
      
      private function onImgSel(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("img selected: " + param2.id);
         _model.setImg(param2.id);
         this.reload();
      }
      
      private function reload() : void
      {
         this._navigator.roomInfoViewCtrl.reload();
      }
      
      private function refreshImgSelector(param1:int) : void
      {
         var _loc7_:* = null;
         var _loc2_:IWindowContainer = this.getImgSelectorContainer(param1);
         if(_model.mode != param1)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         var _loc3_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("img_list"));
         if(_loc3_.numListItems == 0)
         {
            populateImgList(_loc3_,param1);
         }
         var _loc4_:Array = _navigator.thumbRenderer.imageConfigurations.getImageList(param1);
         var _loc5_:int = _model.getImgId();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc6_];
            Logger.log("CHECK SELECTED: " + _loc5_ + ", " + _loc7_.id);
            _loc7_.setSelected(_loc7_.id == _loc5_);
            _loc6_++;
         }
      }
      
      private function refreshPositionGrid() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:IWindowContainer = var_1475;
         _loc1_.visible = true;
         if(_loc1_.numChildren == 0)
         {
            while(_loc3_ <= RoomThumbnailRenderer.const_364)
            {
               _loc4_ = _navigator.getButton("pos_" + _loc3_,"rico_tile",onSelectPos,0,0,_loc3_);
               refreshTileLoc(_loc4_,_loc3_);
               _loc1_.addChild(_loc4_);
               _loc5_ = _navigator.getButton("block_" + _loc3_,"rico_tile_x",onSelectPos,0,0,_loc3_);
               _loc5_.visible = false;
               refreshTileLoc(_loc5_,_loc3_);
               _loc1_.addChild(_loc5_);
               _loc3_++;
            }
            _loc1_.addChild(_navigator.getButton("selected","rico_tile_s",null,0,0));
         }
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc1_.findChildByName("selected"));
         if(true)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         refreshTileLoc(_loc2_,_model.selected.pos);
         refreshBlockedTiles(_loc1_);
      }
      
      private function onObjTabButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("obj tab clicked");
         this._model.mode = ThumbnailEditorModel.const_31;
         this.reload();
      }
      
      private function refreshEditArea() : void
      {
         var _loc1_:IWindowContainer = var_1474;
         Util.hideChildren(_loc1_);
         refreshEditImg(_loc1_,"edit_bg",true);
         refreshEditImg(_loc1_,"edit_top",true);
         refreshEditImg(_loc1_,"edit_obj",true,false);
         if(true)
         {
            refreshPositionGrid();
         }
      }
      
      private function refreshBlockedTiles(param1:IWindowContainer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = _model.getBlockedPositions();
         while(_loc3_ <= RoomThumbnailRenderer.const_364)
         {
            param1.findChildByName("block_" + _loc3_).visible = _loc2_[_loc3_] != null;
            _loc3_++;
         }
      }
      
      private function populateImgList(param1:IItemListWindow, param2:int) : void
      {
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc6_:Array = _navigator.thumbRenderer.imageConfigurations.getImageList(param2);
         var _loc7_:* = null;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc9_ = _loc8_ % 3;
            if(_loc9_ == 0)
            {
               _loc7_ = IWindowContainer(_navigator.windowManager.createWindow("row_" + _loc8_,"",HabboWindowType.const_53,HabboWindowStyle.const_37,HabboWindowParam.const_63,new Rectangle(0,0,param1.width,66)));
               param1.addListItem(_loc7_);
            }
            _loc10_ = _loc6_[_loc8_];
            _loc11_ = IBitmapWrapperWindow(_navigator.windowManager.createWindow("img_" + _loc8_,"",HabboWindowType.const_200,HabboWindowStyle.const_38,0 | 0,new Rectangle(_loc9_ * 66,0,66,66),onImgSel,_loc10_.id));
            _loc11_.bitmap = new BitmapData(_loc11_.width,_loc11_.height);
            _loc10_.registerListImg(_loc11_);
            _loc7_.addChild(_loc11_);
            _loc8_++;
         }
      }
      
      public function close() : void
      {
         this._active = false;
      }
      
      private function find(param1:String) : IWindow
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function refreshImgSelectors() : void
      {
         refreshImgSelector(ThumbnailEditorModel.const_33);
         refreshImgSelector(ThumbnailEditorModel.const_48);
         refreshImgSelector(ThumbnailEditorModel.const_31);
      }
      
      private function refreshEditImg(param1:IWindowContainer, param2:String, param3:Boolean, param4:Boolean = true) : void
      {
         if(!param3)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(param2));
         if(_loc5_.bitmap != null)
         {
            _loc5_.visible = true;
            return;
         }
         var _loc6_:BitmapData = _navigator.getButtonImage(param2);
         if(param4)
         {
            _navigator.thumbRenderer.roundEdges(_loc6_);
         }
         _loc5_.bitmap = _loc6_;
         _loc5_.visible = true;
      }
      
      private function setEnabled(param1:IButtonWindow, param2:Boolean) : void
      {
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
   }
}
