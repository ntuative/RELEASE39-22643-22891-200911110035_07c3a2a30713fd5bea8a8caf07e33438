package com.sulake.core.runtime
{
   import com.sulake.core.utils.ErrorReportStorage;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public interface ICore extends IContext
   {
       
      
      function initialize() : void;
      
      function readConfigDocument(param1:XML, param2:ICoreConfigStatusListener = null) : void;
      
      function getLastDebugMessage() : String;
      
      function get events() : IEventDispatcher;
      
      function get stateStorage() : ErrorReportStorage;
      
      function getLastErrorMessage() : String;
      
      function loadExternalConfigDocument(param1:URLRequest, param2:ICoreConfigStatusListener = null) : void;
   }
}
