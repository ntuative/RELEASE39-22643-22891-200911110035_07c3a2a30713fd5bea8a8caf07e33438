package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.IHabboWebLogin;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   
   public class HabboLoginDemoView extends EventDispatcher
   {
      
      public static const const_493:String = "InitConnection";
       
      
      private const const_1298:String = "fuselogin";
      
      public var name:String = "";
      
      private var _window:IWindowContainer;
      
      private var var_309:HabboCommunicationDemo;
      
      public var password:String = "";
      
      private var var_111:SSOTicket;
      
      public function HabboLoginDemoView(param1:HabboCommunicationDemo)
      {
         super();
         var_309 = param1;
         createWindow();
      }
      
      public function closeLoginWindow() : void
      {
         var_309.windowManager.removeWindow("habbo_login_window");
      }
      
      public function get useSSOTicket() : Boolean
      {
         var _loc1_:ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
         if(_loc1_ != null)
         {
            return _loc1_.isSelected;
         }
         return false;
      }
      
      private function onParsedTicketSuccess(param1:Event) : void
      {
         Logger.log("Got ticket: undefined");
         var_309.shockwaveClientUrl = var_111.shockwaveClientUrl;
         var_309.ssoTicket = var_111.ticket;
         var_111.removeEventListener(SSOTicket.const_310,onParsedTicketSuccess);
         var_111.removeEventListener(SSOTicket.const_231,onParsedTicketFailure);
         var_111 = null;
         dispatchEvent(new Event(const_493));
      }
      
      private function windowEventProcessor(param1:Event = null, param2:IWindow = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:IWindowContainer = param1.target.parent as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.findChildByName("input001") as ITextFieldWindow;
            _loc5_ = _loc3_.findChildByName("input002") as ITextFieldWindow;
            if(_loc4_ != null)
            {
               name = _loc4_.text;
            }
            if(_loc5_ != null)
            {
               password = _loc5_.text;
            }
            _loc6_ = SharedObject.getLocal(const_1298,"/");
            _loc6_.data.login = name;
            _loc6_.data.password = password;
            _loc6_.flush();
         }
         if(useSSOTicket)
         {
            initSSOTicket();
         }
         else
         {
            dispatchEvent(new Event(const_493));
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = (var_309 as Component).assets.getAssetByName("login_window") as XmlAsset;
         if(_loc1_ == null)
         {
            Logger.log("Could  not find embedded Window XML for Login Window, login_window");
            return;
         }
         _window = var_309.windowManager.createWindow("habbo_login_window","Login",HabboWindowType.const_289,HabboWindowStyle.const_38,0 | 0,new Rectangle(10,10,320,240),null) as IFrameWindow;
         var _loc2_:XML = _loc1_.content as XML;
         var _loc3_:IWindowContainer = var_309.windowManager.buildFromXML(_loc2_) as IWindowContainer;
         _window.addChild(_loc3_);
         _window.width = _loc3_.width + 20;
         _window.height = _loc3_.height + 40;
         _loc3_.x = 10;
         _loc3_.y = 30;
         _window.center();
         var _loc4_:IButtonWindow = _loc3_.findChildByName("button001") as IButtonWindow;
         var _loc5_:ITextFieldWindow = _loc3_.findChildByName("input001") as ITextFieldWindow;
         var _loc6_:ITextFieldWindow = _loc3_.findChildByName("input002") as ITextFieldWindow;
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(WindowMouseEvent.const_109,windowEventProcessor);
         }
         else
         {
            Logger.log("Could not find the button");
         }
         var _loc7_:SharedObject = SharedObject.getLocal(const_1298,"/");
         if(_loc5_ != null)
         {
            _loc5_.textBackground = true;
            _loc5_.textBackgroundColor = 16777215;
            if(_loc7_.data.login != null)
            {
               _loc5_.text = _loc7_.data.login;
            }
         }
         if(_loc6_ != null)
         {
            _loc6_.textBackground = true;
            _loc6_.textBackgroundColor = 16777215;
            if(_loc7_.data.password != null)
            {
               _loc6_.text = _loc7_.data.password;
            }
         }
      }
      
      public function displayResults(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.findChildByName("text002") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function onParsedTicketFailure(param1:Event) : void
      {
         Logger.log("Could not get a ticket! ");
         var_111.removeEventListener(SSOTicket.const_310,onParsedTicketSuccess);
         var_111.removeEventListener(SSOTicket.const_231,onParsedTicketFailure);
         var_111 = null;
         dispatchEvent(new Event(const_493));
      }
      
      private function initSSOTicket() : void
      {
         if(var_111 != null)
         {
            var_111.removeEventListener(SSOTicket.const_310,onParsedTicketSuccess);
            var_111.removeEventListener(SSOTicket.const_231,onParsedTicketFailure);
            var_111 = null;
         }
         var _loc1_:String = "";
         if(false)
         {
            _loc1_ = var_309.habboConfiguration.getKey("url.prefix",_loc1_);
            _loc1_ = _loc1_.replace("http://","");
            _loc1_ = _loc1_.replace("https://","");
         }
         var _loc2_:IHabboWebLogin = var_309.habboCommunication.habboWebLogin(name,password);
         var_111 = new SSOTicket(var_309.assets,_loc2_,_loc1_);
         var_111.addEventListener(SSOTicket.const_310,onParsedTicketSuccess);
         var_111.addEventListener(SSOTicket.const_231,onParsedTicketFailure);
      }
      
      public function dispose() : void
      {
      }
   }
}
