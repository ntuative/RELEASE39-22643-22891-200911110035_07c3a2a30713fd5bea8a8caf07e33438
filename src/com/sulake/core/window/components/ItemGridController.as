package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowStyle;
   import com.sulake.core.window.enum.WindowType;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class ItemGridController extends ItemListController implements IItemGridWindow
   {
       
      
      public function ItemGridController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         _horizontal = param3 != WindowType.const_435;
         var_471 = true;
         if(!_horizontal)
         {
            throw new Error("Horizontal item grid not yet implemented!");
         }
      }
      
      public function getGridItemAt(param1:uint) : IWindow
      {
         var _loc2_:IItemListWindow = resolveColumnByIndex(param1);
         return _loc2_.getListItemAt(param1 / numColumns);
      }
      
      protected function resolveColumnByItem(param1:IWindow) : IItemListWindow
      {
         var _loc3_:* = null;
         var _loc2_:uint = numColumns;
         while(_loc2_-- > 0)
         {
            _loc3_ = IItemListWindow(getListItemAt(_loc2_));
            if(_loc3_.getListItemIndex(param1) > -1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      protected function listEventProc(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      public function addGridItemAt(param1:IWindow, param2:uint) : IWindow
      {
         offsetGridItemsForwards(param1,Math.min(numGridItems,param2));
         return param1;
      }
      
      override public function set spacing(param1:int) : void
      {
         var _loc2_:uint = numListItems;
         while(_loc2_-- > 0)
         {
            IItemListWindow(getListItemAt(_loc2_)).spacing = param1;
         }
         super.spacing = param1;
      }
      
      public function setGridItemIndex(param1:IWindow, param2:int) : void
      {
         if(removeGridItem(param1) == null)
         {
            throw new Error("Item not found in grid!");
         }
         addListItemAt(param1,param2);
      }
      
      public function getRowNumberByItemIndex(param1:uint) : uint
      {
         return param1 / numColumns;
      }
      
      public function removeGridItem(param1:IWindow) : IWindow
      {
         var _loc2_:int = getGridItemIndex(param1);
         if(_loc2_ == -1)
         {
            return null;
         }
         if(offsetGridItemsBackwards(_loc2_) != param1)
         {
            throw new Error("Item grid is out of order!");
         }
         var _loc3_:IItemListWindow = resolveColumnByIndex(_loc2_);
         if(!_horizontal)
         {
            _loc3_.width = _loc3_.scrollableRegion.width;
         }
         else
         {
            _loc3_.height = _loc3_.scrollableRegion.height;
         }
         return param1;
      }
      
      override public function set autoArrangeItems(param1:Boolean) : void
      {
         super.autoArrangeItems = param1;
         var _loc2_:int = 0;
         while(_loc2_ < numColumns)
         {
            IItemListWindow(getListItemAt(_loc2_)).autoArrangeItems = param1;
            _loc2_++;
         }
      }
      
      public function getGridItemIndex(param1:IWindow) : int
      {
         var _loc2_:IItemListWindow = resolveColumnByItem(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.getListItemIndex(param1) * numColumns + getColumnIndex(_loc2_);
      }
      
      protected function addColumnForItem(param1:IWindow) : IItemListWindow
      {
         var _loc2_:IItemListWindow = _context.create(_name + "_COLUMN_" + numListItems,null,WindowType.const_285,WindowStyle.const_223,0 | 0,new Rectangle(0,0,Math.max(param1.width,0),Math.max(param1.height,0)),listEventProc,null,numListItems,null,[WindowController.INTERNAL_CHILD_TAG,WindowController.EXCLUDE_CHILD_TAG]) as IItemListWindow;
         _loc2_.background = background;
         _loc2_.color = color;
         _loc2_.spacing = _spacing;
         addListItem(_loc2_);
         _loc2_.addListItem(param1);
         return _loc2_;
      }
      
      public function get numGridItems() : uint
      {
         var _loc1_:uint = numListItems;
         var _loc2_:* = 0;
         while(_loc1_-- > 0)
         {
            _loc2_ += IItemListWindow(getListItemAt(_loc1_)).numListItems;
         }
         return _loc2_;
      }
      
      protected function offsetGridItemsForwards(param1:IWindow, param2:uint) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = 0;
         var _loc3_:uint = numGridItems;
         var _loc4_:int = _loc3_ - 1;
         var _loc6_:uint = numColumns;
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_)
         {
            IItemListWindow(getListItemAt(_loc9_)).autoArrangeItems = false;
            _loc9_++;
         }
         if(_loc3_ <= param2)
         {
            resolveColumnForNextItem(param1);
         }
         else
         {
            if(numRows == 1)
            {
               _loc7_ = getGridItemAt(_loc4_);
               _loc5_ = resolveColumnForNextItem(_loc7_);
               _loc4_--;
            }
            while(_loc4_ >= param2)
            {
               _loc7_ = getGridItemAt(_loc4_);
               _loc8_ = uint(getRowNumberByItemIndex(_loc4_ + 1));
               _loc5_ = resolveColumnByIndex(_loc4_ + 1);
               _loc5_.addListItemAt(_loc7_,_loc8_);
               _loc4_--;
            }
            resolveColumnByIndex(param2).addListItemAt(param1,param2 / numColumns);
         }
         var _loc10_:* = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc5_ = IItemListWindow(getListItemAt(_loc9_));
            _loc5_.autoArrangeItems = true;
            _loc5_.height = _loc5_.scrollableRegion.height;
            _loc10_ = uint(Math.max(_loc10_,_loc5_.height));
            _loc9_++;
         }
         _container.height = _loc10_;
      }
      
      override public function get scrollStepH() : Number
      {
         if(_horizontal)
         {
            return 0;
         }
         return 0 / numColumns;
      }
      
      public function removeGridItemAt(param1:int) : IWindow
      {
         return removeGridItem(getGridItemAt(param1));
      }
      
      override public function get scrollStepV() : Number
      {
         if(_horizontal)
         {
            return 0 / numRows;
         }
         return 0;
      }
      
      public function destroyGridItems() : void
      {
         var _loc1_:uint = numColumns;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            IItemListWindow(getListItemAt(_loc2_)).destroyListItems();
            _loc2_++;
         }
      }
      
      public function getGridItemByID(param1:uint) : IWindow
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:uint = numColumns;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc5_) as IItemListWindow;
            _loc4_ = _loc3_.getListItemByID(param1);
            if(_loc4_)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:int = 0;
         while(_loc2_ < numListItems)
         {
            getListItemAt(_loc2_).color = param1;
            _loc2_++;
         }
      }
      
      public function swapGridItems(param1:IWindow, param2:IWindow) : void
      {
         throw new Error("ItemGridWindow / Unimplemented method!");
      }
      
      public function addGridItem(param1:IWindow) : IWindow
      {
         var _loc2_:IItemListWindow = resolveColumnForNextItem(param1);
         return param1;
      }
      
      protected function listItemEventHandler(param1:WindowEvent) : void
      {
         var _loc2_:* = null;
         if(param1.type == WindowEvent.const_372)
         {
            _loc2_ = param1.target as IWindow;
            removeGridItem(_loc2_);
         }
      }
      
      public function getGridItemByName(param1:String) : IWindow
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:uint = numColumns;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc5_) as IItemListWindow;
            _loc4_ = _loc3_.getListItemByName(param1);
            if(_loc4_)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      protected function resolveColumnForNextItem(param1:IWindow) : IItemListWindow
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         if(numColumns == 0)
         {
            return addColumnForItem(param1);
         }
         var _loc2_:uint = numGridItems;
         if(_loc2_ > 0)
         {
            _loc4_ = resolveColumnByIndex(_loc2_ > 0 ? uint(_loc2_ - 1) : uint(0));
            _loc5_ = getListItemIndex(_loc4_);
            _loc6_ = _loc5_ > -1 ? _loc5_ == numColumns - 1 : true;
            if(_loc6_)
            {
               if(_loc4_.numListItems == 1)
               {
                  if(_loc4_.rectangle.right + param1.width <= var_22.width)
                  {
                     return addColumnForItem(param1);
                  }
               }
            }
            _loc3_ = getListItemAt(!!_loc6_ ? 0 : uint(_loc5_ + 1)) as IItemListWindow;
         }
         else
         {
            _loc3_ = getListItemAt(0) as IItemListWindow;
         }
         _loc3_.addListItem(param1);
         if(param1.width > _loc3_.width)
         {
            _loc3_.width = param1.width;
         }
         if(param1.rectangle.bottom > _loc3_.height)
         {
            _loc3_.height = param1.rectangle.bottom;
         }
         return _loc3_;
      }
      
      public function swapGridItemsAt(param1:int, param2:int) : void
      {
         swapGridItems(getGridItemAt(param1),getGridItemAt(param2));
      }
      
      override public function set background(param1:Boolean) : void
      {
         super.background = param1;
         var _loc2_:int = 0;
         while(_loc2_ < numListItems)
         {
            getListItemAt(_loc2_).background = param1;
            _loc2_++;
         }
      }
      
      protected function removeColumnAt(param1:uint) : void
      {
         var _loc2_:IItemListWindow = removeChildAt(param1) as IItemListWindow;
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getColumnIndex(param1:IItemListWindow) : int
      {
         return getListItemIndex(param1);
      }
      
      protected function offsetGridItemsBackwards(param1:uint) : IWindow
      {
         var _loc7_:* = null;
         var _loc2_:uint = getRowNumberByItemIndex(param1);
         var _loc3_:IItemListWindow = resolveColumnByIndex(param1);
         var _loc4_:IWindow = _loc3_.removeListItemAt(_loc2_);
         var _loc5_:uint = numGridItems;
         var _loc6_:uint = param1;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc8_:int = 0;
         while(_loc8_ < numColumns)
         {
            IItemListWindow(getListItemAt(_loc8_)).autoArrangeItems = false;
            _loc8_++;
         }
         while(_loc6_ < _loc5_)
         {
            _loc2_ = getRowNumberByItemIndex(_loc6_);
            _loc7_ = getGridItemAt(_loc6_ + 1);
            _loc3_ = resolveColumnByIndex(_loc6_);
            _loc3_.addListItemAt(_loc7_,_loc2_);
            _loc6_++;
         }
         var _loc9_:* = 0;
         _loc8_ = 0;
         while(_loc8_ < numColumns)
         {
            _loc3_ = IItemListWindow(getListItemAt(_loc8_));
            _loc3_.autoArrangeItems = true;
            _loc3_.height = _loc3_.scrollableRegion.height;
            _loc9_ = uint(Math.max(_loc9_,_loc3_.height));
            _loc8_++;
         }
         _container.height = _loc9_;
         return _loc4_;
      }
      
      public function getColumnNumberByItemIndex(param1:uint) : uint
      {
         return param1 % numColumns;
      }
      
      public function removeGridItems() : void
      {
         var _loc1_:uint = numColumns;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            IItemListWindow(getListItemAt(_loc2_)).removeListItems();
            _loc2_++;
         }
      }
      
      public function get numColumns() : uint
      {
         return numListItems;
      }
      
      protected function resolveColumnByIndex(param1:uint) : IItemListWindow
      {
         return getListItemAt(param1 % numColumns) as IItemListWindow;
      }
      
      public function get numRows() : uint
      {
         var _loc1_:* = 0;
         var _loc2_:uint = numColumns;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = uint(Math.max(_loc1_,IItemListWindow(getListItemAt(_loc3_)).numListItems));
            _loc3_++;
         }
         return _loc1_;
      }
   }
}
