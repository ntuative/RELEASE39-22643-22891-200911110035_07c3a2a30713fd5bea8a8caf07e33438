package com.sulake.habbo.navigator.roomthumbnails
{
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
   import com.sulake.habbo.navigator.Util;
   import flash.utils.Dictionary;
   
   public class ThumbnailEditorModel
   {
      
      public static const const_48:int = 2;
      
      public static const const_31:int = 3;
      
      public static const const_33:int = 1;
       
      
      private var var_623:int = 1;
      
      private var _data:RoomThumbnailData;
      
      private var _selected:RoomThumbnailObjectData;
      
      public function ThumbnailEditorModel()
      {
         super();
      }
      
      private function addObject(param1:int) : void
      {
         Logger.log("New object pos: " + param1);
         var _loc2_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc2_.pos = param1;
         _loc2_.imgId = 0;
         _data.objects.push(_loc2_);
         _selected = _loc2_;
         Logger.log("Object count after insert: " + _data.objects.length);
      }
      
      public function setImg(param1:int) : void
      {
         if(var_623 == const_33)
         {
            _data.bgImgId = param1;
         }
         else if(var_623 == const_48)
         {
            _data.frontImgId = param1;
         }
         if(var_623 == const_31)
         {
            if(_selected == null)
            {
               return;
            }
            _selected.imgId = param1;
         }
      }
      
      public function set data(param1:RoomThumbnailData) : void
      {
         this._data = param1;
         this.var_623 = const_33;
         if(this._data.objects.length > 0)
         {
            this._selected = this._data.objects[0];
         }
         else
         {
            this._selected = null;
         }
      }
      
      public function set mode(param1:int) : void
      {
         this.var_623 = param1;
      }
      
      public function getImgId() : int
      {
         if(var_623 == const_33)
         {
            return _data.bgImgId;
         }
         if(var_623 == const_48)
         {
            return _data.frontImgId;
         }
         return _selected == null ? -1 : int(_selected.imgId);
      }
      
      public function get mode() : int
      {
         return this.var_623;
      }
      
      public function findByPos(param1:int) : RoomThumbnailObjectData
      {
         var _loc2_:* = null;
         for each(_loc2_ in this._data.objects)
         {
            if(_loc2_.pos == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get data() : RoomThumbnailData
      {
         return this._data;
      }
      
      public function get selected() : RoomThumbnailObjectData
      {
         return this._selected;
      }
      
      public function set selected(param1:RoomThumbnailObjectData) : void
      {
         this._selected = param1;
      }
      
      public function setPos(param1:int) : void
      {
         _selected = findByPos(param1);
         if(_selected == null)
         {
            addObject(param1);
         }
      }
      
      public function getBlockedPositions() : Dictionary
      {
         var _loc2_:* = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc2_ in this._data.objects)
         {
            if(_loc2_.imgId > 0)
            {
               _loc1_[_loc2_.pos] = "taken";
            }
         }
         return _loc1_;
      }
      
      private function removeSelected() : void
      {
         var _loc1_:Array = _data.objects;
         if(this._selected == null)
         {
            return;
         }
         var _loc2_:int = Util.remove(_loc1_,this._selected);
         this._selected = null;
         if(_loc1_.length > 0)
         {
            this._selected = _loc1_[Math.min(_loc2_,_loc1_.length - 1)];
         }
      }
   }
}
