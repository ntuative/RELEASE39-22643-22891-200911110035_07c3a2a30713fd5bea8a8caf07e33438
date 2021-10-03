package com.sulake.habbo.help.cfh
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.HelpViewController;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class CallForHelpPendingItemView extends HelpViewController implements IHelpViewController
   {
       
      
      public function CallForHelpPendingItemView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("* CFH Pending Item windowEventProc " + param1.type + "/" + param2.name);
         switch(param2.name)
         {
            case "cfh_delete":
               main.sendMessage(new DeletePendingCallsForHelpMessageComposer());
               break;
            case "cfh_cancel":
               main.showUI(HabboHelpViewEnum.const_129);
               break;
            default:
               super.windowProcedure(param1,param2);
         }
      }
      
      override public function render() : void
      {
         super.render();
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("help_cfh_pending") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
      }
   }
}
