package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetGetEffectsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectEffectMessage;
   
   public class MeMenuEffectsView implements IMeMenuView
   {
      
      public static const const_767:Number = 55;
       
      
      private var _widget:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      private var var_482:Array;
      
      private var _effectsContainer:IWindowContainer;
      
      public function MeMenuEffectsView()
      {
         super();
      }
      
      public function get widget() : MeMenuWidget
      {
         return _widget;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function disposeEffects() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_482)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_482 = [];
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("memenu_effects") as XmlAsset;
         _window = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.name = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _window.numChildren)
         {
            _loc3_ = _window.getChildAt(_loc4_);
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            _loc4_++;
         }
         _effectsContainer = _window.findChildByName("effects_cnvs") as IWindowContainer;
         _widget.mainContainer.addChild(_window);
         _widget.messageListener.processWidgetMessage(new RoomWidgetGetEffectsMessage());
      }
      
      public function selectEffect(param1:EffectView) : void
      {
         if(param1.effect.isInUse)
         {
            _widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.const_519,param1.effect.type));
         }
         else
         {
            _widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.const_687,param1.effect.type));
         }
      }
      
      public function dispose() : void
      {
         disposeEffects();
         var_482 = null;
         _widget = null;
         _window.dispose();
         _window = null;
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         _widget = param1;
         var_482 = new Array();
         createWindow(param2);
      }
      
      private function onResized(param1:WindowEvent) : void
      {
         _window.x = 0;
         _window.y = 0;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindow = param1.target as IWindow;
         var _loc4_:String = _loc3_.name;
         switch(_loc4_)
         {
            case "back_btn":
               _widget.changeView(MeMenuWidget.const_153);
               break;
            case "moreEffects_btn":
               _widget.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage(RoomWidgetOpenInventoryMessage.const_744));
               break;
            case "hideEffects_btn":
               _widget.messageListener.processWidgetMessage(new RoomWidgetSelectEffectMessage(RoomWidgetSelectEffectMessage.const_637));
               break;
            default:
               Logger.log("Me Menu Effects View: unknown button: " + _loc4_);
         }
      }
      
      private function showInfoText(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function updateEffects(param1:Array) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         disposeEffects();
         var _loc2_:int = 0;
         showInfoText(param1.length == 0);
         for each(_loc3_ in param1)
         {
            _loc6_ = new EffectView();
            _loc6_.init(this,"active_effect_" + _loc2_,_loc3_);
            var_482.push(_loc6_);
            _loc6_.window.y = _loc2_ * const_767;
            _loc2_++;
         }
         _loc4_ = 0;
         _loc5_ = 0 * const_767;
         _effectsContainer.height = Math.max(_loc5_,50);
         _window.height += 0 - _loc4_;
         _widget.updateSize();
         return false;
      }
      
      public function get effectsContainer() : IWindowContainer
      {
         return _effectsContainer;
      }
   }
}
