package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class SendMsgsCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1306:String;
      
      private var var_1115:int;
      
      private var var_703:IDropMenuWindow;
      
      private var var_53:ModerationManager;
      
      private var var_368:ITextFieldWindow;
      
      private var var_56:IFrameWindow;
      
      private var var_283:Boolean = true;
      
      public function SendMsgsCtrl(param1:ModerationManager, param2:int, param3:String)
      {
         super();
         var_53 = param1;
         var_1115 = param2;
         var_1306 = param3;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_278)
         {
            return;
         }
         if(!var_283)
         {
            return;
         }
         var_368.text = "";
         var_283 = false;
      }
      
      public function getFrame() : IFrameWindow
      {
         return var_56;
      }
      
      private function onSendMessageButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Sending message...");
         if(var_283 || false)
         {
            var_53.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         var_53.connection.send(new ModMessageMessageComposer(var_1115,var_368.text));
         this.dispose();
      }
      
      public function getId() : String
      {
         return var_1306;
      }
      
      private function prepareMsgSelect(param1:IDropMenuWindow) : void
      {
         Logger.log("MSG TEMPLATES: " + var_53.initMsg.messageTemplates.length);
         param1.populate(var_53.initMsg.messageTemplates);
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_51)
         {
            return;
         }
         var _loc3_:String = var_53.initMsg.messageTemplates["null"];
         if(_loc3_ != null)
         {
            var_283 = false;
            var_368.text = _loc3_;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_56 != null)
         {
            var_56.destroy();
            var_56 = null;
         }
         var_703 = null;
         var_368 = null;
         var_53 = null;
      }
      
      private function onAlertClose(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      public function show() : void
      {
         var_56 = IFrameWindow(var_53.getXmlWindow("send_msgs"));
         var_56.caption = "Msg To: " + var_1306;
         var_56.findChildByName("send_message_but").procedure = onSendMessageButton;
         var_368 = ITextFieldWindow(var_56.findChildByName("message_input"));
         var_368.procedure = onInputClick;
         var_703 = IDropMenuWindow(var_56.findChildByName("msgTemplatesSelect"));
         prepareMsgSelect(var_703);
         var_703.procedure = onSelectTemplate;
         var _loc1_:IWindow = var_56.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_56.visible = true;
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1270;
      }
   }
}
