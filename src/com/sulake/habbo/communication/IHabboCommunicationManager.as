package com.sulake.habbo.communication
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUnknown;
   
   public interface IHabboCommunicationManager extends IUnknown
   {
       
      
      function get port() : int;
      
      function get mode() : int;
      
      function set mode(param1:int) : void;
      
      function getHabboMainConnection(param1:Function) : IConnection;
      
      function habboWebLogin(param1:String, param2:String) : IHabboWebLogin;
      
      function addHabboConnectionMessageEvent(param1:IMessageEvent) : void;
      
      function initConnection(param1:String) : void;
   }
}
