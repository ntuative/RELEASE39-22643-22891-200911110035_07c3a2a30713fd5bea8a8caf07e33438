package com.sulake.habbo.help.cfh
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.HelpViewController;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class CallForHelpSentView extends HelpViewController implements IHelpViewController
   {
       
      
      public function CallForHelpSentView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         super.windowProcedure(param1,param2);
      }
      
      override public function render() : void
      {
         super.render();
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("help_cfh_thanks") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
      }
   }
}
