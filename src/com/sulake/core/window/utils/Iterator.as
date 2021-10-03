package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class Iterator extends Proxy implements IIterator
   {
      
      private static const const_166:uint = 4;
      
      private static const const_1042:uint = 0;
      
      private static const const_170:uint = 2;
      
      private static const const_167:uint = 1;
      
      private static const const_169:uint = 5;
      
      private static const const_168:uint = 3;
       
      
      private var var_42:WindowController;
      
      private var _type:uint;
      
      public function Iterator(param1:WindowController)
      {
         super();
         var_42 = param1;
         if(var_42 is ITabContextWindow)
         {
            _type = Iterator.const_169;
         }
         else if(var_42 is IItemGridWindow)
         {
            _type = Iterator.const_166;
         }
         else if(var_42 is IItemListWindow)
         {
            _type = Iterator.const_168;
         }
         else if(var_42 is ISelectorWindow)
         {
            _type = Iterator.const_170;
         }
         else if(var_42 is IWindowContainer)
         {
            _type = Iterator.const_167;
         }
         else
         {
            _type = Iterator.const_1042;
         }
      }
      
      public function indexOf(param1:*) : int
      {
         switch(_type)
         {
            case Iterator.const_169:
               return ITabContextWindow(var_42).getTabItemIndex(param1);
            case Iterator.const_170:
               return ISelectorWindow(var_42).getSelectableIndex(param1);
            case Iterator.const_168:
               return IItemListWindow(var_42).getListItemIndex(param1);
            case Iterator.const_166:
               return IItemGridWindow(var_42).getGridItemIndex(param1);
            case Iterator.const_167:
               return IWindowContainer(var_42).getChildIndex(param1);
            default:
               return -1;
         }
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         switch(_type)
         {
            case Iterator.const_169:
               return ITabContextWindow(var_42).getTabItemAt(uint(param1));
            case Iterator.const_170:
               return var_42.getChildAt(uint(param1));
            case Iterator.const_168:
               return IItemListWindow(var_42).getListItemAt(uint(param1));
            case Iterator.const_166:
               return IItemGridWindow(var_42).getGridItemAt(uint(param1));
            case Iterator.const_167:
               return IWindowContainer(var_42).getChildAt(uint(param1));
            default:
               return null;
         }
      }
      
      public function get length() : uint
      {
         switch(_type)
         {
            case Iterator.const_169:
               return ITabContextWindow(var_42).numTabItems;
            case Iterator.const_170:
               return ISelectorWindow(var_42).numSelectables;
            case Iterator.const_168:
               return IItemListWindow(var_42).numListItems;
            case Iterator.const_166:
               return IItemGridWindow(var_42).numGridItems;
            case Iterator.const_167:
               return IWindowContainer(var_42).numChildren;
            default:
               return 0;
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         var _loc2_:* = 0;
         switch(_type)
         {
            case Iterator.const_169:
               _loc2_ = uint(ITabContextWindow(var_42).numTabItems);
               break;
            case Iterator.const_170:
               _loc2_ = uint(ISelectorWindow(var_42).numSelectables);
               break;
            case Iterator.const_168:
               _loc2_ = uint(IItemListWindow(var_42).numListItems);
               break;
            case Iterator.const_166:
               _loc2_ = uint(IItemGridWindow(var_42).numGridItems);
               break;
            case Iterator.const_167:
               _loc2_ = uint(IWindowContainer(var_42).numChildren);
         }
         if(param1 < _loc2_)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         switch(_type)
         {
            case Iterator.const_169:
               _loc3_ = param2 as ITabButtonWindow;
               _loc4_ = var_42 as ITabContextWindow;
               if(_loc4_.getTabItemIndex(_loc3_) > -1)
               {
                  _loc4_.removeTabItem(_loc3_);
               }
               _loc4_.addTabItemAt(_loc3_,uint(param1));
               break;
            case Iterator.const_170:
               _loc5_ = param2 as ISelectableWindow;
               _loc6_ = var_42 as ISelectorWindow;
               if(_loc5_)
               {
                  if(_loc6_.getSelectableIndex(_loc5_) > -1)
                  {
                     _loc6_.removeSelectable(_loc5_);
                  }
                  _loc6_.addSelectableAt(_loc5_,uint(param1));
               }
               else
               {
                  var_42.addChildAt(param2,uint(param1));
               }
               break;
            case Iterator.const_168:
               _loc7_ = var_42 as IItemListWindow;
               _loc8_ = param2 as IWindow;
               if(_loc7_.getListItemIndex(_loc8_) > -1)
               {
                  _loc7_.removeListItem(_loc8_);
               }
               _loc7_.addListItemAt(_loc8_,uint(param1));
               break;
            case Iterator.const_166:
               _loc9_ = var_42 as IItemGridWindow;
               _loc10_ = param2 as IWindow;
               if(_loc9_.getGridItemIndex(_loc10_) > -1)
               {
                  _loc9_.removeGridItem(_loc10_);
               }
               _loc9_.addGridItemAt(_loc10_,uint(param1));
               break;
            case Iterator.const_167:
               _loc11_ = var_42 as IWindowContainer;
               _loc12_ = param2 as IWindow;
               if(_loc11_.getChildIndex(_loc12_) > -1)
               {
                  _loc11_.removeChild(_loc12_);
               }
               _loc11_.addChildAt(_loc12_,uint(param1));
         }
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         switch(_type)
         {
            case Iterator.const_169:
               return ITabContextWindow(var_42).getTabItemAt(uint(param1) - 1);
            case Iterator.const_170:
               return ISelectorWindow(var_42).getSelectableAt(uint(param1) - 1);
            case Iterator.const_168:
               return IItemListWindow(var_42).getListItemAt(uint(param1) - 1);
            case Iterator.const_166:
               return IItemGridWindow(var_42).getGridItemAt(uint(param1) - 1);
            case Iterator.const_167:
               return IWindowContainer(var_42).getChildAt(uint(param1) - 1);
            default:
               return null;
         }
      }
   }
}
