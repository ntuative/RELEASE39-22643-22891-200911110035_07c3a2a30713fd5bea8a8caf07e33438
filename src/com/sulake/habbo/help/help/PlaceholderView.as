package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.HelpViewController;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class PlaceholderView extends HelpViewController implements IHelpViewController
   {
       
      
      public function PlaceholderView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
         param2.registerLocalizationParameter("info.client.version","version","22643-22891-200911110010");
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
         container = buildXmlWindow("placeholder") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.background = true;
         container.color = 33554431;
         container.procedure = windowProcedure;
      }
   }
}
