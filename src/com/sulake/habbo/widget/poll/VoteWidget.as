package com.sulake.habbo.widget.poll
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetVoteUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetVoteMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class VoteWidget extends RoomWidgetBase
   {
       
      
      private var var_1156:int = -1;
      
      private var var_615:Array = null;
      
      private var _window:IFrameWindow;
      
      private var var_1569:int;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_1155:int = 30000;
      
      private var var_1154:Boolean = false;
      
      private var var_952:Array = null;
      
      private var _list:IItemListWindow;
      
      public function VoteWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager)
      {
         super(param1,param2,param3);
         _config = param4;
         if(_config != null)
         {
            var_1155 = int(_config.getKey("vote.time.limit","30000"));
         }
      }
      
      private function createChoice(param1:int, param2:String) : IWindow
      {
         var _loc3_:XmlAsset = assets.getAssetByName("vote_choice") as XmlAsset;
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:IWindowContainer = windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:ITextWindow = _loc4_.findChildByName("text") as ITextWindow;
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:IButtonWindow = _loc4_.findChildByName("button") as IButtonWindow;
         if(_loc6_ == null)
         {
            return null;
         }
         _loc6_.id = param1;
         _loc6_.caption = String.fromCharCode(97 + param1);
         _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onChoiceClicked);
         _loc5_.text = param2;
         var _loc7_:IWindowContainer = _loc4_.findChildByName("bg") as IWindowContainer;
         if(_loc7_ != null)
         {
            _loc7_.visible = false;
         }
         return _loc4_;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetVoteUpdateEvent.const_119,showVoteQuestion);
         param1.addEventListener(RoomWidgetVoteUpdateEvent.const_108,showVoteResult);
         param1.addEventListener(RoomWidgetFrameUpdateEvent.const_283,update);
         super.registerUpdateEvents(param1);
      }
      
      private function showVoteQuestion(param1:RoomWidgetVoteUpdateEvent) : void
      {
         var _loc6_:* = null;
         var _loc12_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(!createWindow())
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("question") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = _window.findChildByName("list_container") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.text = param1.question;
         var _loc4_:int = Math.max(_loc2_.textHeight + 10 - _loc2_.height,0);
         _loc2_.scale(0,_loc4_);
         _loc3_.offset(0,_loc4_);
         var _loc5_:Array = param1.choices;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = createChoice(_loc7_,_loc5_[_loc7_]);
            if(_loc6_ == null)
            {
               return;
            }
            _list.addListItem(_loc6_);
            _loc7_++;
         }
         var _loc8_:int = Math.max(_list.scrollableRegion.height - 0,0);
         _loc3_.scale(0,_loc8_);
         _window.scale(0,_loc4_ + _loc8_);
         var _loc9_:IWindow = _window.findChildByName("waiting_text");
         if(_loc9_ != null)
         {
            _loc9_.visible = false;
         }
         var _loc10_:IDesktopWindow = _window.desktop;
         if(_loc10_ != null)
         {
            _loc12_ = new Point(_loc10_.width - 0,_loc10_.height - 0);
            _loc12_.offset(-10,-10);
            _window.setGlobalPosition(_loc12_);
         }
         _window.visible = true;
         var_1156 = -1;
         var_1569 = getTimer();
         var_1154 = true;
         updateTimer(0);
         var _loc11_:IWindow = _window.findChildByName("timer");
         if(_loc11_ != null)
         {
            _loc11_.visible = true;
         }
      }
      
      private function createWindow() : Boolean
      {
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc1_:XmlAsset = assets.getAssetByName("vote_question") as XmlAsset;
         _window = windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
         if(_window == null)
         {
            return false;
         }
         _list = _window.findChildByName("choices") as IItemListWindow;
         if(_list == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc2_:IWindow = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,close);
         }
         var _loc3_:IWindow = _window.findChildByName("timer");
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         return true;
      }
      
      private function update(param1:RoomWidgetFrameUpdateEvent) : void
      {
         if(!var_1154)
         {
            return;
         }
         var _loc2_:int = getTimer() - var_1569;
         if(_loc2_ > var_1155)
         {
            vote();
            return;
         }
         updateTimer(_loc2_);
      }
      
      private function showVoteResult(param1:RoomWidgetVoteUpdateEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         if(_window == null || _list == null)
         {
            return;
         }
         _loc2_ = _window.findChildByName("timer");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         _loc2_ = _window.findChildByName("waiting_text");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         if(_list.numListItems != param1.votes.length)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _list.numListItems)
         {
            _loc4_ = _list.getListItemAt(_loc3_) as IWindowContainer;
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.findChildByName("vote_bar") as IBitmapWrapperWindow;
               if(_loc5_ != null)
               {
                  _loc9_ = new BitmapData(_loc5_.width,_loc5_.height,true,0);
                  _loc10_ = int(Number(param1.votes[_loc3_]) / param1.totalVotes * _loc9_.width);
                  if(_loc10_ > 0)
                  {
                     _loc9_.fillRect(new Rectangle(0,0,_loc10_,_loc9_.height),4281571584);
                     _loc5_.bitmap = _loc9_;
                  }
               }
               _loc6_ = _loc4_.findChildByName("bg") as IWindowContainer;
               if(_loc6_ != null)
               {
                  _loc6_.visible = true;
               }
               _loc7_ = _loc4_.findChildByName("text") as ITextWindow;
               if(_loc7_ != null)
               {
                  _loc7_.text = _loc7_.text + " ( " + param1.votes[_loc3_] + "/" + param1.totalVotes + " )";
               }
               _loc8_ = _loc4_.findChildByName("button") as IButtonWindow;
               if(_loc8_ != null)
               {
                  _loc8_.disable();
               }
            }
            _loc3_++;
         }
      }
      
      private function onChoiceClicked(param1:WindowMouseEvent) : void
      {
         if(param1 == null || param1.window == null)
         {
            return;
         }
         vote(param1.window.id);
      }
      
      private function vote(param1:int = -1) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var_1156 = param1;
         var_1154 = false;
         if(param1 >= 0)
         {
            if(messageListener == null)
            {
               return;
            }
            messageListener.processWidgetMessage(new RoomWidgetVoteMessage(param1 + 1));
         }
         if(_window == null || _list == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _list.numListItems)
         {
            _loc2_ = _list.getListItemAt(_loc4_) as IBorderWindow;
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc4_ != var_1156)
            {
               _loc2_.blend = 0.5;
            }
            _loc3_ = _loc2_.findChildByName("button") as IButtonWindow;
            if(_loc3_ == null)
            {
               return;
            }
            _loc3_.disable();
            _loc4_++;
         }
         var _loc5_:IWindow = _window.findChildByName("timer");
         if(_loc5_ != null)
         {
            _loc5_.visible = false;
         }
         var _loc6_:IWindow = _window.findChildByName("waiting_text");
         if(_loc6_ != null)
         {
            _loc6_.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _config = null;
         super.dispose();
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetVoteUpdateEvent.const_119,showVoteQuestion);
         param1.removeEventListener(RoomWidgetVoteUpdateEvent.const_108,showVoteResult);
         param1.removeEventListener(RoomWidgetFrameUpdateEvent.const_283,update);
      }
      
      private function close(param1:Event = null) : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function updateTimer(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(_window == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("timer_bar") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc4_ = Number(param1) / var_1155;
            _loc5_ = new BitmapData(_loc2_.width,_loc2_.height,true,4281571584);
            if(_loc4_ > 0)
            {
               _loc5_.fillRect(new Rectangle(0,0,_loc5_.width,int(_loc5_.height * _loc4_)),4292006610);
            }
            _loc2_.bitmap = _loc5_;
         }
         var _loc3_:ITextWindow = _window.findChildByName("timer_text") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc6_ = Math.max((var_1155 - param1) / 1000,0);
            _loc3_.text = _loc6_ + " s";
         }
      }
   }
}
