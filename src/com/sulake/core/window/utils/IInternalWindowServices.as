package com.sulake.core.window.utils
{
   public interface IInternalWindowServices
   {
       
      
      function getMouseListenerService() : IWindowMouseListenerService;
      
      function getMouseScalingService() : IWindowMouseScalingService;
      
      function getMouseDraggingService() : IWindowMouseDraggingService;
      
      function getFocusManagerService() : IWindowFocusManagerService;
      
      function getToolTipAgentService() : IWindowToolTipAgentService;
   }
}
