package com.sulake.habbo.widget.roomchat
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RoomChatWidget extends RoomWidgetBase implements ICoreUpdateReceiver
   {
      
      private static const const_724:int = 10;
      
      private static const const_470:int = 25;
      
      private static const const_1037:int = 6000;
      
      private static const const_1040:int = 9;
      
      private static const const_725:int = 4000;
      
      private static const const_1039:int = 3;
      
      private static const const_89:int = 18;
      
      private static const const_1038:int = 25;
      
      private static const const_1036:int = 1;
      
      private static const const_264:int = 9;
      
      private static const const_468:int = 8;
      
      private static const const_330:int = 0;
      
      private static const const_469:int = (const_468 + const_330) * const_89 + const_89;
       
      
      private var var_773:Number = 1;
      
      private var _disposed:Boolean = false;
      
      private var var_518:int = 18;
      
      private var var_324:IItemListWindow;
      
      private var var_629:int = 0;
      
      private var _containerWindow:IWindowContainer;
      
      private var _isAnimating:Boolean = false;
      
      private var var_151:int;
      
      private var var_1887:int = 0;
      
      private var var_1147:Boolean = false;
      
      private var var_137:IWindowContainer;
      
      private var _itemList:Array;
      
      private var var_37:RoomChatHistoryViewer;
      
      private var var_1886:int = 150;
      
      private var var_441:Number = 1;
      
      private var var_70:Array;
      
      private var var_220:Array;
      
      private var var_630:int = 0;
      
      private var var_1888:int;
      
      private var var_628:Point;
      
      private var var_1388:Number = 0;
      
      private var var_90:Component = null;
      
      public function RoomChatWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager, param5:int, param6:Component)
      {
         _itemList = new Array();
         var_70 = new Array();
         var_220 = new Array();
         var_628 = new Point();
         var_151 = const_469 + const_264;
         super(param1,param2,param3);
         var_1888 = param5;
         _containerWindow = param1.createWindow("chat_container","",HabboWindowType.const_53,HabboWindowStyle.const_37,HabboWindowParam.const_34,new Rectangle(0,0,200,var_151 + RoomChatHistoryPulldown.const_68),null,0) as IWindowContainer;
         _containerWindow.background = true;
         _containerWindow.color = 33554431;
         _containerWindow.tags.push("room_widget_chat");
         var_324 = param1.createWindow("chat_contentlist","",HabboWindowType.const_862,HabboWindowStyle.const_38,0 | 0 | 0,new Rectangle(0,0,200,var_151),null,0) as IItemListWindow;
         _containerWindow.addChild(var_324);
         var_137 = param1.createWindow("chat_active_content","",HabboWindowType.const_53,HabboWindowStyle.const_38,HabboWindowParam.const_63,new Rectangle(0,0,200,var_151),null,0) as IWindowContainer;
         var_324.addListItem(var_137);
         var_37 = new RoomChatHistoryViewer(this,param1,_containerWindow,param2);
         var_1886 = int(param4.getKey("chat.history.item.max.count","150"));
         var _loc7_:Boolean = int(param4.getKey("chat.history.disabled","0")) == 1 ? true : false;
         if(var_37 != null)
         {
            var_37.disabled = _loc7_;
         }
         if(param6 != null)
         {
            var_90 = param6;
            var_90.registerUpdateReceiver(this,1);
         }
      }
      
      public function onPulldownCloseButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_37 != null)
         {
            var_37.hideHistoryViewer();
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetChatUpdateEvent.const_671,onChatMessage);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_248,onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_564,onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_481,onRoomViewUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function get mainWindow() : IWindow
      {
         return _containerWindow;
      }
      
      public function onItemMouseOver(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      public function resetArea() : void
      {
         if(var_37 == null)
         {
            return;
         }
         animationStop();
         var_151 = const_469 + const_264;
         _containerWindow.height = var_151 + var_37.pulldownBarHeight;
         var_324.width = 0 - 0;
         var_324.height = var_151;
         var_137.width = 0 - 0;
         if(historyViewerActive())
         {
            var_137.height = getTotalContentHeight() + const_264;
         }
         else
         {
            var_137.height = var_151;
         }
         var_324.scrollV = 1;
         if(!historyViewerActive())
         {
            var_37.containerResized(_containerWindow.rectangle);
         }
         purgeItems();
         alignItems();
      }
      
      public function resizeContainerToLowestItem() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_70.length)
         {
            _loc4_ = var_70[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc1_ += const_470;
         _loc1_ = _loc1_ < 0 ? 0 : int(_loc1_);
         var _loc3_:int = _containerWindow.rectangle.bottom;
         stretchAreaBottomTo(_containerWindow.rectangle.top + _loc1_);
         _loc3_ -= _containerWindow.rectangle.bottom;
         if(Math.abs(_loc3_) < RoomChatHistoryViewer.const_803)
         {
            resetArea();
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_70.length)
         {
            _loc4_ = var_70[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         var_1147 = true;
      }
      
      private function processBuffer() : void
      {
         if(_isAnimating)
         {
            return;
         }
         if(false)
         {
            return;
         }
         while(var_70.length > const_1036 || historyViewerActive() && false)
         {
            activateItemFromBuffer();
         }
         var _loc1_:Boolean = false;
         if(false)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = checkLastItemAllowsAdding(var_70[0]);
         }
         if(_loc1_)
         {
            activateItemFromBuffer();
            var_629 = getTimer() + const_725;
         }
         else
         {
            if(false && false)
            {
               var_518 = getItemSpacing(_itemList["-1"],var_70[0]);
            }
            else
            {
               var_518 = const_89;
            }
            animationStart();
         }
      }
      
      private function setChatItemLocHorizontal(param1:RoomChatItem) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 == null || var_37 == null)
         {
            return;
         }
         var _loc2_:Number = (param1.senderX + var_628.x) * var_773;
         var _loc3_:Number = _loc2_ - param1.width / 2;
         var _loc4_:Number = _loc3_ + param1.width;
         var _loc5_:Number = 0 - const_724;
         var _loc6_:Number = 0 + const_724 - 0;
         var _loc7_:Boolean = _loc3_ >= _loc5_ && _loc3_ <= _loc6_;
         var _loc8_:Boolean = _loc4_ >= _loc5_ && _loc4_ <= _loc6_;
         if(_loc7_ && _loc8_)
         {
            _loc9_ = _loc3_;
            _loc10_ = _loc9_;
         }
         else if(_loc2_ >= 0)
         {
            _loc9_ = _loc6_ - param1.width;
         }
         else
         {
            _loc9_ = _loc5_;
         }
         param1.x = _loc9_ + 0 + _containerWindow.x;
         if(_loc2_ < _loc5_ || _loc2_ > _loc6_)
         {
            param1.hidePointer();
         }
         else
         {
            param1.setPointerOffset(_loc3_ - _loc9_);
         }
      }
      
      public function onItemMouseOut(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      private function checkLastItemAllowsAdding(param1:RoomChatItem) : Boolean
      {
         if(false)
         {
            return true;
         }
         var _loc2_:RoomChatItem = _itemList["-1"];
         if(param1 == null || _loc2_ == null)
         {
            return false;
         }
         if(_loc2_.view == null)
         {
            return true;
         }
         if(var_137.rectangle.bottom - (var_137.y + _loc2_.y + _loc2_.height) <= getItemSpacing(_loc2_,param1))
         {
            return false;
         }
         return true;
      }
      
      public function mouseUp() : void
      {
         var _loc1_:Number = _containerWindow.rectangle.bottom - 0;
         if(_loc1_ < const_469)
         {
            if(_loc1_ <= var_151 + _containerWindow.y)
            {
               if(historyViewerActive())
               {
                  hideHistoryViewer();
               }
               resetArea();
               return;
            }
         }
         if(var_1147 && !historyViewerActive())
         {
            resetArea();
            var_1147 = false;
         }
      }
      
      private function getFreeItemId() : String
      {
         return "chat_" + var_1888.toString() + "_item_" + (var_1887++).toString();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         while(false)
         {
            _loc1_ = var_220.shift();
         }
         var_37.dispose();
         var_37 = null;
         while(false)
         {
            _loc1_ = _itemList.shift();
            _loc1_.dispose();
         }
         while(false)
         {
            _loc1_ = var_70.shift();
            _loc1_.dispose();
         }
         _containerWindow.dispose();
         if(var_90 != null)
         {
            var_90.removeUpdateReceiver(this);
            var_90 = null;
         }
         super.dispose();
         _disposed = true;
      }
      
      private function animationStop() : void
      {
         _isAnimating = false;
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetChatUpdateEvent.const_671,onChatMessage);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_248,onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_564,onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_481,onRoomViewUpdate);
      }
      
      public function onPulldownMouseDown(param1:WindowMouseEvent) : void
      {
         if(var_37 != null)
         {
            var_37.beginDrag(param1.stageY,true);
         }
      }
      
      private function alignItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_37 == null)
         {
            return;
         }
         _loc1_ = -1;
         while(_loc1_ >= 0)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemLocHorizontal(_loc2_);
               setChatItemLocVertical(_loc2_);
            }
            _loc1_--;
         }
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemRenderable(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < var_70.length)
         {
            _loc2_ = var_70[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemLocHorizontal(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function onChatMessage(param1:RoomWidgetChatUpdateEvent) : void
      {
         var _loc2_:RoomChatItem = new RoomChatItem(this,windowManager,assets,getFreeItemId(),localizations);
         _loc2_.define(param1);
         if(var_773 != 1)
         {
            _loc2_.senderX /= var_773;
         }
         _loc2_.senderX -= 0;
         setChatItemLocHorizontal(_loc2_);
         var_70.push(_loc2_);
         processBuffer();
      }
      
      private function setChatItemLocVertical(param1:RoomChatItem) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 != null)
         {
            _loc2_ = _itemList.indexOf(param1);
            _loc3_ = !!historyViewerActive() ? 0 : Number(var_441);
            if(_loc2_ == -1)
            {
               param1.y = getAreaBottom() - (_loc3_ + 1) * const_89 - const_264;
            }
            else
            {
               _loc4_ = _itemList[_loc2_ + 1].aboveLevels;
               if(_loc4_ < 2)
               {
                  param1.y = _itemList[_loc2_ + 1].y - getItemSpacing(param1,_itemList[_loc2_ + 1]);
               }
               else
               {
                  param1.y = _itemList[_loc2_ + 1].y - _loc4_ * const_89;
               }
            }
         }
      }
      
      public function disableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_70.length)
         {
            _loc1_ = var_70[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
      }
      
      private function animationStart() : void
      {
         if(_isAnimating)
         {
            return;
         }
         selectItemsToMove();
         _isAnimating = true;
      }
      
      public function hideHistoryViewer() : void
      {
         if(var_37 != null)
         {
            var_37.hideHistoryViewer();
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(getTimer() > var_629 && var_629 > 0)
         {
            var_629 = -1;
            animationStart();
         }
         if(_isAnimating)
         {
            _loc2_ = param1 / const_1038 * const_1039;
            if(_loc2_ + var_630 > var_518)
            {
               _loc2_ = var_518 - var_630;
            }
            if(_loc2_ > 0)
            {
               moveItemsUp(_loc2_);
               var_630 += _loc2_;
            }
            if(var_630 >= var_518)
            {
               var_518 = const_89;
               var_630 = 0;
               animationStop();
               processBuffer();
               var_629 = getTimer() + const_725;
            }
         }
         if(var_37 != null)
         {
            var_37.update(param1);
         }
      }
      
      public function getTotalContentHeight() : int
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc3_];
            if(_loc1_ != null)
            {
               if(_loc3_ == 0)
               {
                  _loc2_ += const_89;
               }
               else
               {
                  _loc2_ += getItemSpacing(_itemList[_loc3_ - 1],_loc1_);
               }
               _loc2_ += (_loc1_.aboveLevels - 1) * const_89;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent) : void
      {
         var _loc2_:Rectangle = param1.rect;
         if(param1.scale > 0)
         {
            if(var_1388 == 0)
            {
               var_1388 = param1.scale;
            }
            else
            {
               var_773 = param1.scale / var_1388;
            }
         }
         if(param1.positionDelta != null)
         {
            var_628.x += param1.positionDelta.x / var_773;
            var_628.y += param1.positionDelta.y / var_773;
         }
         if(param1.rect != null)
         {
            if(var_37 == null)
            {
               return;
            }
            _containerWindow.x = _loc2_.x;
            _containerWindow.y = _loc2_.y;
            _containerWindow.width = _loc2_.width;
            _containerWindow.height = var_151 + var_37.pulldownBarHeight;
            var_324.width = 0 - 0;
            var_324.height = var_151;
            var_324.x = _containerWindow.x;
            var_324.y = _containerWindow.y;
            var_137.width = 0 - 0;
            var_137.height = var_151;
            if(historyViewerActive())
            {
               reAlignItemsToHistoryContent();
            }
            var_37.containerResized(_containerWindow.rectangle,true);
         }
         alignItems();
      }
      
      private function getAreaBottom() : Number
      {
         if(historyViewerActive())
         {
            return var_137.height;
         }
         return var_151 + _containerWindow.y;
      }
      
      private function purgeItems() : void
      {
         var _loc2_:* = null;
         if(historyViewerActive())
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         while(_itemList.length > var_1886)
         {
            _loc2_ = _itemList.shift();
            _loc3_ = var_220.indexOf(_loc2_);
            if(_loc3_ > -1)
            {
               var_220.splice(_loc3_,1);
            }
            if(_loc2_.view != null)
            {
               var_137.removeChild(_loc2_.view);
               _loc2_.hideView();
            }
            _loc2_.dispose();
            _loc2_ = null;
         }
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         for(; _loc1_ < _itemList.length; _loc1_++)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.y > -const_470)
               {
                  _loc4_ = true;
               }
               _loc2_.aboveLevels = 1;
               if(_loc2_.view != null)
               {
                  _loc3_ = var_220.indexOf(_loc2_);
                  if(_loc3_ > -1)
                  {
                     var_220.splice(_loc3_,1);
                  }
                  var_137.removeChild(_loc2_.view);
                  _loc2_.hideView();
               }
               continue;
               break;
            }
         }
         if(false)
         {
            _loc4_ = true;
         }
         if(getTotalContentHeight() > const_89 && !_loc4_ && !historyViewerActive())
         {
            if(var_37 != null)
            {
               stretchAreaBottomTo(_containerWindow.y);
               alignItems();
               if(!historyViewerActive())
               {
                  var_37.showHistoryViewer();
               }
               if(!historyViewerVisible())
               {
                  var_37.visible = true;
               }
            }
         }
         else if(historyViewerVisible())
         {
            var_37.visible = false;
         }
      }
      
      public function stretchAreaBottomBy(param1:Number) : void
      {
         var _loc2_:Number = _containerWindow.rectangle.bottom + param1 - 0;
         stretchAreaBottomTo(_loc2_);
      }
      
      private function activateItemFromBuffer() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(false)
         {
            return;
         }
         if(historyViewerMinimized())
         {
            resetArea();
            hideHistoryViewer();
         }
         if(!checkLastItemAllowsAdding(var_70[0]))
         {
            selectItemsToMove();
            moveItemsUp(getItemSpacing(_itemList["-1"],var_70[0]));
            if(!checkLastItemAllowsAdding(var_70[0]))
            {
               var_137.height += const_89;
               if(var_37 != null)
               {
                  var_37.containerResized(_containerWindow.rectangle);
               }
            }
         }
         _loc1_ = var_70.shift();
         if(_loc1_ != null)
         {
            _loc1_.renderView();
            _loc2_ = _loc1_.view;
            if(_loc2_ != null)
            {
               var_137.addChild(_loc2_);
               _loc1_.timestamp = new Date().time;
               _itemList.push(_loc1_);
               _loc3_ = 0;
               if(false)
               {
                  _loc3_ = _itemList["-2"].screenLevel;
                  if(historyViewerActive())
                  {
                     _loc1_.screenLevel = _loc3_ + 1;
                  }
                  else
                  {
                     _loc1_.screenLevel = _loc3_ + Math.max(var_441,1);
                  }
               }
               else
               {
                  _loc1_.screenLevel = 100;
               }
               _loc1_.aboveLevels = var_441;
               if(_loc1_.aboveLevels > const_468 + const_330 + 2)
               {
                  _loc1_.aboveLevels = const_468 + const_330 + 2;
               }
               var_441 = 0;
               setChatItemLocHorizontal(_loc1_);
               setChatItemLocVertical(_loc1_);
               setChatItemRenderable(_loc1_);
            }
         }
      }
      
      public function stretchAreaBottomTo(param1:Number) : void
      {
         var _loc2_:int = _containerWindow.context.getDesktopWindow().height - 0;
         param1 = Math.min(param1,_loc2_);
         var_151 = param1 - 0;
         _containerWindow.height = var_151 + RoomChatHistoryPulldown.const_68;
         if(var_37 != null)
         {
            var_37.containerResized(_containerWindow.rectangle);
         }
      }
      
      public function onItemMouseClick(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
         if(param5.shiftKey)
         {
            if(var_37 != null)
            {
               var_37.toggleHistoryViewer();
            }
            return;
         }
         var _loc6_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_266,param1,param2);
         messageListener.processWidgetMessage(_loc6_);
         var _loc7_:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.const_545,param1,param3,param4);
         messageListener.processWidgetMessage(_loc7_);
      }
      
      private function selectItemsToMove() : void
      {
         var _loc4_:* = null;
         if(_isAnimating)
         {
            return;
         }
         purgeItems();
         var_220 = new Array();
         var _loc1_:int = new Date().time;
         var _loc2_:int = 0;
         if(false)
         {
            var_441 = 1;
            return;
         }
         if(historyViewerActive())
         {
            return;
         }
         ++var_441;
         var _loc3_:int = -1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _itemList[_loc3_];
            if(_loc4_.view != null)
            {
               if(_loc4_.screenLevel > const_330 || _loc4_.screenLevel == _loc2_ - 1 || _loc1_ - _loc4_.timestamp >= const_1037)
               {
                  _loc4_.timestamp = _loc1_;
                  _loc2_ = _loc4_.screenLevel;
                  --_loc4_.screenLevel;
                  var_220.push(_loc4_);
               }
            }
            _loc3_--;
         }
      }
      
      public function enableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_70.length)
         {
            _loc1_ = var_70[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
      }
      
      public function reAlignItemsToHistoryContent() : void
      {
         if(historyViewerActive())
         {
            var_137.height = getTotalContentHeight() + const_264;
            alignItems();
         }
      }
      
      private function setChatItemRenderable(param1:RoomChatItem) : void
      {
         if(param1 != null)
         {
            if(param1.y < -const_470)
            {
               if(param1.view != null)
               {
                  var_137.removeChild(param1.view);
                  param1.hideView();
               }
            }
            else if(param1.view == null)
            {
               param1.renderView();
               if(param1.view != null)
               {
                  var_137.addChild(param1.view);
               }
            }
         }
      }
      
      private function historyViewerMinimized() : Boolean
      {
         return true;
      }
      
      private function moveItemsUp(param1:int) : void
      {
         var _loc3_:Boolean = false;
         if(var_220 == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc2_:* = null;
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         while(_loc5_ >= 0)
         {
            _loc2_ = var_220[_loc5_];
            if(_loc2_ != null)
            {
               if(_loc4_ == -1)
               {
                  _loc4_ = _itemList.indexOf(_loc2_);
               }
               else
               {
                  _loc4_++;
               }
               _loc3_ = true;
               if(historyViewerActive())
               {
                  if(_loc2_.y - param1 + _loc2_.height < 0)
                  {
                     _loc3_ = false;
                  }
               }
               if(_loc4_ > 0)
               {
                  if(_itemList[_loc4_ - 1].view != null)
                  {
                     if(_loc2_.y - param1 - _itemList[_loc4_ - 1].y < getItemSpacing(_itemList[_loc4_ - 1],_loc2_))
                     {
                        _loc3_ = false;
                     }
                  }
               }
               if(_loc3_)
               {
                  _loc2_.y -= param1;
               }
            }
            _loc5_--;
         }
      }
      
      private function historyViewerActive() : Boolean
      {
         return var_37 == null ? false : Boolean(var_37.active);
      }
      
      private function getItemSpacing(param1:RoomChatItem, param2:RoomChatItem) : Number
      {
         if(param1.checkOverlap(param2.x,param1.y,param2.width,param2.height))
         {
            return const_89;
         }
         return const_1040;
      }
      
      public function onItemMouseDown(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
         if(historyViewerVisible())
         {
            return;
         }
         if(var_37 != null)
         {
            var_37.beginDrag(param5.stageY);
         }
      }
      
      private function historyViewerVisible() : Boolean
      {
         return var_37 == null ? false : Boolean(var_37.visible);
      }
   }
}
