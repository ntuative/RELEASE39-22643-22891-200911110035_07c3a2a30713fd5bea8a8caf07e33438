package com.sulake.habbo.communication
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.enum.ConnectionType;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.protocol.IProtocol;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.communication.enum.HabboConnectionType;
   import com.sulake.habbo.communication.enum.HabboProtocolType;
   import com.sulake.habbo.communication.protocol.WedgieProtocol;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import com.sulake.iid.IIDCoreCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboCommunicationManager extends Component implements IHabboCommunicationManager
   {
       
      
      private var var_623:int = 0;
      
      private var var_42:String = "";
      
      private var var_334:int = -1;
      
      private var var_291:Array;
      
      private var var_1207:Timer;
      
      private var var_735:ICoreCommunicationManager;
      
      private var _habboConfiguration:IHabboConfigurationManager;
      
      private var var_859:IMessageConfiguration;
      
      private var _connection:IConnection;
      
      public function HabboCommunicationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_859 = new HabboMessages();
         var_291 = [];
         var_1207 = new Timer(100,1);
         super(param1,param2,param3);
         this.queueInterface(new IIDCoreCommunicationManager(),onCoreCommunicationManagerInit);
         this.queueInterface(new IIDHabboConfigurationManager(),onHabboConfigurationInit);
      }
      
      public function get port() : int
      {
         if(var_334 < 0 || var_334 >= var_291.length)
         {
            return 0;
         }
         return var_291[var_334];
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         Logger.log("[HabboCommunicationManager] IO Error: " + param1.text);
         switch(param1.type)
         {
            case IOErrorEvent.IO_ERROR:
               break;
            case IOErrorEvent.DISK_ERROR:
               break;
            case IOErrorEvent.NETWORK_ERROR:
               break;
            case IOErrorEvent.VERIFY_ERROR:
         }
         tryNextPort();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         Logger.log("[HabboCommunicationManager] Security Error: " + param1.text);
      }
      
      private function onConfigurationReady(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         Logger.log("Habbo Communication Manager: init based on configuration: " + _habboConfiguration);
         if(_habboConfiguration != null)
         {
            var_291 = [];
            var_42 = _habboConfiguration.getKey("connection.info.host","fused37-public-proxy-1.hotel.varoke.net");
            _loc2_ = _habboConfiguration.getKey("connection.info.port","25001");
            _loc3_ = _loc2_.split(",");
            for each(_loc4_ in _loc3_)
            {
               var_291.push(parseInt(_loc4_.replace(" ","")));
            }
            Logger.log("Connection Host: " + var_42);
            Logger.log("Connection Ports: " + var_291);
            Logger.log("Habbo Connection Info:" + _connection);
         }
      }
      
      public function set mode(param1:int) : void
      {
         var_623 = param1;
      }
      
      private function onTryNextPort(param1:TimerEvent) : void
      {
         var_1207.stop();
         nextPort();
      }
      
      private function nextPort() : void
      {
         if(var_334 >= var_291.length)
         {
            var_334 = 0;
         }
         else
         {
            ++var_334;
         }
         if(var_334 < var_291.length)
         {
            _connection.init(var_42,var_291[var_334]);
         }
      }
      
      public function initConnection(param1:String) : void
      {
         switch(param1)
         {
            case HabboConnectionType.const_237:
               if(_habboConfiguration == null)
               {
                  Logger.log("Configuration not ready");
                  return;
               }
               if(_connection == null)
               {
                  Logger.log("Connection not ready");
                  return;
               }
               nextPort();
               break;
            default:
               Logger.log("Unknown Habbo Connection Type: " + param1);
         }
      }
      
      public function get mode() : int
      {
         return var_623;
      }
      
      private function onCoreCommunicationManagerInit(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:* = null;
         Logger.log("Habbo Communication Manager: Core Communication Manager found:: " + [param1,param2]);
         if(param2 != null)
         {
            var_735 = param2 as ICoreCommunicationManager;
            var_735.registerProtocolType(HabboProtocolType.const_894,WedgieProtocol);
            _connection = var_735.createConnection(HabboConnectionType.const_237,ConnectionType.const_905);
            _loc3_ = var_735.getProtocolInstanceOfType(HabboProtocolType.const_894);
            _connection.registerMessageClasses(var_859);
            _connection.protocol = _loc3_;
            _connection.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
            _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         }
      }
      
      public function addHabboConnectionMessageEvent(param1:IMessageEvent) : void
      {
         return var_735.addConnectionMessageEvent(HabboConnectionType.const_237,param1);
      }
      
      private function onHabboConfigurationInit(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            _habboConfiguration = param2 as IHabboConfigurationManager;
            (_habboConfiguration as Component).events.addEventListener(HabboConfigurationEvent.INIT,onConfigurationReady);
         }
      }
      
      public function habboWebLogin(param1:String, param2:String) : IHabboWebLogin
      {
         var _loc3_:String = "";
         _loc3_ = _habboConfiguration.getKey("url.prefix",_loc3_);
         _loc3_ = _loc3_.replace("http://","");
         _loc3_ = _loc3_.replace("https://","");
         return new HabboWebLogin(param1,param2,_loc3_);
      }
      
      private function tryNextPort() : void
      {
         if(var_334 < var_291.length)
         {
            var_1207.addEventListener(TimerEvent.TIMER,onTryNextPort);
            var_1207.start();
         }
      }
      
      public function getHabboMainConnection(param1:Function) : IConnection
      {
         return var_735.queueConnection(HabboConnectionType.const_237,param1);
      }
   }
}
