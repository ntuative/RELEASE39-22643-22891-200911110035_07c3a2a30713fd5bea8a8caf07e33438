package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarActionUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetDanceUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetWaveUpdateEvent;
   import com.sulake.habbo.widget.memenu.enum.HabboMeMenuTrackingEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuWidget extends RoomWidgetBase
   {
      
      public static const const_551:String = "me_menu_settings_view";
      
      private static const const_712:int = 10;
      
      public static const const_574:String = "me_menu_effects_view";
      
      public static const const_153:String = "me_menu_top_view";
      
      public static const const_1274:String = "me_menu_rooms_view";
      
      public static const const_749:String = "me_menu_dance_moves_view";
      
      public static const const_253:String = "me_menu_my_clothes_view";
       
      
      private var var_1728:Boolean = false;
      
      private var _isAnimating:Boolean = false;
      
      private var var_67:IEventDispatcher;
      
      private var var_1729:int = 0;
      
      private var var_1730:Boolean = false;
      
      private var var_318:Boolean = false;
      
      private var var_1731:int = 0;
      
      private var var_1528:Number = 0;
      
      private var _mainContainer:IWindowContainer;
      
      private var var_496:Boolean = false;
      
      private var var_95:ClubPromoView;
      
      private var var_1085:int = 0;
      
      private var var_895:Point;
      
      private var var_43:IMeMenuView;
      
      public function MeMenuWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IEventDispatcher = null)
      {
         super(param1,param2,param3);
         var_895 = new Point(0,0);
         var_67 = param4;
         changeView(const_153);
         hide();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetWaveUpdateEvent.const_619,onWaveEvent);
         param1.addEventListener(RoomWidgetDanceUpdateEvent.const_659,onDanceEvent);
         param1.addEventListener(RoomWidgetUpdateEffectsUpdateEvent.const_627,onUpdateEffects);
         param1.addEventListener(RoomWidgetToolbarClickedUpdateEvent.const_556,onToolbarClicked);
         param1.addEventListener(RoomWidgetFrameUpdateEvent.const_283,onUpdate);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_549,onAvatarEditorClosed);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_374,onShowAvatarEditorClubPromo);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_903,onHideAvatarEditorClubPromo);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_196,onAvatarDeselected);
         param1.addEventListener(RoomWidgetHabboClubUpdateEvent.const_210,onHabboClubEvent);
         param1.addEventListener(RoomWidgetAvatarActionUpdateEvent.const_543,onAvatarActionEvent);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_257,onUserInfo);
         param1.addEventListener(RoomWidgetSettingsUpdateEvent.const_281,onSettingsUpdate);
         super.registerUpdateEvents(param1);
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         if(!_isAnimating)
         {
            return;
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         return _mainContainer;
      }
      
      public function get hasEffectOn() : Boolean
      {
         return var_496;
      }
      
      private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent) : void
      {
         if(!var_318)
         {
            return;
         }
         if(var_43.window.name == const_551)
         {
            (var_43 as MeMenuSettingsView).updateSettings(param1);
         }
      }
      
      public function get isHabboClubActive() : Boolean
      {
         return var_1085 > 0;
      }
      
      private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Wave Event received");
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var _loc2_:* = null;
         if(!(var_318 && var_43.window.name == const_253))
         {
            _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.const_588);
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(_loc2_);
            }
         }
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetWaveUpdateEvent.const_619,onWaveEvent);
         param1.removeEventListener(RoomWidgetDanceUpdateEvent.const_659,onDanceEvent);
         param1.removeEventListener(RoomWidgetUpdateEffectsUpdateEvent.const_627,onUpdateEffects);
         param1.removeEventListener(RoomWidgetToolbarClickedUpdateEvent.const_556,onToolbarClicked);
         param1.removeEventListener(RoomWidgetFrameUpdateEvent.const_283,onUpdate);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_196,onAvatarDeselected);
         param1.removeEventListener(RoomWidgetHabboClubUpdateEvent.const_210,onHabboClubEvent);
         param1.removeEventListener(RoomWidgetAvatarActionUpdateEvent.const_543,onAvatarActionEvent);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_549,onAvatarEditorClosed);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_374,onShowAvatarEditorClubPromo);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_903,onHideAvatarEditorClubPromo);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_257,onUserInfo);
         param1.removeEventListener(RoomWidgetSettingsUpdateEvent.const_281,onSettingsUpdate);
      }
      
      override public function dispose() : void
      {
         hide();
         var_67 = null;
         if(var_43 != null)
         {
            var_43.dispose();
            var_43 = null;
         }
         super.dispose();
      }
      
      public function get allowHabboClubDances() : Boolean
      {
         return var_1728;
      }
      
      public function changeToOutfit(param1:int) : void
      {
         var_1528 = new Date().valueOf();
         this.messageListener.processWidgetMessage(new RoomWidgetSelectOutfitMessage(param1));
      }
      
      private function onHideAvatarEditorClubPromo(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_95 != null)
         {
            var_95.dispose();
            var_95 = null;
         }
         updateSize();
      }
      
      public function get isDancing() : Boolean
      {
         return var_1730;
      }
      
      public function hide(param1:RoomWidgetRoomObjectUpdateEvent = null) : void
      {
         var _loc2_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.const_521);
         _loc2_.window = _mainContainer.parent as IWindowContainer;
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
         if(var_43 != null)
         {
            _mainContainer.removeChild(var_43.window);
            var_43.dispose();
            var_43 = null;
         }
         var_318 = false;
         var_67.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE));
      }
      
      public function canChangeOutfit() : Boolean
      {
         var _loc1_:Number = new Date().valueOf();
         return _loc1_ - var_1528 > 5000;
      }
      
      public function get habboClubPeriods() : int
      {
         return var_1729;
      }
      
      private function onAvatarActionEvent(param1:RoomWidgetAvatarActionUpdateEvent) : void
      {
         switch(param1.actionType)
         {
            case RoomWidgetAvatarActionUpdateEvent.EFFECT_ACTIVE:
               var_496 = true;
               break;
            case RoomWidgetAvatarActionUpdateEvent.EFFECT_INACTIVE:
               var_496 = false;
               break;
            default:
               trace("MeMenuWidget: unknown avatar action event: " + param1.actionType);
         }
      }
      
      private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent) : void
      {
         var _loc2_:* = var_1085 > 0;
         var_1085 = param1.daysLeft;
         var_1729 = param1.periodsLeft;
         var_1731 = param1.pastPeriods;
         var_1728 = param1.allowClubDances;
         if(_loc2_ != param1.daysLeft > 0)
         {
            if(var_43 != null)
            {
               changeView(var_43.window.name);
            }
         }
      }
      
      public function get mainContainer() : IWindowContainer
      {
         if(_mainContainer == null)
         {
            _mainContainer = windowManager.createWindow("me_menu_main_container","",HabboWindowType.const_1135,HabboWindowStyle.const_824,HabboWindowParam.const_38,new Rectangle(0,0,170,260)) as IWindowContainer;
            _mainContainer.tags.push("room_widget_me_menu");
         }
         return _mainContainer;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         var_1730 = param1;
      }
      
      private function onAvatarDeselected(param1:Event) : void
      {
         if(var_43 != null && var_43.window.name != const_253)
         {
            hide();
         }
      }
      
      private function onShowAvatarEditorClubPromo(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         var _loc2_:* = null;
         if(var_43 != null && var_43.window.name == const_253)
         {
            if(param1.promoMode == RoomWidgetAvatarEditorUpdateEvent.const_756)
            {
               var_95 = new ClubPromoView(this,param1.promoImageUrl,ClubPromoView.const_1073);
            }
            else
            {
               var_95 = new ClubPromoView(this,param1.promoImageUrl,ClubPromoView.const_383);
            }
            _loc2_ = _mainContainer.getChildByName(var_43.window.name);
            if(_loc2_ != null)
            {
               var_95.window.x = _loc2_.width + const_712;
               _mainContainer.addChild(var_95.window);
               _mainContainer.width = var_95.window.x + var_95.window.width;
            }
         }
      }
      
      private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent) : void
      {
         var _loc2_:* = null;
         var_496 = false;
         for each(_loc2_ in param1.effects)
         {
            if(_loc2_.isInUse)
            {
               var_496 = true;
            }
         }
         if(var_43 != null && var_43.window.name == const_574)
         {
            (var_43 as MeMenuEffectsView).updateEffects(param1.effects);
         }
      }
      
      public function get habboClubPastPeriods() : int
      {
         return var_1731;
      }
      
      public function get habboClubDays() : int
      {
         return var_1085;
      }
      
      public function updateSize() : void
      {
         if(var_43 != null)
         {
            var_895.x = var_43.window.width + 10;
            var_895.y = var_43.window.height;
            var_43.window.x = 5;
            var_43.window.y = 0;
            _mainContainer.width = var_895.x;
            _mainContainer.height = var_895.y;
            if(var_95 != null)
            {
               _mainContainer.width = var_95.window.x + var_95.window.width + const_712;
            }
         }
      }
      
      private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent) : void
      {
         switch(param1.iconType)
         {
            case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU:
               var_318 = !var_318;
               break;
            case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO:
               var_318 = false;
               break;
            default:
               return;
         }
         if(var_318)
         {
            show();
         }
         else
         {
            hide();
         }
      }
      
      private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Dance Event received, style: " + param1.style);
      }
      
      private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_43 != null && var_43.window.name == const_253)
         {
            if(var_95 != null)
            {
               var_95.dispose();
               var_95 = null;
            }
            changeView(const_153);
         }
      }
      
      public function changeView(param1:String) : void
      {
         var _loc2_:* = null;
         if(var_95 != null)
         {
            var_95.dispose();
            var_95 = null;
         }
         switch(param1)
         {
            case const_153:
               _loc2_ = new MeMenuMainView();
               var_67.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT));
               break;
            case const_574:
               _loc2_ = new MeMenuEffectsView();
               var_67.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_EFFECTS));
               break;
            case const_749:
               _loc2_ = new MeMenuDanceView();
               var_67.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE));
               break;
            case const_253:
               _loc2_ = new MeMenuClothesView();
               break;
            case const_1274:
               _loc2_ = new MeMenuRoomsView();
               break;
            case const_551:
               _loc2_ = new MeMenuSettingsView();
               break;
            default:
               Logger.log("Me Menu Change view: unknown view: " + param1);
         }
         if(_loc2_ != null)
         {
            if(var_43 != null)
            {
               _mainContainer.removeChild(var_43.window);
               var_43.dispose();
               var_43 = null;
            }
            var_43 = _loc2_;
            var_43.init(this,param1);
         }
         updateSize();
      }
      
      private function show() : void
      {
         changeView(const_153);
         var _loc1_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.const_487);
         _loc1_.window = _mainContainer.parent as IWindowContainer;
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
         var_318 = true;
      }
   }
}
