package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRedeemClubPromoMessage;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class ClubPromoView
   {
      
      public static const const_383:String = "CPV_MODE_TRIAL";
      
      public static const const_1073:String = "CPV_MODE_FULL";
       
      
      private var var_623:String;
      
      private var _widget:MeMenuWidget;
      
      private const const_1045:String = "avatareditor_club_promo_image";
      
      private var _window:IBorderWindow;
      
      public function ClubPromoView(param1:MeMenuWidget, param2:String = "", param3:String = "CPV_MODE_FULL")
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         super();
         if(param1 == null)
         {
            return;
         }
         _widget = param1;
         var_623 = param3;
         var _loc4_:XmlAsset = _widget.assets.getAssetByName("memenu_clothes_club_promo") as XmlAsset;
         _window = _widget.windowManager.buildFromXML(_loc4_.content as XML) as IBorderWindow;
         addEventListener(_window.findChildByName("supported_phones"),onShowSupportedPhones);
         addEventListener(_window.findChildByName("more_info"),onMoreInfo);
         addEventListener(_window.findChildByName("redeem"),onRedeem);
         if(!setPromoImage() && param2 != "")
         {
            _loc7_ = new URLRequest(param2);
            _loc8_ = _widget.assets.loadAssetFromFile(const_1045,_loc7_,"image/png");
            _loc8_.addEventListener(AssetLoaderEvent.const_30,onPromoImageReady);
         }
         if(param3 == const_383)
         {
            _loc5_ = _widget.localizations.getKey("avatareditor.promo.trial.instructions");
         }
         else
         {
            _loc5_ = _widget.localizations.getKey("avatareditor.promo.instructions");
         }
         while(_loc5_.indexOf("\\n") != -1)
         {
            _loc5_ = _loc5_.replace("\\n","\n");
         }
         var _loc6_:ITextWindow = _window.findChildByName("instructions") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.text = _loc5_;
         }
         _loc6_ = _window.findChildByName("title") as ITextWindow;
         if(_loc6_ != null)
         {
            if(param3 == const_383)
            {
               _loc6_.text = _widget.localizations.getKey("avatareditor.promo.trial.title");
            }
            else
            {
               _loc6_.text = _widget.localizations.getKey("avatareditor.promo.title");
            }
         }
      }
      
      private function onMoreInfo(param1:WindowMouseEvent) : void
      {
         _widget.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.const_420));
      }
      
      public function addEventListener(param1:IWindow, param2:Function) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,param2);
      }
      
      private function setPromoImage() : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:IBitmapWrapperWindow = _window.findChildByName("image") as IBitmapWrapperWindow;
         if(_loc1_ == null)
         {
            return false;
         }
         if(_widget.assets.hasAsset(const_1045))
         {
            _loc2_ = _widget.assets.getAssetByName(const_1045) as BitmapDataAsset;
            _loc3_ = (_loc2_.content as BitmapData).clone();
            _loc1_.width = _loc3_.width;
            _loc1_.height = _loc3_.height;
            _loc1_.bitmap = _loc3_;
            return true;
         }
         return false;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      private function onShowSupportedPhones(param1:WindowMouseEvent) : void
      {
         _widget.windowManager.alert("${avatareditor.promo.supportedphones.title}","${avatareditor.promo.supportedphones}",0,closeAlert);
      }
      
      private function onPromoImageReady(param1:AssetLoaderEvent) : void
      {
         setPromoImage();
      }
      
      private function onRedeem(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc2_ == null || _loc2_.text == "")
         {
            return;
         }
         _loc3_ = new RoomWidgetRedeemClubPromoMessage(RoomWidgetRedeemClubPromoMessage.const_565,_loc2_.text,var_623 == const_383);
         _widget.messageListener.processWidgetMessage(_loc3_);
      }
      
      private function closeAlert(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      public function dispose() : void
      {
         _widget = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
   }
}
