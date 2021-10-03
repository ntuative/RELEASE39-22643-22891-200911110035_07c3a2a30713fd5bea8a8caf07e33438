package com.sulake.habbo.widget.chooser
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.events.ChooserItem;
   
   public class ChooserView
   {
       
      
      private var _items:Array;
      
      private var _window:IFrameWindow;
      
      private const const_1294:uint = 0;
      
      private const const_1295:uint = 4.293848814E9;
      
      private var _title:String;
      
      private var _widget:ChooserWidget;
      
      private const const_1488:uint = 4.282169599E9;
      
      private var _itemList:IItemListWindow;
      
      private var var_1256:Boolean;
      
      private var var_566:int;
      
      public function ChooserView(param1:ChooserWidget, param2:String)
      {
         super();
         _widget = param1;
         _title = param2;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = XmlAsset(_widget.assets.getAssetByName("chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = _widget.windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
         if(_window == null)
         {
            return;
         }
         _window.caption = _title;
         _itemList = _window.findChildByName("item_list") as IItemListWindow;
         var _loc2_:IWindow = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onClose);
         }
         _window.center();
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && false;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function removeItem(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         if(_items == null || _itemList == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_] as ChooserItem;
            if(_loc3_ != null)
            {
               if(_loc3_.id == param1 && _loc3_.category == param2)
               {
                  _items.splice(_loc4_,1);
                  break;
               }
            }
            _loc4_++;
         }
         populate(_items,var_1256);
      }
      
      private function highlightItem(param1:int) : void
      {
         var _loc2_:* = null;
         if(_itemList == null || param1 < 0 || param1 > _itemList.numListItems || param1 == var_566)
         {
            return;
         }
         if(var_566 != -1)
         {
            _loc2_ = _itemList.getListItemAt(var_566) as IWindowContainer;
            if(_loc2_ != null)
            {
               _loc2_.color = !!(var_566 % 2) ? uint(const_1294) : uint(const_1295);
            }
         }
         _loc2_ = _itemList.getListItemAt(param1) as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.color = const_1488;
            var_566 = param1;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
      }
      
      public function populate(param1:Array, param2:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         if(_widget == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null || _itemList == null || param1 == null)
         {
            return;
         }
         _itemList.destroyListItems();
         var _loc3_:XmlAsset = XmlAsset(_widget.assets.getAssetByName("chooser_item"));
         if(_loc3_ == null)
         {
            return;
         }
         _items = param1.slice();
         var_1256 = param2;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_] as ChooserItem;
            if(_loc4_ != null)
            {
               _loc5_ = _widget.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
               if(_loc5_ == null)
               {
                  return;
               }
               _loc7_ = _loc5_.findChildByName("itemtext") as ITextWindow;
               if(_loc7_ == null)
               {
                  return;
               }
               _loc5_.id = _loc6_;
               if(var_1256)
               {
                  _loc7_.text = _loc4_.name + " id: " + _loc4_.id;
               }
               else
               {
                  _loc7_.text = _loc4_.name;
               }
               _loc5_.color = !!(_loc6_ % 2) ? uint(const_1294) : uint(const_1295);
               _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onListItemClicked);
               _itemList.addListItem(_loc5_);
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _itemList.numListItems)
         {
            _loc5_ = _itemList.getListItemAt(_loc6_) as IWindowContainer;
            if(_loc5_ != null)
            {
               _loc5_.width = _itemList.width;
            }
            _loc6_++;
         }
         var_566 = -1;
      }
      
      private function onListItemClicked(param1:WindowMouseEvent) : void
      {
         if(param1 == null || param1.window == null || _items == null)
         {
            return;
         }
         var _loc2_:int = param1.window.id;
         if(_loc2_ < 0 || _loc2_ > _items.length)
         {
            return;
         }
         var _loc3_:ChooserItem = _items[_loc2_] as ChooserItem;
         if(_loc3_ == null)
         {
            return;
         }
         _widget.choose(_loc3_.id,_loc3_.category);
         highlightItem(_loc2_);
      }
   }
}
