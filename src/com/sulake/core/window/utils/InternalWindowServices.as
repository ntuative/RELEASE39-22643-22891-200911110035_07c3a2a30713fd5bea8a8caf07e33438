package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindowContext;
   import flash.display.DisplayObject;
   
   public class InternalWindowServices implements IInternalWindowServices
   {
       
      
      private var var_119:DisplayObject;
      
      private var var_2065:uint;
      
      private var var_700:IWindowToolTipAgentService;
      
      private var var_697:IWindowMouseScalingService;
      
      private var var_357:IWindowContext;
      
      private var var_698:IWindowFocusManagerService;
      
      private var var_696:IWindowMouseListenerService;
      
      private var var_699:IWindowMouseDraggingService;
      
      public function InternalWindowServices(param1:IWindowContext, param2:DisplayObject)
      {
         super();
         var_2065 = 0;
         var_119 = param2;
         var_357 = param1;
         var_699 = new WindowMouseDragger(param2);
         var_697 = new WindowMouseScaler(param2);
         var_696 = new WindowMouseListener(param2);
         var_698 = new FocusManager(param2);
         var_700 = new WindowToolTipAgent(param2);
      }
      
      public function getMouseScalingService() : IWindowMouseScalingService
      {
         return var_697;
      }
      
      public function getFocusManagerService() : IWindowFocusManagerService
      {
         return var_698;
      }
      
      public function getToolTipAgentService() : IWindowToolTipAgentService
      {
         return var_700;
      }
      
      public function dispose() : void
      {
         if(var_699 != null)
         {
            var_699.dispose();
            var_699 = null;
         }
         if(var_697 != null)
         {
            var_697.dispose();
            var_697 = null;
         }
         if(var_696 != null)
         {
            var_696.dispose();
            var_696 = null;
         }
         if(var_698 != null)
         {
            var_698.dispose();
            var_698 = null;
         }
         if(var_700 != null)
         {
            var_700.dispose();
            var_700 = null;
         }
         var_357 = null;
      }
      
      public function getMouseListenerService() : IWindowMouseListenerService
      {
         return var_696;
      }
      
      public function getMouseDraggingService() : IWindowMouseDraggingService
      {
         return var_699;
      }
   }
}
